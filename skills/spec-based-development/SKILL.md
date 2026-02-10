---
name: spec-based-development
description: Generate detailed feature specifications by interviewing the user with AskUserQuestionTool. Transforms rough ideas into comprehensive SPEC.md files through deep, non-obvious questions about technical implementation, UI/UX, edge cases, and tradeoffs. Use when user mentions "spec", "仕様書作成", "仕様駆動", "インタビューして", "SPEC.md", "feature spec", or wants to plan a large feature before implementation.
---

# Spec-Based Development

AskUserQuestionToolで徹底的にインタビューし、ざっくりしたアイデアを詳細な仕様書（SPEC.md）に変換するワークフロー。

## Workflow

Task Progress:

- [ ] Step 1: アイデア把握
- [ ] Step 2: 既存SPEC.md確認
- [ ] Step 3: インタビュー実施
- [ ] Step 4: SPEC.md書き出し
- [ ] Step 5: 次ステップ案内

### Step 1: アイデア把握

ユーザーの入力から対象機能・プロジェクトの概要を把握する。情報が不足していても問題ない（Step 3で掘り下げる）。

### Step 2: 既存SPEC.md確認

プロジェクトルートに `SPEC.md` が存在するか確認する。

- **存在する場合**: 内容を読み込み、既存の仕様を踏まえてインタビューする
- **存在しない場合**: 新規作成前提で進む

### Step 3: インタビュー実施

AskUserQuestionToolを使い、以下の観点で繰り返し質問する。

**質問の観点:**

- 技術的実装（アーキテクチャ、DB設計、API設計）
- UI/UX（画面構成、操作フロー、レスポンシブ対応）
- エッジケース（異常系、境界値、同時実行）
- 懸念事項（パフォーマンス、セキュリティ、スケーラビリティ）
- トレードオフ（技術選定の理由、優先度の判断）

**CRITICAL: 質問のルール:**

- 明らかな質問はしない。ユーザーが考慮していなかった深い部分を掘り下げる
- 1回のAskUserQuestionToolで1-4問ずつ質問する
- ユーザーが「完了」「十分」「もういい」と言うまで継続する
- 最低でも10問以上は質問すること

### Step 4: SPEC.md書き出し

インタビュー結果をプロジェクトルートの `SPEC.md` に書き出す。

**SPEC.mdのフォーマット:**

```markdown
# [機能名/プロジェクト名]

## 概要

[1-2文の要約]

## 背景・目的

[なぜこの機能が必要か]

## 機能要件

[インタビューで確定した要件をリスト形式で]

## 技術仕様

[アーキテクチャ、使用技術、API設計など]

## UI/UX仕様

[画面構成、操作フローなど（該当する場合）]

## エッジケース・制約

[想定される異常系、境界条件]

## 非機能要件

[パフォーマンス、セキュリティ、スケーラビリティ]

## 未決定事項

[インタビューで確定しなかった項目]
```

セクションは機能の性質に応じて調整する。不要なセクションは省略してよい。

### Step 5: 次ステップ案内

SPEC.md作成後、以下を案内する:

```
SPEC.mdを作成しました！

次のステップ:
1. SPEC.mdの内容を確認・修正してください
2. 実装は新しいセッションで行うのがおすすめです:
   - /clear でコンテキストをリセット
   - 「@SPEC.md に基づいて実装して」と指示

インタビューのやりとりでコンテキストが消費されているため、
クリーンな新セッションの方が実装品質が高くなります。
```
