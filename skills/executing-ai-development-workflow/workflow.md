# AI Development Workflow - 詳細ステップガイド

このドキュメントは、AI開発ワークフローの各ステップの詳細な実装方法を説明します。

## Step 1: プランニング (Planning)

**目的**: 実装する機能の全体像を明確にする

**実行内容**:
1. ユーザーの要件をヒアリング
2. プランモードで実装計画を立案
3. タスクをチェックボックス付きで分解
4. 技術スタック、リスク、注意点を明確化

**人間確認ポイント**: ✅ プラン内容を確認し、承認を得る

---

## Step 2: プランのドキュメント化

**目的**: プランを永続化し、後から参照できるようにする

`templates/plan.md` を使用して、`_docs/plans/YYYY-MM-DD-[feature-name].md` として保存します。

---

## Step 3: 実装 (Implementation)

適切なSub-agentを選択して実装を委任:
- **frontend-developer**: フロントエンド機能
- **backend-architect**: バックエンドAPI
- **database-architect**: データベース設計
- **test-automator**: テスト追加

---

## Step 4: 多層レビュー (Multi-layer Review)

### 4a. Sub-agent Reviews（並列実行）

以下の4つのSub-agentを並列で実行:
- **code-reviewer**: コード品質全般
- **security-auditor**: セキュリティ脆弱性
- **architect-review**: アーキテクチャ設計
- **test-ai-tdd-expert**: テストカバレッジ

### 4b. Claude Code `/review` コマンド

```bash
/review
```

### 4c. CodeRabbit CLI Review

```bash
coderabbit --prompt-only --type uncommitted
```

バックグラウンドで実行し、7-30分程度かかる場合があります。

---

## Step 5: レビュー結果のドキュメント化

1. 各レビュー結果（4a, 4b, 4c）を収集
2. `config.json` の優先度ルールで分類:
   - **Critical**: セキュリティ脆弱性、重大なバグ
   - **High**: パフォーマンス問題、設計上の問題
   - **Medium**: コード品質、ベストプラクティス
   - **Low**: スタイル、命名、軽微な改善提案
3. `templates/review.md` を使用してレポート作成
4. `_docs/reviews/YYYY-MM-DD-[feature-name]-review.md` として保存

---

## Step 6: 自動修正

Critical/High優先度の**妥当な**問題を自動的に修正:
- 単純な修正: Edit toolで直接修正
- 複雑な修正: 適切なSub-agentに委任

---

## Step 7: 人間による確認

Medium優先度の問題について**妥当性判断**を仰ぐ:
- 妥当 - 修正する
- 保留 - 後で検討
- 却下 - 誤検知または不要

**人間確認ポイント**: ✅ Medium優先度問題の対応方針

---

## Step 8: PR作成

1. 全ての修正をコミット
2. レビューサマリーをPR説明に含める
3. `gh pr create` でPR作成
4. CodeRabbitが自動的にPRをレビュー
5. Claude Codeで `/review` を実行

**人間確認ポイント**: ✅ PR作成前の最終確認

---

## Step 9: PR後の対応

1. CodeRabbitとClaude Codeのレビューコメントを確認
2. **妥当な指摘のみ**Claude Codeで修正を実装
3. 誤検知や不要な提案は丁寧に却下

**妥当性判断のポイント**:
- セキュリティ関連 → 基本的に妥当
- パフォーマンス → 実測データで判断
- スタイル・命名 → プロジェクト規約と照らし合わせ
- **両ツールで指摘された内容** → 特に注目

---

## Step 10: Merge

人力レビューを適宜挟みながら、マージを実行します。

---

## 優先度判定ロジック

```python
# config.json の priority_rules に基づいて判定
if contains(keywords["critical"]) or matches(patterns["critical"]):
    priority = "Critical"
elif contains(keywords["high"]):
    priority = "High"
elif contains(keywords["medium"]):
    priority = "Medium"
else:
    priority = "Low"
```

---

## テンプレート変数

### templates/plan.md の変数
- `{{FEATURE_NAME}}`: 機能名
- `{{DATE}}`: 作成日
- `{{FEATURE_DESCRIPTION}}`: 機能説明
- `{{GOALS}}`: 目標
- `{{FRONTEND_STACK}}`: フロントエンド技術スタック
- `{{BACKEND_STACK}}`: バックエンド技術スタック
- `{{DATABASE}}`: データベース
- `{{OTHER_TOOLS}}`: その他のツール
- `{{RISKS_AND_CONSIDERATIONS}}`: リスクと注意点
- `{{ADDITIONAL_NOTES}}`: 追加メモ

### templates/review.md の変数
Handlebars形式で各種レビュー結果を埋め込みます。