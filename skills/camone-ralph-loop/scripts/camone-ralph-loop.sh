#!/usr/bin/env bash
# camone-ralph-loop — External Ralph Loop for Claude Code
# Original Ralph Wiggum Loop concept by Geoffrey Huntley
# Re-implemented by camone with clean context window per iteration
#
# Each iteration spawns a fresh `claude -p` session, ensuring
# the context window is never polluted by previous attempts.

set -euo pipefail

# ─── Constants ──────────────────────────────────────────────
readonly VERSION="1.1.0"
readonly SCRIPT_NAME="camone-ralph-loop"
readonly DEFAULT_LOG_DIR=".ralph-loop/logs"
readonly STATE_FILE=".ralph-loop/state.json"

# ─── Colors ─────────────────────────────────────────────────
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly DIM='\033[2m'
readonly RESET='\033[0m'

# ─── Global State ───────────────────────────────────────────
MAX_ITERATIONS=0          # 0 = unlimited
COMPLETION_PROMISE=""
AUTO_COMMIT=false
BUDGET_PER_ITERATION=""
TIMEOUT_PER_ITERATION=300 # seconds (default 5 min)
DRY_RUN=false
LOG_DIR="$DEFAULT_LOG_DIR"
PROMPT_SOURCE=""
PROMPT_TEXT=""
ITERATION=0
START_TIME=0
EXIT_REASON=""
CLAUDE_PID=""
TIMER_PID=""

# ─── Signal Handling ────────────────────────────────────────

cleanup_child() {
    if [ -n "$TIMER_PID" ] && kill -0 "$TIMER_PID" 2>/dev/null; then
        kill "$TIMER_PID" 2>/dev/null
        wait "$TIMER_PID" 2>/dev/null || true
    fi
    TIMER_PID=""
    if [ -n "$CLAUDE_PID" ] && kill -0 "$CLAUDE_PID" 2>/dev/null; then
        kill "$CLAUDE_PID" 2>/dev/null
        wait "$CLAUDE_PID" 2>/dev/null || true
    fi
    CLAUDE_PID=""
}

handle_shutdown() {
    local signal="$1"
    echo ""
    echo -e "${YELLOW}${BOLD}⚡ ${signal} detected — shutting down gracefully...${RESET}"
    EXIT_REASON="interrupted"
    cleanup_child
    deactivate_state
    print_summary
    exit 130
}

trap 'handle_shutdown SIGINT' INT
trap 'handle_shutdown SIGTERM' TERM

# ─── Functions ──────────────────────────────────────────────

show_help() {
    cat <<'HELP'
camone-ralph-loop — External Ralph Loop for Claude Code

USAGE:
    camone-ralph-loop [OPTIONS] [PROMPT_FILE_OR_TEXT]

    PROMPT_FILE_OR_TEXT can be:
      - A path to a .md or .txt file containing the prompt
      - Inline text to use as the prompt directly

OPTIONS:
    --max-iterations N            Maximum loop iterations (default: unlimited)
    --completion-promise TEXT      Stop when TEXT detected in output or project files
    --timeout-per-iteration SECS  Timeout per iteration in seconds (default: 300)
    --auto-commit                 Auto git commit after each iteration
    --budget-per-iteration N      USD budget cap per iteration (e.g., 0.50)
    --dry-run                     Show configuration and exit without running
    --log-dir DIR                 Log directory (default: .ralph-loop/logs/)
    -h, --help                    Show this help

EXAMPLES:
    # Run with a prompt file, max 5 iterations
    camone-ralph-loop --max-iterations 5 PROMPT.md

    # Run with inline prompt, stop on completion promise
    camone-ralph-loop --completion-promise "DONE" "Fix all lint errors in src/"

    # Dry run to preview configuration
    camone-ralph-loop --dry-run --max-iterations 10 --auto-commit PROMPT.md

CONCEPT:
    Each iteration spawns a fresh `claude -p` session with a clean context
    window. This avoids context pollution from failed attempts — the core
    insight of Geoffrey Huntley's original Ralph Wiggum Loop.

HELP
}

