# Claude Code Custom slash commands

Claude Code で使える [カスタムスラッシュコマンド](https://docs.anthropic.com/en/docs/claude-code/slash-commands#custom-slash-commands) を集めたリポジトリです。

`.claude/commands/` や `~/.claude/commands/` ディレクトリに配置するだけで、スラッシュコマンド `/` を使用してClaude Codeの動作を制御できるようになります。

## 主要なコマンド

### 開発ワークフロー
- `/dakoku` - 勤怠打刻（出勤・退勤記録）
- `/tdd` - テスト駆動開発（TDD）フロー実行
- `/bugfix` - バグ修正ワークフロー
- `/feature-log` - 機能実装ログの記録

### プロジェクトセットアップ
- `/typescript-scaffold` - TypeScriptプロジェクトの迅速なスキャフォールディング

### MCP サーバー呼び出し
- `/mcp-brave-search` - Brave Search MCP Server を使ったWeb検索
- `/mcp-context7` - Context7 MCP Server でライブラリドキュメント取得
- `/mcp-deepwiki` - DeepWiki MCP Server でGitHubリポジトリのドキュメント取得

### テスト・リリース
- `/test-report` - テストレポート生成
- `/release-and-tag` - リリースとタグ付け
- `/playwright` - Playwright E2Eテスト実行

### ドキュメント・記事
- `/blog` - ブログ記事執筆支援
- `/zenn-blog` - Zenn記事執筆支援
- `/translate` - 記事翻訳支援
- `/fetch-and-slide` - Webコンテンツからスライド生成

### その他
- `/explain-project` - プロジェクト構造の説明
- `/plan-to-checklist` - プランをチェックリスト化
- `/screenshot` - スクリーンショット撮影
- `/export-conversations` - 会話履歴のエクスポート
- `/fix-issue` - Issue修正ワークフロー

[詳細はドキュメントを参照してください。](https://docs.anthropic.com/en/docs/claude-code/slash-commands#custom-slash-commands)
