# /generate-gitignore - .gitignore自動生成コマンド

プロジェクトの技術スタックを自動検出し、適切な.gitignoreを生成する。

## 実行手順 (obey strictly)

### Step 1: 技術スタック自動検出

プロジェクトルートの以下のファイルを確認し、使用技術を判定する：

| ファイル | 検出される技術 |
|---------|---------------|
| `package.json` | Node.js、依存関係からフレームワーク検出（next, nuxt, react, vue等） |
| `pnpm-lock.yaml` | pnpm |
| `yarn.lock` | yarn |
| `package-lock.json` | npm |
| `pyproject.toml` / `requirements.txt` | Python |
| `go.mod` | Go |
| `Cargo.toml` | Rust |
| `Gemfile` | Ruby |
| `Dockerfile` / `docker-compose.yml` | Docker |
| `*.tf` / `terraform/` | Terraform |
| `.env.example` | 環境変数ファイル使用 |

検出結果をユーザーに報告する。

### Step 2: 既存.gitignore確認

プロジェクトルートに既存の`.gitignore`があるか確認する。

**既存ファイルがある場合**:
AskUserQuestionツールを使用して、以下の選択肢を提示：
- **上書き**: 既存ファイルを新規生成で置き換え
- **マージ**: 既存内容を保持しつつ、不足分を末尾に追記
- **スキップ**: 処理を中止

**既存ファイルがない場合**:
Step 3に進む

### Step 3: .gitignore生成

検出した技術スタックに基づいて、以下のセクションを組み合わせて.gitignoreを生成する。

#### 共通（常に含める）

```gitignore
# OS
.DS_Store
Thumbs.db

# Editor/IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Environment
.env
.env.local
.env.*.local
.env.development.local
.env.test.local
.env.production.local
```

#### Node.js検出時

```gitignore
# Dependencies
node_modules/
.pnp
.pnp.js

# Build
dist/
build/
.cache/
```

#### Next.js検出時

```gitignore
# Next.js
.next/
out/
```

#### Nuxt.js検出時

```gitignore
# Nuxt.js
.nuxt/
.output/
```

#### Python検出時

```gitignore
# Python
__pycache__/
*.py[cod]
*$py.class
.venv/
venv/
env/
.Python
pip-log.txt
.mypy_cache/
.pytest_cache/
```

#### Go検出時

```gitignore
# Go
bin/
pkg/
```

#### Rust検出時

```gitignore
# Rust
target/
Cargo.lock
```

#### Docker検出時

```gitignore
# Docker
.docker/
```

#### Terraform検出時

```gitignore
# Terraform
.terraform/
*.tfstate
*.tfstate.*
crash.log
*.tfvars
override.tf
override.tf.json
*_override.tf
*_override.tf.json
```

### Step 4: 完了報告

生成された.gitignoreの内容をユーザーに報告し、追加したいパターンがないか確認する。

## 出力形式

```
検出された技術スタック:
- Node.js (pnpm)
- Next.js
- Docker

.gitignoreを生成しました。追加したいパターンがあれば教えてね。
```
