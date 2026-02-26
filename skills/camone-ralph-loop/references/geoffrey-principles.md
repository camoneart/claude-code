# Geoffrey Huntley's Ralph Loop Core Principles

Reference document distilled from Geoffrey Huntley's methodology.
Source: https://ghuntley.com/ralph/

---

## 1. One Item Per Loop

The most important principle. Each loop iteration works on exactly ONE task from the implementation plan. This minimizes context consumption and ensures focused, high-quality output.

- Never combine multiple tasks into one iteration
- The prompt should direct Claude to pick the next incomplete item and work only on that
- If a task is too large, break it down in the plan first

## 2. Deterministic Stack Allocation

Every iteration loads the same document set deterministically:

- `specs/*.md` — Immutable specifications (the "what")
- `fix_plan.md` — Mutable progress tracker (the "where am I")
- `AGENT.md` — Self-learning operational guide (the "how")

This ensures each fresh context window has identical grounding, regardless of which iteration it is.

## 3. Subagent Strategy

The main context window acts as a **scheduler**, not a worker:

- **Research tasks** (searching, reading, understanding): Delegate to subagents. Up to 500 parallel subagents can search the codebase simultaneously.
- **Build tasks** (implementing, testing): Delegate to a single subagent to keep the main context clean.
- **Main context**: Orchestrates, reads plans, updates progress.

This preserves the main context window's budget for decision-making rather than consuming it on file reads.

## 4. Don't Assume Not Implemented

Ripgrep search is non-deterministic — the same query may return different results across runs. Before assuming something doesn't exist:

- Search with alternative terms and partial strings
- Check import statements and re-exports
- Look for similar patterns in adjacent files
- Try at least 3 different search strategies before concluding something is missing

False negatives in search lead to duplicate implementations, which is one of the most common failure modes.

## 5. No Placeholder Implementations

Claude has a bias toward generating placeholder or stub implementations (e.g., `// TODO: implement`, `throw new Error('not implemented')`). The prompt must explicitly forbid this:

- Every function must be fully implemented
- Every test must assert real behavior
- If implementation is blocked, document the blocker in fix_plan.md — do NOT write a placeholder

## 6. Back Pressure (Validation)

Every iteration must validate its work before marking a task complete:

- Run tests (`pnpm test`, `pytest`, etc.)
- Run the build (`pnpm build`, `cargo build`, etc.)
- Run linters (`eslint`, `ruff`, etc.)
- Run type checkers (`tsc --noEmit`, `mypy`, etc.)

Back pressure ensures errors are caught within the same iteration that introduced them, not deferred to future iterations where context is lost.

## 7. Self-Learning (AGENT.md)

When Claude discovers something new about the codebase during an iteration, it must immediately record it in `AGENT.md`:

- Build quirks and workarounds
- Environment-specific configuration
- Codebase conventions not documented elsewhere
- Dependency relationships between modules

**Critical distinction**: AGENT.md records **operational knowledge** (how things work), NOT progress notes (what was done). Progress belongs in fix_plan.md.

## 8. Bug Documentation

When Claude encounters a bug unrelated to the current task:

1. Do NOT fix it now — fixing unrelated bugs consumes context and risks regressions
2. Document it in fix_plan.md as a new task with `[BUG]` prefix
3. Continue with the current task

This maintains focus while ensuring nothing is forgotten.

## 9. Test Documentation

Tests must include comments explaining **why** they exist, not just what they test:

```
// This test verifies that expired tokens are rejected because
// the refresh flow depends on this behavior (see auth/refresh.ts).
// Without this check, users with expired tokens silently get
// stale data instead of being prompted to re-authenticate.
```

Future loop iterations have no memory of the reasoning context that led to the test. The comment IS the context.

## 10. Completion Promise Rules

The loop's termination depends on Claude's completion promise. The rules are strict:

- Output the completion promise (`<promise>...</promise>`) ONLY when the condition is **fully and truthfully** met
- Never output the promise to "escape" the loop when stuck
- If tests are failing, the promise condition is not met — period
- If implementation is partial, the promise condition is not met — period

Lying to exit the loop wastes all previous iterations' work because the final state is broken.
