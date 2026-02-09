# MCP Server Registry

プロジェクトにインストール可能なMCPサーバーの定義。

## Web検索・情報取得

### brave-search

- transport: `stdio`
- command: `npx -y @modelcontextprotocol/server-brave-search`
- env: `BRAVE_API_KEY`
- 用途: Web検索

### firecrawl

- transport: `stdio`
- command: `npx firecrawl-mcp`
- env: `FIRECRAWL_API_KEY`
- 用途: Webスクレイピング・クローリング

### context7

- transport: `http`
- url: `https://mcp.context7.com/mcp`
- env: なし
- 用途: OSSライブラリのドキュメント参照

## ブラウザ・フロントエンド開発

### chrome-devtools

- transport: `stdio`
- command: `npx -y chrome-devtools-mcp@latest`
- env: なし
- 用途: Chrome DevTools操作・スクリーンショット

### next-devtools

- transport: `stdio`
- command: `npx next-devtools-mcp@latest`
- env: なし
- 用途: Next.js開発支援

## コード分析・開発支援

### serena

- transport: `stdio`
- command: `uvx --from git+https://github.com/oraios/serena serena start-mcp-server`
- env: なし
- 用途: セマンティックコード分析・シンボル操作

### maestro

- transport: `stdio`
- command: `maestro-mcp-server`
- env: なし
- 用途: マルチエージェントオーケストレーション
- 注意: グローバルインストール済みのCLIが必要

## 除外対象

以下は `claude mcp add` で管理できないため、このスキルの対象外:

- **claude-mem**: Claude Code Pluginとして管理
- **ide**: IDE（VS Code等）が自動提供