parse_args() {
    while [ $# -gt 0 ]; do
        case "$1" in
            --max-iterations)
                shift
                MAX_ITERATIONS="${1:?'--max-iterations requires a number'}"
                ;;
            --completion-promise)
                shift
                COMPLETION_PROMISE="${1:?'--completion-promise requires text'}"
                ;;
            --auto-commit)
                AUTO_COMMIT=true
                ;;
            --timeout-per-iteration)
                shift
                TIMEOUT_PER_ITERATION="${1:?'--timeout-per-iteration requires seconds'}"
                ;;
            --budget-per-iteration)
                shift
                BUDGET_PER_ITERATION="${1:?'--budget-per-iteration requires a number'}"
                ;;
            --dry-run)
                DRY_RUN=true
                ;;
            --log-dir)
                shift
                LOG_DIR="${1:?'--log-dir requires a path'}"
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            -*)
                echo -e "${RED}Error: Unknown option '$1'${RESET}" >&2
                echo "Run '$SCRIPT_NAME --help' for usage." >&2
                exit 1
                ;;
            *)
                PROMPT_SOURCE="$1"
                ;;
        esac
        shift
    done

    if [ -z "$PROMPT_SOURCE" ]; then
        echo -e "${RED}Error: No prompt file or text provided.${RESET}" >&2
        echo "Run '$SCRIPT_NAME --help' for usage." >&2
        exit 1
    fi
}

validate_environment() {
    local missing=false

    if ! command -v claude >/dev/null 2>&1; then
        echo -e "${RED}Error: 'claude' CLI not found in PATH.${RESET}" >&2
        missing=true
    fi

    if ! command -v jq >/dev/null 2>&1; then
        echo -e "${RED}Error: 'jq' not found. Install with: brew install jq${RESET}" >&2
        missing=true
    fi

    if [ "$AUTO_COMMIT" = true ] && ! command -v git >/dev/null 2>&1; then
        echo -e "${RED}Error: 'git' not found but --auto-commit requires it.${RESET}" >&2
        missing=true
    fi

    if [ "$missing" = true ]; then
        exit 1
    fi
}

read_prompt() {
    if [ -f "$PROMPT_SOURCE" ]; then
        PROMPT_TEXT="$(cat "$PROMPT_SOURCE")"
        echo -e "${DIM}Prompt loaded from file: ${PROMPT_SOURCE}${RESET}"
    else
        PROMPT_TEXT="$PROMPT_SOURCE"
        echo -e "${DIM}Using inline prompt${RESET}"
    fi

    if [ -z "$PROMPT_TEXT" ]; then
        echo -e "${RED}Error: Prompt is empty.${RESET}" >&2
        exit 1
    fi
}

init_state_dir() {
    mkdir -p "$LOG_DIR"
    ensure_gitignore
}

ensure_gitignore() {
    # Only operate if we're in a git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        return
    fi

    local gitignore
    gitignore="$(git rev-parse --show-toplevel)/.gitignore"

    if [ -f "$gitignore" ]; then
        if ! grep -qxF '.ralph-loop/' "$gitignore" 2>/dev/null; then
            echo "" >> "$gitignore"
            echo "# Ralph Loop state (auto-added by camone-ralph-loop)" >> "$gitignore"
            echo ".ralph-loop/" >> "$gitignore"
            echo -e "${DIM}Added .ralph-loop/ to .gitignore${RESET}"
        fi
    else
        echo "# Ralph Loop state (auto-added by camone-ralph-loop)" > "$gitignore"
        echo ".ralph-loop/" >> "$gitignore"
        echo -e "${DIM}Created .gitignore with .ralph-loop/ entry${RESET}"
    fi
}

write_state() {
    local now
    now="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

    local tmp_file="${STATE_FILE}.tmp.$$"
    jq -n \
        --arg status "active" \
        --arg started_at "$now" \
        --argjson iteration 0 \
        --argjson max_iterations "$MAX_ITERATIONS" \
        --arg completion_promise "$COMPLETION_PROMISE" \
        --arg prompt_source "$PROMPT_SOURCE" \
        --arg log_dir "$LOG_DIR" \
        '{
            status: $status,
            started_at: $started_at,
            iteration: $iteration,
            max_iterations: $max_iterations,
            completion_promise: $completion_promise,
            prompt_source: $prompt_source,
            log_dir: $log_dir
        }' > "$tmp_file"
    mv "$tmp_file" "$STATE_FILE"
}

