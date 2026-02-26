# MCP Server Registry

プロジェクトにインストール可能なMCPサーバーの定義。
グローバルスコープで既に設定済みのMCPは除外している。

## ブラウザ・フロントエンド開発

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
