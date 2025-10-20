# Claude Code Subagents

Claude Code で使える [サブエージェント](https://docs.anthropic.com/en/docs/claude-code/sub-agents) を集めたリポジトリです。

`/agents` で「作成」「呼び出し」が可能。

## 利用可能なSubagents

### 1. Context Engineering Agent
**ファイル**: `context-engineering-agent.md` | **モデル**: opus

AIエージェントのコンテキストエンジニアリング戦略を設計・最適化する専門家。

- プロンプト構造とコンテキストウィンドウ管理
- 検索システムとエージェントアーキテクチャの実装
- 本番システムのベストプラクティスに基づく最適化
- エージェントパフォーマンスのコンテキスト管理による改善

### 2. JavaScript Pro
**ファイル**: `javascript-pro.md` | **モデル**: opus

ES6+、非同期パターン、Node.js APIをマスターした現代的JavaScript専門家。**プロアクティブに使用。**

- ES6+機能、async/await、Promise、イベントループ
- ブラウザ/Node.js互換性とモジュールシステム
- JavaScriptの最適化と複雑なパターンのデバッグ
- 関数型プログラミングパターン

### 3. TypeScript Pro
**ファイル**: `typescript-pro.md` | **モデル**: opus

ジェネリクス、条件型、厳密な型安全性を扱う高度なTypeScript専門家。**プロアクティブに使用。**

- 高度な型システム（ジェネリクス、条件型、Mapped Types）
- デコレーター、エンタープライズグレードパターン
- 型推論の最適化と複雑な型パターン
- 厳密な型安全性の実装

### 4. Security Auditor
**ファイル**: `security-auditor.md` | **モデル**: opus | **カラー**: yellow

脆弱性レビュー、セキュアな認証実装、OWASP準拠を実現するセキュリティ専門家。**プロアクティブに使用。**

- JWT、OAuth2、セッション管理
- CORS、CSP、暗号化の実装
- セキュリティヘッダー設定とOWASP参照
- 実用的な修正と脆弱性の特定

### 5. Test Automator
**ファイル**: `test-automator.md` | **モデル**: opus | **カラー**: blue

ユニット、統合、E2Eテストを含む包括的なテストスイート作成の専門家。**プロアクティブに使用。**

- CIパイプライン、モック戦略、テストデータのセットアップ
- テスト駆動開発（TDD）とビヘイビア駆動開発（BDD）
- カバレッジ分析とパフォーマンステスト
- フィクスチャとテスト自動化フレームワーク

## Subagentsの仕組み

### プロアクティブ使用
**「プロアクティブに使用」**と記載されているagentは、関連するタスクに自動的に起動されます。

例：
- TypeScriptコードのリファクタリング → `typescript-pro` が自動起動
- セキュリティレビュー依頼 → `security-auditor` が自動起動
- テストカバレッジ改善 → `test-automator` が自動起動

### 手動呼び出し
`/agents` コマンドを使って、任意のagentを手動で呼び出すこともできます。

[詳細はドキュメントを参照してください。](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
