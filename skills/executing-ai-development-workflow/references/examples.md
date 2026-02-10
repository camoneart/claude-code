# AI Development Workflow - 使用例

## 例1: Light mode - 新しいUIコンポーネント追加

```
User: 機能開発ワークフローでユーザープロフィールカードを追加して

Claude Code (Light mode):

Step 1: Research
- Explore agentでコードベースを調査
- 既存のカードコンポーネント（ProductCard, TeamCard）のパターンを特定
- コンポーネント設計規約を把握

Step 2: Planning
- ProfileCardコンポーネントの設計計画を策定
- _docs/plans/2026-02-10-profile-card.md に保存
- [人間確認] プラン承認

Step 3: Issue & Branch
- gh issue create --title "feat: ユーザープロフィールカード"
- git checkout -b feature/45-profile-card

Step 4: Implementation
- 既存パターンに沿ってProfileCard実装
- ユニットテスト作成
- コミット作成

Step 7: PR Creation
- gh pr create --title "feat: ユーザープロフィールカード" --body "Closes #45"
```

## 例2: Full mode - 認証機能（セキュリティ重視）

```
User: AI開発ワークフローでユーザー認証機能を品質重視で実装して

Claude Code (Full mode - 「品質重視」トリガーワード + セキュリティ関連):

Step 1: Research
- Explore agentで認証周りのコードベースを調査
- 既存のセッション管理、トークン管理を把握

Step 2: Planning
- JWT認証の設計計画を策定（Full modeで実行を提示）
- _docs/plans/2026-02-10-user-authentication.md に保存
- [人間確認] プランとFull mode選択を承認

Step 3: Issue & Branch
- gh issue create --title "feat: ユーザー認証機能"
- git checkout -b feature/78-user-authentication

Step 4: Implementation
- backend-architect: 認証API実装
- frontend-developer: ログインUI実装
- test-automator: テスト作成

Step 5: Review（多層レビュー）
- 4 Sub-agents並列実行:
  - code-reviewer: コード品質チェック
  - security-auditor: SQLi, XSS, CSRF検出
  - architect-review: 認証フロー設計評価
  - test-ai-tdd-expert: テストカバレッジ評価
- /review 実行
- coderabbit --prompt-only --type uncommitted
- _docs/reviews/2026-02-10-user-authentication-review.md に統合保存

Step 6: Fix
- Critical 2件: パスワードハッシュ化漏れ、JWTシークレット漏洩 → 自動修正
- High 1件: セッション管理の脆弱性 → 自動修正
- Medium 3件: [人間確認] 修正/保留/却下を判断
- Low 2件: 記録のみ

Step 7: PR Creation
- [人間確認] PR前最終確認
- レビューサマリー付きでPR作成

Step 8: PR Response & Merge
- CodeRabbit/Claude Codeの追加レビューに対応
- 妥当な指摘のみ修正
- 人力レビュー後マージ
```

## 例3: Full mode - パフォーマンス改善（大規模リファクタリング）

```
User: データベースクエリの大規模リファクタリングをAI開発ワークフローで

Claude Code (Full mode - 「大規模」「リファクタリング」トリガーワード):

Step 1: Research
- N+1問題の特定
- 現在のクエリパフォーマンス計測
- インデックスの使用状況確認

Step 2: Planning
- インデックス追加 + クエリ最適化 + キャッシュ戦略を計画
- 15ファイルの変更見込み → Full mode確定
- [人間確認] プラン承認

Step 3: Issue & Branch
- git checkout -b feature/92-query-optimization

Step 4: Implementation
- database-optimizer: クエリ最適化
- backend-architect: キャッシュ層実装
- test-automator: パフォーマンステスト追加

Step 5-6: Review & Fix
- architect-reviewがキャッシュ設計を評価
- performance-engineerがボトルネックを検出
- 指摘に基づき修正

Step 7-8: PR作成 → レビュー対応 → マージ
```

## トリガーワード一覧

### Skill発動トリガー

| 言語 | トリガーワード |
|---|---|
| 日本語 | 「AI開発ワークフロー」「機能開発ワークフロー」「計画的に実装」「開発プロセス実行」「品質重視で実装」「多層レビューで開発」 |
| English | "AI development workflow", "feature workflow" |

### Full mode トリガー

| 言語 | トリガーワード |
|---|---|
| 日本語 | 「品質重視」「多層レビュー」「Full mode」「フルモード」「セキュリティ」「認証」「決済」「大規模」「リファクタリング」 |
| English | "quality-focused", "full review", "Full mode", "security", "payment" |
