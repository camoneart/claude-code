# Agent Skills 作成例

このドキュメントでは、様々なタイプのAgent Skillsの具体例を紹介します。

## 例1: シンプルなSkill（単一ファイル）

### ディレクトリ構造
```
commit-helper/
└── SKILL.md
```

### SKILL.md
```markdown
---
name: Generating Commit Messages
description: Generates clear commit messages from git diffs. Use when writing commit messages, reviewing staged changes, or creating commits.
---

# Generating Commit Messages

## 目的
git diffから明確で意味のあるコミットメッセージを生成します。

## 使い方

### ステップ1: 変更を確認
```bash
git diff --staged
```

### ステップ2: コミットメッセージの提案
以下の形式でメッセージを提案します：

- 50文字以下の要約
- 詳細な説明
- 影響を受けるコンポーネント

## ベストプラクティス

- 現在形を使用
- 「何を」「なぜ」を説明（「どのように」ではない）
- 各コミットは1つの論理的な変更に限定

## 例

**良いコミットメッセージ:**
```
feat: add user authentication endpoint

Implement JWT-based authentication for API access.
Includes login, logout, and token refresh endpoints.

Components: auth-service, api-gateway
```

**悪いコミットメッセージ:**
```
Update files
```
```

---

## 例2: ツール制限付きSkill

### ディレクトリ構造
```
code-reviewer/
└── SKILL.md
```

### SKILL.md
```markdown
---
name: Code Reviewing
description: Review code for best practices, potential issues, and maintainability. Use when reviewing code, checking PRs, or analyzing code quality. Read-only access.
allowed-tools: Read, Grep, Glob
---

# Code Reviewing

## レビューチェックリスト

### 1. コード構成と構造
- [ ] 適切なファイル・フォルダ構成
- [ ] 関数・クラスのサイズが適切
- [ ] 命名規則の一貫性

### 2. エラーハンドリング
- [ ] エラーケースが適切に処理されている
- [ ] エラーメッセージが明確
- [ ] 例外が適切に伝播

### 3. パフォーマンス
- [ ] 不要なループや計算がない
- [ ] メモリ効率が考慮されている
- [ ] キャッシュが適切に使用されている

### 4. セキュリティ
- [ ] 入力値の検証
- [ ] SQLインジェクション対策
- [ ] 認証・認可の実装

### 5. テストカバレッジ
- [ ] ユニットテストが存在
- [ ] エッジケースがテストされている
- [ ] テストが理解しやすい

## 実行手順

1. **対象ファイルを読み込む**: Readツールを使用
2. **パターンを検索**: Grepツールを使用
3. **関連ファイルを探す**: Globツールを使用
4. **詳細なフィードバックを提供**: 上記チェックリストに基づく

## フィードバック形式

```markdown
## レビュー結果: [ファイル名]

### 良い点
- 具体的な良い実装を指摘

### 改善提案
- 優先度: 高/中/低
- 具体的な改善案と理由

### セキュリティ懸念
- 発見された問題と対策案
```
```

---

## 例3: マルチファイルSkill

### ディレクトリ構造
```
pdf-processing/
├── SKILL.md
├── examples.md
├── reference.md
└── scripts/
    ├── extract_text.py
    └── fill_form.py
```

### SKILL.md
```markdown
---
name: Processing PDFs
description: Extract text and tables from PDFs, fill forms, merge documents. Use when working with PDF files, forms, document extraction, or PDF manipulation. Requires pypdf and pdfplumber packages.
---

# Processing PDFs

## クイックスタート

### テキスト抽出
```python
import pdfplumber
with pdfplumber.open("document.pdf") as pdf:
    text = pdf.pages[0].extract_text()
    print(text)
```

### フォーム入力
フォーム入力の詳細は[examples.md](examples.md)を参照。

### API詳細
詳細なAPI仕様は[reference.md](reference.md)を参照。

## 必要な環境

以下のパッケージが必要です：
```bash
pip install pypdf pdfplumber
```

## 基本機能

1. **テキスト抽出**: PDFからテキストを抽出
2. **フォーム入力**: PDFフォームに値を入力
3. **ページ操作**: ページの結合・分割
4. **テーブル抽出**: 表データの抽出

## ヘルパースクリプト

### テキスト抽出スクリプト
```bash
python scripts/extract_text.py input.pdf output.txt
```

### フォーム入力スクリプト
```bash
python scripts/fill_form.py template.pdf data.json output.pdf
```
```

### examples.md
```markdown
# PDF Processing 使用例

## 例1: 複数ページからテキスト抽出

```python
import pdfplumber

def extract_all_text(pdf_path):
    all_text = []
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            text = page.extract_text()
            all_text.append(text)
    return "\n\n".join(all_text)

# 使用
text = extract_all_text("document.pdf")
print(text)
```

## 例2: テーブルデータの抽出

```python
import pdfplumber
import pandas as pd

def extract_tables(pdf_path):
    tables = []
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            page_tables = page.extract_tables()
            for table in page_tables:
                df = pd.DataFrame(table[1:], columns=table[0])
                tables.append(df)
    return tables

# 使用
tables = extract_tables("report.pdf")
for i, table in enumerate(tables):
    print(f"Table {i+1}:")
    print(table)
```

## 例3: PDFフォームへの入力

```python
from pypdf import PdfReader, PdfWriter