update_state_iteration() {
    local iter="$1"
    local tmp_file="${STATE_FILE}.tmp.$$"

    jq --argjson iter "$iter" '.iteration = $iter' "$STATE_FILE" > "$tmp_file"
    mv "$tmp_file" "$STATE_FILE"
}

deactivate_state() {
    if [ ! -f "$STATE_FILE" ]; then
        return
    fi

    local now
    now="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    local tmp_file="${STATE_FILE}.tmp.$$"

    jq \
        --arg status "completed" \
        --arg ended_at "$now" \
        --arg exit_reason "${EXIT_REASON:-unknown}" \
        '.status = $status | .ended_at = $ended_at | .exit_reason = $exit_reason' \
        "$STATE_FILE" > "$tmp_file"
    mv "$tmp_file" "$STATE_FILE"
}

show_dry_run() {
    echo ""
    echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
    echo -e "${BOLD}${CYAN}  camone-ralph-loop v${VERSION} — Dry Run${RESET}"
    echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "  ${BOLD}Prompt source:${RESET}         $PROMPT_SOURCE"
    if [ -f "$PROMPT_SOURCE" ]; then
        local lines
        lines="$(wc -l < "$PROMPT_SOURCE" | tr -d ' ')"
        echo -e "  ${BOLD}Prompt lines:${RESET}          $lines"
    fi
    echo -e "  ${BOLD}Max iterations:${RESET}        $([ "$MAX_ITERATIONS" -eq 0 ] && echo 'unlimited' || echo "$MAX_ITERATIONS")"
    echo -e "  ${BOLD}Completion promise:${RESET}    $([ -n "$COMPLETION_PROMISE" ] && echo "\"$COMPLETION_PROMISE\"" || echo 'none')"
    echo -e "  ${BOLD}Timeout/iteration:${RESET}     ${TIMEOUT_PER_ITERATION}s"
    echo -e "  ${BOLD}Auto commit:${RESET}           $AUTO_COMMIT"
    echo -e "  ${BOLD}Budget/iteration:${RESET}      $([ -n "$BUDGET_PER_ITERATION" ] && echo "\$${BUDGET_PER_ITERATION}" || echo 'none')"
    echo -e "  ${BOLD}Log directory:${RESET}         $LOG_DIR"
    echo ""
    echo -e "${DIM}  No changes will be made. Remove --dry-run to execute.${RESET}"
    echo ""
}

print_header() {
    local iter="$1"
    local elapsed
    elapsed="$(format_duration $(($(date +%s) - START_TIME)))"

    echo ""
    echo -e "${BOLD}${MAGENTA}┌──────────────────────────────────────────────────┐${RESET}"
    echo -e "${BOLD}${MAGENTA}│  🔄 Iteration ${iter}$([ "$MAX_ITERATIONS" -gt 0 ] && echo " / ${MAX_ITERATIONS}" || echo "")                               ${RESET}"
    echo -e "${BOLD}${MAGENTA}│  ⏱  Elapsed: ${elapsed}                              ${RESET}"
    echo -e "${BOLD}${MAGENTA}└──────────────────────────────────────────────────┘${RESET}"
    echo ""
}

format_duration() {
    local total_seconds="$1"
    local hours=$((total_seconds / 3600))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))

    if [ "$hours" -gt 0 ]; then
        printf "%dh %dm %ds" "$hours" "$minutes" "$seconds"
    elif [ "$minutes" -gt 0 ]; then
        printf "%dm %ds" "$minutes" "$seconds"
    else
        printf "%ds" "$seconds"
    fi
}

