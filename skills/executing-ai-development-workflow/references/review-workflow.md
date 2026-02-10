# Full Mode: 多層レビューワークフロー詳細

## Contents

- Sub-agent Reviews の実行方法
- /review コマンドの実行
- CodeRabbit CLI の実行
- レビュー結果の統合
- 妥当性判断のガイドライン
- 自動修正と人間確認のフロー

## Sub-agent Reviews の実行方法

### 並列実行

4つのSub-agentを `Task` ツールで**同時に**起動する。1つのメッセージ内で4つの `Task` 呼び出しを並列で行うこと。

```
# 4つ同時に起動（1メッセージ内）
Task(subagent_type=code-reviewer, prompt="変更されたコードをレビューして...")
Task(subagent_type=security-auditor, prompt="セキュリティ脆弱性を検出して...")
Task(subagent_type=architect-review, prompt="アーキテクチャ設計を評価して...")
Task(subagent_type=test-ai-tdd-expert, prompt="テストカバレッジを評価して...")
```

### 各Sub-agentへの指示ポイント

**code-reviewer**:
- 変更されたファイルのdiffを提示
- プロジェクトの既存パターンとの一貫性を確認させる
- 命名、複雑度、重複を評価させる

**security-auditor**:
- 入力バリデーション、認証・認可、データ漏洩をチェック
- OWASP Top 10の観点で評価
- 特にSQLi, XSS, CSRF, 権限昇格に注目

**architect-review**:
- 設計パターンの適切性
- 依存関係の方向性（循環依存の有無）
- 拡張性とメンテナビリティ

**test-ai-tdd-expert**:
- テストカバレッジの十分性
- エッジケースのカバー
- テストの品質（脆いテスト、過度なモック）

## /review コマンドの実行

Claude Codeの組み込みレビューコマンドを実行:

```
/review
```

結果をメモし、他のレビュー結果と統合する。

## CodeRabbit CLI の実行

```bash
coderabbit --prompt-only --type uncommitted
```

- `--prompt-only`: ユーザー入力不要のバックグラウンド実行
- `--type uncommitted`: 未コミット変更のみレビュー
- 実行に7-30分程度かかる場合がある
- バックグラウンドで実行し、他の作業と並行可能

## レビュー結果の統合

### 収集

1. 4つのSub-agentの結果を収集
2. `/review` の結果を収集
3. CodeRabbit CLIの結果を収集

### 優先度分類

`assets/config.json` の `priority_rules` に基づいて全指摘を分類:

```
Critical: config.json の critical.keywords/patterns にマッチ
High:     config.json の high.keywords にマッチ
Medium:   config.json の medium.keywords にマッチ
Low:      上記いずれにもマッチしない、または low.keywords にマッチ
```

### 重複排除

複数のレビューアが同じ問題を指摘した場合:
- 1つの指摘としてまとめる
- 検出元を全て記載する（例: "code-reviewer, security-auditor"）
- 複数ツールで検出された指摘は信頼度が高いと判断

### レポート作成

`assets/templates/review.md` を使用して統合レポートを作成:
- `_docs/reviews/YYYY-MM-DD-[feature-name]-review.md` として保存
- サマリーテーブル（優先度別件数）
- 各指摘の詳細（ファイル、行番号、説明、推奨対応）

## 妥当性判断のガイドライン

AIレビューの指摘が全て正しいわけではない。以下の基準で妥当性を判断する:

### 妥当と判断しやすい指摘

- セキュリティ脆弱性（具体的なコード箇所を指摘している場合）
- 明確なバグ（null参照、型エラー、境界値の問題）
- 複数のレビューアが同じ問題を独立に指摘

### 誤検知を疑うべき指摘

- 「〜すべき」「〜が望ましい」程度の曖昧な提案
- プロジェクトの既存パターンと矛盾する提案
- 過度な抽象化や早すぎる最適化の提案
- コンテキスト不足による的外れな指摘

### 判断に迷った場合

- **人間に判断を委ねる**（Medium扱い）
- 指摘内容とプロジェクトの文脈を提示して判断を仰ぐ

## 自動修正と人間確認のフロー

```
レビュー指摘
  │
  ├─ Critical/High
  │   ├─ 妥当 → 自動修正
  │   │   ├─ 単純 → Edit ツールで直接修正
  │   │   └─ 複雑 → Sub-agentに委任
  │   └─ 誤検知 → 理由を記載してスキップ
  │
  ├─ Medium
  │   └─ 人間に確認を求める
  │       ├─ 修正する → 修正実施
  │       ├─ 保留 → 記録して後回し
  │       └─ 却下 → 理由を記載してスキップ
  │
  └─ Low
      └─ レポートに記録のみ
```
