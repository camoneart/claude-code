# Claude Code Custom slash commands

Claude Code で使える [カスタムスラッシュコマンド](https://docs.anthropic.com/en/docs/claude-code/slash-commands#custom-slash-commands) を集めたリポジトリです。

`.claude/commands/` や `~/.claude/commands/` ディレクトリに配置するだけで、スラッシュコマンド `/` を使用してClaude Codeの動作を制御できるようになります。

## 利用可能なコマンド

### 開発ワークフロー
- `/dakoku` - 勤怠打刻（出勤・退勤記録）
- `/bugfix` - バグ修正ワークフロー
- `/feature-development` - 機能開発ワークフロー
- `/feature-log` - 機能実装ログの記録
- `/fix-issue` - Issue修正ワークフロー
- `/full-stack-feature` - フルスタック機能開発
- `/git-workflow` - Gitワークフロー管理
- `/smart-fix` - インテリジェントなバグ修正
- `/standup-notes` - スタンドアップミーティングノート生成
- `/workflow-automate` - ワークフロー自動化

### TDD（テスト駆動開発）
- `/tdd` - テスト駆動開発（TDD）フロー実行
- `/tdd-cycle` - TDDサイクル実行
- `/tdd-red` - TDD Red フェーズ（テスト失敗）
- `/tdd-green` - TDD Green フェーズ（テスト成功）
- `/tdd-refactor` - TDD Refactor フェーズ（リファクタリング）

### テスト・品質保証
- `/test-generate` - テストコード生成
- `/test-report` - テストレポート生成
- `/playwright` - Playwright E2Eテスト実行
- `/full-review` - 包括的なコードレビュー
- `/ai-review` - AI支援コードレビュー
- `/multi-agent-review` - マルチエージェントレビュー

### セキュリティ
- `/security-sast` - 静的アプリケーションセキュリティテスト（SAST）
- `/security-hardening` - セキュリティ強化
- `/security-dependencies` - 依存関係のセキュリティ監査
- `/xss-scan` - XSS脆弱性スキャン
- `/accessibility-audit` - アクセシビリティ監査

### パフォーマンス・最適化
- `/performance-optimization` - パフォーマンス最適化
- `/cost-optimize` - コスト最適化
- `/multi-agent-optimize` - マルチエージェント最適化
- `/prompt-optimize` - プロンプト最適化

### プロジェクトセットアップ・スキャフォールディング
- `/typescript-scaffold` - TypeScriptプロジェクトのスキャフォールディング
- `/component-scaffold` - コンポーネントスキャフォールディング
- `/rust-project` - Rustプロジェクトセットアップ
- `/onboard` - プロジェクトオンボーディング

### データ・ML・AI
- `/data-pipeline` - データパイプライン構築
- `/data-driven-feature` - データ駆動型機能開発
- `/ml-pipeline` - 機械学習パイプライン構築
- `/langchain-agent` - LangChainエージェント開発
- `/ai-assistant` - AIアシスタント開発

### API・モック・テスト
- `/api-mock` - APIモック生成
- `/config-validate` - 設定ファイル検証

### デバッグ・トラブルシューティング
- `/debug-trace` - デバッグトレース
- `/error-analysis` - エラー分析
- `/error-trace` - エラートレース
- `/incident-response` - インシデント対応

### 依存関係管理
- `/deps-audit` - 依存関係監査
- `/deps-upgrade` - 依存関係アップグレード

### リファクタリング・モダナイゼーション
- `/refactor-clean` - クリーンリファクタリング
- `/code-migrate` - コード移行
- `/legacy-modernize` - レガシーモダナイゼーション
- `/tech-debt` - 技術的負債管理

### ドキュメント・記事
- `/doc-generate` - ドキュメント生成
- `/code-explain` - コード説明
- `/blog` - ブログ記事執筆支援
- `/zenn-blog` - Zenn記事執筆支援
- `/translate` - 記事翻訳支援
- `/fetch-and-slide` - Webコンテンツからスライド生成

### インフラ・DevOps
- `/monitor-setup` - モニタリングセットアップ
- `/slo-implement` - SLO実装
- `/migration-observability` - 移行オブザーバビリティ

### データベース
- `/sql-migrations` - SQLデータベースマイグレーション

### リリース・デプロイ
- `/release-and-tag` - リリースとタグ付け
- `/release-tag` - リリースタグ作成
- `/pr-enhance` - プルリクエスト強化

### コンプライアンス
- `/compliance-check` - コンプライアンスチェック

### MCP サーバー呼び出し
- `/mcp-brave-search` - Brave Search MCP Server を使ったWeb検索
- `/mcp-context7` - Context7 MCP Server でライブラリドキュメント取得
- `/mcp-deepwiki` - DeepWiki MCP Server でGitHubリポジトリのドキュメント取得

### コンテキスト管理
- `/context-save` - コンテキスト保存
- `/context-restore` - コンテキスト復元

### エージェント・プロンプト
- `/improve-agent` - エージェント改善
- `/multi-platform` - マルチプラットフォーム対応

### その他ユーティリティ
- `/explain-project` - プロジェクト構造の説明
- `/plan-to-checklist` - プランをチェックリスト化
- `/screenshot` - スクリーンショット撮影
- `/export-conversations` - 会話履歴のエクスポート
- `/issue` - Issue管理
- `/hayashi-app-development-prompt-template` - 林アプリ開発プロンプトテンプレート

[詳細はドキュメントを参照してください。](https://docs.anthropic.com/en/docs/claude-code/slash-commands#custom-slash-commands)