run_claude_iteration() {
    local iter="$1"
    local log_file
    log_file="$(printf '%s/iteration-%03d.log' "$LOG_DIR" "$iter")"

    local claude_args="-p"
    claude_args="$claude_args --verbose"
    claude_args="$claude_args --output-format stream-json"
    claude_args="$claude_args --dangerously-skip-permissions"
    claude_args="$claude_args --no-session-persistence"

    if [ -n "$BUDGET_PER_ITERATION" ]; then
        claude_args="$claude_args --max-budget-usd $BUDGET_PER_ITERATION"
    fi

    local exit_code=0
    local timed_out=false

    # Unset CLAUDECODE to allow running from within a Claude Code session
    # Set RALPH_LOOP_ACTIVE so hooks can detect and skip notifications
    env -u CLAUDECODE RALPH_LOOP_ACTIVE=1 claude $claude_args <<< "$PROMPT_TEXT" > "$log_file" 2>&1 &
    CLAUDE_PID=$!

    # Start timeout watchdog (Bug 3 fix)
    (
        sleep "$TIMEOUT_PER_ITERATION"
        if kill -0 "$CLAUDE_PID" 2>/dev/null; then
            echo -e "${YELLOW}⚠ Iteration ${iter} timed out after ${TIMEOUT_PER_ITERATION}s — killing claude${RESET}"
            kill "$CLAUDE_PID" 2>/dev/null
        fi
    ) &
    TIMER_PID=$!

    wait "$CLAUDE_PID" || exit_code=$?
    CLAUDE_PID=""

    # Clean up timer
    if kill -0 "$TIMER_PID" 2>/dev/null; then
        kill "$TIMER_PID" 2>/dev/null
        wait "$TIMER_PID" 2>/dev/null || true
    else
        timed_out=true
    fi
    TIMER_PID=""

    if [ "$timed_out" = true ]; then
        echo -e "${YELLOW}⚠ Iteration ${iter} timed out (${TIMEOUT_PER_ITERATION}s) → ${log_file}${RESET}"
    elif [ "$exit_code" -ne 0 ]; then
        echo -e "${YELLOW}⚠ Claude exited with code ${exit_code} (logged to ${log_file})${RESET}"
    else
        echo -e "${GREEN}✓ Iteration ${iter} complete → ${log_file}${RESET}"
    fi

    # Log file size for debugging
    local log_size
    log_size="$(wc -c < "$log_file" 2>/dev/null | tr -d ' ')"
    echo -e "${DIM}  Log size: ${log_size} bytes${RESET}"

    return "$exit_code"
}

check_completion_promise() {
    local iter="$1"
    local log_file
    log_file="$(printf '%s/iteration-%03d.log' "$LOG_DIR" "$iter")"

    if [ -z "$COMPLETION_PROMISE" ]; then
        return 1  # No promise configured
    fi

    # Method 1: Parse stream-json log — extract only assistant text and result messages
    # (Avoids false positives from tool results that may contain the prompt text)
    if [ -s "$log_file" ]; then
        local extracted
        extracted="$(jq -r '
            if .type == "assistant" then
                (.message.content[]? | select(.type == "text") | .text) // empty
            elif .type == "result" then
                .result // empty
            else empty end
        ' "$log_file" 2>/dev/null || true)"

        if [ -n "$extracted" ] && printf '%s' "$extracted" | grep -qF "$COMPLETION_PROMISE"; then
            echo -e "${GREEN}${BOLD}🎯 Completion promise detected in log: \"${COMPLETION_PROMISE}\"${RESET}"
            return 0
        fi
    fi

    # Method 2: Check project files for promise (Claude may write it to a file)
    # Exclude: prompt source, log dir, node_modules, .git
    local promise_in_file
    promise_in_file="$(grep -rl --include='*.md' --include='*.txt' --include='*.ts' --include='*.js' \
        --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=.ralph-loop \
        "<promise>${COMPLETION_PROMISE}</promise>" . 2>/dev/null | \
        grep -v "^\./${PROMPT_SOURCE}$" | head -1 || true)"

    if [ -n "$promise_in_file" ]; then
        echo -e "${GREEN}${BOLD}🎯 Completion promise detected (in file: ${promise_in_file}): \"${COMPLETION_PROMISE}\"${RESET}"
        return 0
    fi

    return 1
}

