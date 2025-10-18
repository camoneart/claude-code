---
name: Creating Agent Skills
description: Guide Claude through creating well-structured Agent Skills following best practices. Use when creating new Skills, authoring SKILL.md files, or when the user asks to build a Skill for Claude Code.
allowed-tools: Write, Read, Edit, Bash
---

# Creating Agent Skills

このSkillは、Claude CodeのAgent Skillsをベストプラクティスに沿って作成する際のガイドラインとワークフローを提供します。

## 基本原則

### 1. 簡潔性が最重要
- SKILL.mdは500行以下に保つこと
- Claudeが既に知っている情報は含めない
- 各情報に対して「Claudeは本当にこの説明が必要か？」と問いかける

### 2. 適切な自由度の設定
- **高い自由度**（テキスト説明）: 複数の有効なアプローチが存在する場合
- **中程度の自由度**（疑似コード/パラメータ）: 優先パターンがあるが多少の変更は可能
- **低い自由度**（具体的なスクリプト）: 正確な手順が必要な場合

### 3. モデル間テスト
- Claude Haiku、Sonnet、Opusで動作確認すること

## Skillの作成ワークフロー

### ステップ1: Skillタイプの選択

ユーザーに以下を確認：
- **Personal Skills** (`~/.claude/skills/`): 個人のワークフロー用
- **Project Skills** (`.claude/skills/`): チーム共有用

### ステップ2: ディレクトリ構造の作成

```bash
# Personal Skills
mkdir -p ~/.claude/skills/skill-name

# Project Skills
mkdir -p .claude/skills/skill-name
```

### ステップ3: SKILL.mdの作成

必須要素：
1. **YAMLフロントマター**（name、description）
2. **明確な説明文**（何をするか、いつ使うか）
3. **段階的な指示**
4. **具体的な例**

### ステップ4: サポートファイルの追加（オプション）

Progressive Disclosureパターンを使用：
- `examples.md`: 具体的な使用例
- `reference.md`: 詳細なAPI仕様
- `templates/`: テンプレートファイル
- `scripts/`: ヘルパースクリプト

## 命名規則

### Skill名
- 動名詞形（verb + -ing）を使用
  - ✅ "Processing PDFs"
  - ✅ "Analyzing Spreadsheets"
  - ❌ "Helper"
  - ❌ "Utils"

### ディレクトリ名
- ケバブケース（kebab-case）を使用
  - ✅ `pdf-processing`
  - ✅ `commit-helper`
  - ❌ `PDF_Processing`
  - ❌ `commitHelper`

## 効果的なdescriptionの書き方

descriptionは、ClaudeがいつこのSkillを使用すべきかを判断するための最重要要素です。

### 良い例
```yaml
description: Extract text and tables from PDFs, fill forms, merge documents. Use when working with PDF files, document extraction, or when the user mentions PDFs or forms.
```

### 悪い例
```yaml
description: Helps with documents
```

### チェックリスト
- [ ] 第三人称で記述されている
- [ ] 何をするSkillかが明確
- [ ] いつ使うべきかが具体的
- [ ] キーワード・トリガーが含まれている

## YAMLフロントマター構造

```yaml
---
name: Skill Name (動名詞形)
description: 具体的な説明。何をするか + いつ使うか。
allowed-tools: Read, Write, Edit  # オプション: ツール制限
---
```

### allowed-toolsの使用

特定のツールのみに制限したい場合：
```yaml
allowed-tools: Read, Grep, Glob  # 読み取り専用Skill
```

## Progressive Disclosure パターン

SKILL.mdはナビゲーションハブとして機能させ、詳細は別ファイルへ：

### パターン1: 概要 + 詳細への参照
```markdown
# Quick Start

基本的な使い方...

詳細は[reference.md](reference.md)を参照。
```

### パターン2: ドメイン別整理
```markdown
# 機能別ガイド

- 財務分析: [finance.md](finance.md)
- 営業分析: [sales.md](sales.md)
```

### パターン3: 条件付き詳細
```markdown
# 基本機能

シンプルな操作...

高度な使い方は[advanced.md](advanced.md)を参照。
```

## ワークフローとフィードバックループ

### 複雑なタスクのワークフロー

段階的なチェックリストを提供：

```markdown
## 作業フロー

- [ ] ステップ1: ファイルを読み込む
- [ ] ステップ2: データを検証する
- [ ] ステップ3: 変換を実行する
- [ ] ステップ4: 結果を確認する
```

### 検証ループパターン

```markdown
## 検証プロセス

1. バリデーターを実行
2. エラーがある場合は修正
3. 再度検証
4. エラーがなくなるまで繰り返し
```

## 避けるべき内容

### 時間依存の情報
❌ 「2025年10月時点では...」
✅ セクション分け: "Old Patterns" / "Current Patterns"

### 一貫性のない用語
❌ 同じ概念に対して複数の用語を使用
✅ 1つの用語を統一して使用

### 冗長な説明
❌ Claudeが既に知っている一般的な概念の説明
✅ Skill固有の情報のみ

## テンプレート

詳細なテンプレートは[templates.md](templates.md)を参照してください。

## 例

具体的な例は[examples.md](examples.md)を参照してください。

## トラブルシューティング

### Claudeがスキルを使用しない場合

1. **descriptionを具体的にする**
   - キーワード・トリガーを追加
   - 使用タイミングを明記

2. **YAMLシンタックスを確認**
   ```bash
   cat SKILL.md | head -n 15
   ```

3. **ファイルパスを確認**
   ```bash
   ls ~/.claude/skills/*/SKILL.md
   ```

### Skillにエラーがある場合

1. **依存関係を確認**
   - 必要なパッケージがインストールされているか

2. **スクリプトの実行権限を確認**
   ```bash
   chmod +x scripts/*.py
   ```

3. **ファイルパスを確認**
   - Unixスタイルのパス（`/`）を使用

## ベストプラクティスチェックリスト

Skill作成完了前に以下を確認：

- [ ] SKILL.mdが500行以下
- [ ] descriptionが具体的（何をするか + いつ使うか）
- [ ] 動名詞形の命名
- [ ] YAMLフロントマターが正しい
- [ ] Progressive Disclosureパターンの使用
- [ ] 具体的な例を含む
- [ ] 段階的な指示がある
- [ ] 時間依存の情報を含まない
- [ ] 一貫した用語を使用
- [ ] チームでテスト済み（Project Skillsの場合）

## 次のステップ

Skill作成後：

1. **テスト**: 関連する質問でSkillが発動するか確認
2. **デバッグ**: 問題があれば上記トラブルシューティングを参照
3. **共有**: Project Skillsの場合はgitでコミット
4. **ドキュメント化**: バージョン履歴を追加
