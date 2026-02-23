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

### 0. Interview & PROMPT.md Generation (most important phase)

**PROMPT.md の品質 = Ralph Loop の成果品質。** ユーザーの曖昧なリクエストから高品質な PROMPT.md を生成するため、必ずインタビューフェーズを実施する。

#### When to interview

- **インタビュー必須**: ユーザーのリクエストが曖昧・抽象的な場合（例: 「TDDでform実装して」「バグ直して」「リファクタして」）
- **インタビュー省略可**: ユーザーが既に PROMPT.md を用意している、または十分に具体的な仕様を提供している場合

#### Interview process

1. **意図を理解する**: ユーザーのリクエストから何を作りたいかを把握
2. **AskUserQuestion で深掘りする**: 以下の観点で質問し、仕様を明確にする
   - **具体的な要件**: 何を作るか、どんな機能が必要か
   - **技術スタック**: 使用するライブラリ、フレームワーク、テストツール
   - **ファイル構成**: どこにファイルを作るか、既存コードとの関係
   - **検証手段**: テストコマンド、リンター、ビルドコマンド
   - **エッジケース**: バリデーション、エラーハンドリング、境界値
   - **完了条件**: 何をもって「完了」とするか
3. **既存コードを探索する**: 必要に応じて Glob/Grep/Read でコードベースのパターンや規約を確認
4. **PROMPT.md を生成する**: 収集した情報から高品質な PROMPT.md を作成
5. **ユーザーに確認する**: 生成した PROMPT.md をユーザーに見せて承認を得る

#### PROMPT.md required structure

```markdown
# Task
[具体的なタスクの説明]

# Requirements
[機能要件・非機能要件の一覧]

# Tech Stack
[使用する言語、ライブラリ、フレームワーク]

# File Structure
[作成・変更するファイルのパス]

# Verification
[テストコマンドや検証手順]
例: cd /path/to/project && pnpm test

# Completion
[完了条件を明記]
When ALL tests pass, output exactly: <promise>ALL TESTS PASSING</promise>
```

#### Quality checklist (PROMPT.md 生成前に確認)

- [ ] タスクが具体的で曖昧さがない
- [ ] ファイルパスが絶対パスで指定されている
- [ ] 検証コマンドが実行可能な形で書かれている
- [ ] 完了条件が `<promise>` タグで明記されている
- [ ] claude -p が単独で（会話コンテキストなしで）理解・実行できる内容になっている

### 1. Execute loop

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

**Important**: Always run `--dry-run` first to verify config before actual execution.

### 2. Monitor

- Logs: `.ralph-loop/logs/iteration-NNN.log`
- State: `.ralph-loop/state.json`
- Completion: macOS notification sound + speech

### 3. Cancel

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