git_auto_commit() {
    local iter="$1"

    if [ "$AUTO_COMMIT" != true ]; then
        return
    fi

    # Check if there are any changes to commit
    if git diff --quiet HEAD 2>/dev/null && git diff --cached --quiet 2>/dev/null && [ -z "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
        echo -e "${DIM}No changes to commit after iteration ${iter}${RESET}"
        return
    fi

    local msg
    msg="ralph: iteration ${iter} auto-commit"

    if git add -A && git commit -m "$msg" >/dev/null 2>&1; then
        echo -e "${GREEN}📦 Auto-committed: ${msg}${RESET}"
    else
        echo -e "${YELLOW}⚠ Auto-commit failed (non-blocking)${RESET}"
    fi
}

notify_completion() {
    local reason="$1"

    # macOS notification sound
    if command -v afplay >/dev/null 2>&1; then
        afplay /System/Library/Sounds/Glass.aiff &
    fi

    # macOS speech
    if command -v say >/dev/null 2>&1; then
        say "Ralph loop finished. ${reason}" &
    fi
}

print_summary() {
    local elapsed
    elapsed="$(format_duration $(($(date +%s) - START_TIME)))"

    echo ""
    echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
    echo -e "${BOLD}${CYAN}  camone-ralph-loop — Summary${RESET}"
    echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "  ${BOLD}Iterations completed:${RESET}  $ITERATION"
    echo -e "  ${BOLD}Total elapsed:${RESET}         $elapsed"
    echo -e "  ${BOLD}Exit reason:${RESET}           ${EXIT_REASON:-unknown}"
    echo -e "  ${BOLD}Logs:${RESET}                  $LOG_DIR/"
    echo ""
}

run_loop() {
    START_TIME="$(date +%s)"
    ITERATION=0

    echo ""
    echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
    echo -e "${BOLD}${CYAN}  🐛 camone-ralph-loop v${VERSION} — Starting Loop${RESET}"
    echo -e "${BOLD}${CYAN}══════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "  ${BOLD}Max iterations:${RESET}      $([ "$MAX_ITERATIONS" -eq 0 ] && echo 'unlimited' || echo "$MAX_ITERATIONS")"
    echo -e "  ${BOLD}Completion promise:${RESET}  $([ -n "$COMPLETION_PROMISE" ] && echo "\"$COMPLETION_PROMISE\"" || echo 'none')"
    echo -e "  ${BOLD}Timeout/iteration:${RESET}   ${TIMEOUT_PER_ITERATION}s"
    echo -e "  ${BOLD}Auto commit:${RESET}         $AUTO_COMMIT"
    echo ""

    while true; do
        ITERATION=$((ITERATION + 1))

        # Check max iterations limit (break before running, so ITERATION stays accurate)
        if [ "$MAX_ITERATIONS" -gt 0 ] && [ "$ITERATION" -gt "$MAX_ITERATIONS" ]; then
            ITERATION=$((ITERATION - 1))
            EXIT_REASON="max_iterations_reached"
            echo -e "${YELLOW}${BOLD}🛑 Max iterations (${MAX_ITERATIONS}) reached.${RESET}"
            break
        fi

        print_header "$ITERATION"
        update_state_iteration "$ITERATION"

        # Run Claude (resilient — continues on failure)
        local claude_exit=0
        run_claude_iteration "$ITERATION" || claude_exit=$?

        # Check for completion promise
        if check_completion_promise "$ITERATION"; then
            EXIT_REASON="completion_promise"
            # Auto-commit final changes if enabled
            git_auto_commit "$ITERATION"
            break
        fi

        # Auto-commit after iteration
        git_auto_commit "$ITERATION"

        # Pause between iterations
        if [ "$MAX_ITERATIONS" -eq 0 ] || [ "$ITERATION" -lt "$MAX_ITERATIONS" ]; then
            echo -e "${DIM}Sleeping 3s before next iteration...${RESET}"
            sleep 3
        fi
    done

    deactivate_state
    print_summary
    notify_completion "$EXIT_REASON"
}

# ─── Main ───────────────────────────────────────────────────

main() {
    parse_args "$@"
    validate_environment
    read_prompt

    if [ "$DRY_RUN" = true ]; then
        show_dry_run
        exit 0
    fi

    init_state_dir
    write_state
    run_loop
}

main "$@"
