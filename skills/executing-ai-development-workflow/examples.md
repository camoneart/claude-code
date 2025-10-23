# AI Development Workflow - 使用例

## 例1: 新しい認証機能の実装

```
User: AI開発ワークフローでユーザー認証機能を実装して

Claude Code:
1. プランニングフェーズ開始
   - 要件確認
   - JWT認証を使用する計画を立案
   - _docs/plans/2025-10-23-user-authentication.md に保存

2. 実装フェーズ
   - backend-architectに認証APIを委任
   - frontend-developerにログインUIを委任
   - test-automatorにテスト作成を委任

3. レビューフェーズ
   - 4つのSub-agentとCodeRabbit CLIで並列レビュー
   - 結果を_docs/reviews/に保存

4. 修正フェーズ
   - Critical: 2件（パスワードハッシュ化漏れ、JWTシークレット漏洩）→ 自動修正
   - High: 1件（セッション管理の脆弱性）→ 自動修正
   - Medium: 3件 → 人間に確認

5. PR作成
   - レビューサマリー付きでPR作成
```

## 例2: パフォーマンス改善

```
User: データベースクエリのパフォーマンス改善をAI開発ワークフローで

Claude Code:
1. プランニング
   - N+1問題の特定
   - インデックス追加計画
   - キャッシュ戦略の策定

2. 実装
   - database-optimizerにクエリ最適化を委任
   - backend-architectにキャッシュ実装を委任

3. レビュー
   - performance-engineerでパフォーマンス評価
   - architect-reviewで設計レビュー

4. 修正・PR作成
```

## 例3: セキュリティ重要機能の開発

```
User: 決済機能を計画的に実装したい

Claude Code:
1. プランニング
   - PCI DSS準拠チェックリスト作成
   - Stripe/PayPal統合の設計
   - エラーハンドリング戦略

2. 実装
   - payment-integration Sub-agentで決済API実装
   - security-auditorで事前セキュリティチェック

3. 多層レビュー（特に厳重）
   - security-auditor（セキュリティ）
   - architect-review（設計）
   - code-reviewer（コード品質）
   - test-ai-tdd-expert（テスト網羅性）
   - CodeRabbit CLI（外部視点）

4. Critical/High問題は全て修正
   - セキュリティ関連は例外なく修正

5. PR作成とレビュー
   - セキュリティチームの承認必須
```

## トリガーワード例

以下のキーワードでこのSkillが発動します：

- 「AI開発ワークフローで〜」
- 「AI development workflow」
- 「計画的に実装」
- 「多層レビューで開発」
- 「品質重視で実装」