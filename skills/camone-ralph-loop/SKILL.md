---
name: camone-ralph-loop
description: "Run external Ralph Loop (Geoffrey Huntley's original while-true approach) with clean context per iteration. Unlike the official ralph-loop plugin which uses Stop hooks (same session, context pollution), this spawns fresh `claude -p` sessions each iteration. Use when user mentions \"camone-ralph-loop\", \"external ralph\", \"clean ralph loop\", \"外部ラルフ\", \"ラルフループ実行\", or wants to run iterative AI development with isolated context windows."
---

# camone-ralph-loop

External Ralph Loop implementation faithful to Geoffrey Huntley's original concept: a bash `while true` loop that spawns fresh `claude -p` sessions, ensuring each iteration starts with a clean context window.

## Key Difference from Official Plugin

| | Official ralph-loop plugin | camone-ralph-loop |
|---|---|---|
| Loop mechanism | Stop hook (same session) | External bash loop (new session each) |
| Context | Accumulates across iterations | **Clean every iteration** |
| Self-reference | Claude sees previous work in files + conversation history | Claude sees previous work **only in files and git history** |

The official plugin's Stop hook approach keeps all failed attempts in context, degrading LLM performance over iterations. camone-ralph-loop follows Geoffrey's original insight: the prompt never changes, but Claude discovers its previous work by reading files and git history — not from stale conversation context.

## Workflow

### 1. Prepare prompt

Create a `PROMPT.md` (or use inline text) with:
- Clear task description
- Success criteria
- Completion promise phrase in `<promise>` tags

Example:
```markdown
Fix all failing tests in src/. Run the test suite after each change.
When ALL tests pass, output: <promise>ALL TESTS PASSING</promise>
```

### 2. Execute loop

Run via Bash:
```bash
"${CLAUDE_SKILL_ROOT}/scripts/camone-ralph-loop.sh" [OPTIONS] [PROMPT_FILE_OR_TEXT]
```

Options:
- `--max-iterations N` — Stop after N iterations (default: unlimited)
- `--completion-promise TEXT` — Stop on `<promise>TEXT</promise>` detection
- `--auto-commit` — Git commit after each iteration
- `--budget-per-iteration N` — USD cap per iteration (passed as `--max-cost` to claude)
- `--dry-run` — Preview config without running
- `--log-dir DIR` — Log location (default: `.ralph/logs/`)

### 3. Monitor

- Logs: `.ralph/logs/iteration-NNN.log`
- State: `.ralph/state.json`
- Completion: macOS notification sound + speech

### 4. Cancel

Kill the process (Ctrl+C or `kill`). The script traps both SIGINT and SIGTERM and cleans up child `claude` processes.

## Usage Examples

```bash
# Dry run to verify config
"${CLAUDE_SKILL_ROOT}/scripts/camone-ralph-loop.sh" --dry-run --max-iterations 10 PROMPT.md

# Run with completion promise and iteration limit
"${CLAUDE_SKILL_ROOT}/scripts/camone-ralph-loop.sh" \
  --max-iterations 20 \
  --completion-promise "ALL TESTS PASSING" \
  --auto-commit \
  PROMPT.md

# Quick inline prompt
"${CLAUDE_SKILL_ROOT}/scripts/camone-ralph-loop.sh" \
  --max-iterations 5 \
  "Refactor auth module. Output <promise>DONE</promise> when complete."
```

## Prompt Best Practices

1. **Include verification steps** — "Run tests", "Run linter", "Check build"
2. **Set clear completion criteria** — Specific, measurable conditions
3. **Use `--max-iterations` as safety net** — Always set a reasonable upper bound
4. **Leverage git history** — With `--auto-commit`, each iteration's work is preserved and the next iteration can `git log` / `git diff` to see what changed

## Generated Files

```
.ralph/
  state.json              # Loop state (active/completed, iteration count)
  logs/
    iteration-001.log     # Each iteration's claude output
    iteration-002.log
    ...
```

`.ralph/` is auto-added to `.gitignore` on first run.

## Troubleshooting

- **Script not found**: Verify `${CLAUDE_SKILL_ROOT}/scripts/camone-ralph-loop.sh` exists and is executable
- **"Cannot launch inside another session"**: The script uses `env -u CLAUDECODE` to handle this automatically. If it still fails, run from a standalone terminal
- **Orphan claude processes**: The script tracks child PIDs and kills them on SIGINT/SIGTERM. If manually killed with SIGKILL (`kill -9`), child processes may survive — use `ps aux | grep 'claude.*-p' | grep -v grep` to find and kill them
