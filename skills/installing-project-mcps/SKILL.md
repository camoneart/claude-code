---
name: installing-project-mcps
description: Install MCP servers into the current project scope using claude mcp add. Use when setting up a new project, when user mentions MCP setup, project MCP, MCPインストール, MCPセットアップ, or /installing-project-mcps.
allowed-tools: Bash
---

# Installing Project MCPs

プロジェクトスコープにMCPサーバーをインストールするワークフロー。

## ワークフロー

```
1. レジストリ読み込み
   ↓
2. ユーザーにインストール対象を確認（AskUserQuestion）
   ↓
3. claude mcp add --scope project で追加
   ↓
4. 検証（.mcp.json 確認）
```

## 実行手順

### Step 1: レジストリ読み込み

`references/mcp-registry.md` を読み込み、利用可能なMCPサーバー一覧を把握する。

### Step 2: ユーザーに選択させる

AskUserQuestionを使って、インストールするMCPを確認する。

提示する選択肢（カテゴリ別）:

**Web検索・情報取得:**
- brave-search（Web検索）
- firecrawl（Webスクレイピング）
- context7（OSSドキュメント参照）

**ブラウザ・フロントエンド開発:**
- chrome-devtools（Chrome操作）
- next-devtools（Next.js開発）

**コード分析・開発支援:**
- serena（セマンティックコード分析）
- maestro（マルチエージェント）

### Step 3: インストール実行

選択されたMCPに対して `claude mcp add` を実行する。

#### stdio方式のMCP

```bash
claude mcp add --scope project <name> -- <command> [args...]
```

具体例:
```bash
# brave-search
claude mcp add --scope project brave-search -e BRAVE_API_KEY -- npx -y @modelcontextprotocol/server-brave-search

# firecrawl
claude mcp add --scope project firecrawl -e FIRECRAWL_API_KEY -- npx firecrawl-mcp

# chrome-devtools
claude mcp add --scope project chrome-devtools -- npx -y chrome-devtools-mcp@latest

# next-devtools
claude mcp add --scope project next-devtools -- npx next-devtools-mcp@latest

# serena
claude mcp add --scope project serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server

# maestro
claude mcp add --scope project maestro -- maestro-mcp-server

```

#### HTTP方式のMCP

```bash
claude mcp add --scope project --transport http <name> <url>
```

具体例:
```bash
# context7
claude mcp add --scope project --transport http context7 https://mcp.context7.com/mcp
```

### Step 4: 環境変数の確認

`-e` フラグで指定した環境変数は、シェル環境（`.zshrc` 等）から取得される。

環境変数が未設定の場合:
1. ユーザーに通知: 「`BRAVE_API_KEY` がシェル環境に設定されていないようです」
2. 設定方法を案内: 「`.zshrc` に `export BRAVE_API_KEY=your_key` を追加してください」
3. 設定後、新しいターミナルセッションで再度スキルを実行するよう案内

環境変数の確認コマンド:
```bash
echo $BRAVE_API_KEY
echo $FIRECRAWL_API_KEY
```

### Step 5: 検証

インストール完了後、以下を確認:

1. `.mcp.json` がプロジェクトルートに生成されていること
2. `claude mcp list` で追加したMCPが表示されること

```bash
# プロジェクトの .mcp.json を確認
cat .mcp.json

# インストール済みMCP一覧
claude mcp list
```

## エラーハンドリング

### `claude mcp add` が失敗する場合

1. コマンドのパスを確認（`npx`, `uvx` 等が利用可能か）
2. ネットワーク接続を確認
3. 既に同名のMCPが登録されている場合は `claude mcp remove <name>` してから再追加

### npxコマンドが見つからない場合

Node.jsがインストールされていることを確認:
```bash
node --version
npx --version
```

### uvxコマンドが見つからない場合

uv（Python パッケージマネージャー）がインストールされていることを確認:
```bash
uv --version
```

## チェックリスト

- [ ] レジストリを読み込んだ
- [ ] ユーザーにインストール対象を確認した
- [ ] 環境変数が必要なMCPについて、変数が設定済みか確認した
- [ ] `claude mcp add --scope project` でインストールした
- [ ] `.mcp.json` が正しく生成されたことを確認した
- [ ] `claude mcp list` で追加を確認した