def fill_pdf_form(template_path, field_data, output_path):
    reader = PdfReader(template_path)
    writer = PdfWriter()

    # フィールドに値を設定
    writer.append_pages_from_reader(reader)
    writer.update_page_form_field_values(
        writer.pages[0], field_data
    )

    # 出力
    with open(output_path, 'wb') as output_file:
        writer.write(output_file)

# 使用
field_data = {
    "Name": "山田太郎",
    "Email": "yamada@example.com",
    "Phone": "090-1234-5678"
}
fill_pdf_form("template.pdf", field_data, "filled.pdf")
```
```

---

## 例4: ワークフロー重視のSkill

### ディレクトリ構造
```
api-testing/
├── SKILL.md
└── workflows.md
```

### SKILL.md
```markdown
---
name: Testing APIs
description: Test REST APIs, validate responses, and debug API issues. Use when testing endpoints, debugging API calls, or validating API responses.
allowed-tools: Bash, Read, Write
---

# Testing APIs

## ワークフロー

### ステップ1: エンドポイントの確認
```bash
curl -X GET https://api.example.com/health
```

### ステップ2: 認証の取得
```bash
curl -X POST https://api.example.com/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "test@example.com", "password": "test123"}'
```

### ステップ3: APIテストの実行
```bash
curl -X GET https://api.example.com/users \
  -H "Authorization: Bearer $TOKEN"
```

### ステップ4: レスポンスの検証

- [ ] ステータスコードが正しい（200, 201, etc.）
- [ ] レスポンスボディが期待通りの構造
- [ ] エラーハンドリングが適切
- [ ] パフォーマンスが許容範囲内

## 一般的なテストパターン

### GET リクエスト
```bash
curl -X GET "https://api.example.com/users?page=1&limit=10" \
  -H "Authorization: Bearer $TOKEN"
```

### POST リクエスト
```bash
curl -X POST "https://api.example.com/users" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "山田太郎",
    "email": "yamada@example.com"
  }'
```

### PUT リクエスト
```bash
curl -X PUT "https://api.example.com/users/123" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "山田花子"
  }'
```

### DELETE リクエスト
```bash
curl -X DELETE "https://api.example.com/users/123" \
  -H "Authorization: Bearer $TOKEN"
```

## デバッグテクニック

### 詳細な出力を取得
```bash
curl -v -X GET "https://api.example.com/users"
```

### レスポンスヘッダーのみ取得
```bash
curl -I "https://api.example.com/users"
```

### タイムアウトの設定
```bash
curl --max-time 30 "https://api.example.com/slow-endpoint"
```

## ベストプラクティス

- 環境変数でトークンを管理（ハードコードしない）
- レスポンスをログファイルに保存
- ステータスコードを常に確認
- エラーレスポンスの構造も検証
```

---

## 例5: 検証ループ付きSkill

### ディレクトリ構造
```
data-validator/
├── SKILL.md
└── validation-rules.md
```

### SKILL.md
```markdown
---
name: Validating Data
description: Validate data files, check schema compliance, and fix data quality issues. Use when validating CSV, JSON, or other data files, or checking data quality.
allowed-tools: Read, Write, Bash
---

# Validating Data

## 検証ワークフロー

### ステップ1: データファイルを読み込む
```python
import pandas as pd

df = pd.read_csv("data.csv")
print(df.head())
print(df.info())
```

### ステップ2: 検証ルールを実行

- [ ] 必須カラムが存在するか
- [ ] データ型が正しいか
- [ ] 欠損値がないか（許容される場合を除く）
- [ ] 値の範囲が妥当か
- [ ] 重複レコードがないか

### ステップ3: エラーを記録
```python
errors = []

# 必須カラムチェック
required_columns = ["id", "name", "email"]
for col in required_columns:
    if col not in df.columns:
        errors.append(f"Missing required column: {col}")

# NULL値チェック
null_counts = df.isnull().sum()
for col, count in null_counts.items():
    if count > 0 and col in required_columns:
        errors.append(f"Null values found in {col}: {count} rows")
```

### ステップ4: エラーを修正
```python
# 欠損値の処理
df["email"] = df["email"].fillna("unknown@example.com")

# 重複の削除
df = df.drop_duplicates(subset=["id"])
```

### ステップ5: 再検証

エラーがなくなるまでステップ2〜4を繰り返す。

### ステップ6: クリーンなデータを保存
```python
df.to_csv("data_clean.csv", index=False)
```

## 検証ルール詳細

詳細な検証ルールは[validation-rules.md](validation-rules.md)を参照。

## 一般的な検証パターン

### メールアドレスの検証
```python
import re

email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
df["email_valid"] = df["email"].apply(
    lambda x: bool(re.match(email_pattern, str(x))) if pd.notna(x) else False
)
```

### 日付フォーマットの検証
```python
from datetime import datetime

def validate_date(date_str):
    try:
        datetime.strptime(date_str, "%Y-%m-%d")
        return True
    except ValueError:
        return False

df["date_valid"] = df["date"].apply(validate_date)
```

### 数値範囲の検証
```python
df["age_valid"] = df["age"].between(0, 150)
```
```

---

## まとめ

これらの例から学べること：

1. **シンプルさを保つ**: 最初はシンプルに、必要に応じて拡張
2. **Progressive Disclosure**: 詳細は別ファイルへ
3. **具体的な例**: ユーザーがすぐに使える実例を提供
4. **ワークフローの明示**: ステップバイステップのガイド
5. **検証ループ**: 反復的な改善プロセスの組み込み

自分のSkillを作成する際は、これらの例を参考にしつつ、プロジェクトやチームの特定のニーズに合わせてカスタマイズしてください。
