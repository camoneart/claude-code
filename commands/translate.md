# /translate

## 概要

指定されたURLの記事やドキュメントを日本語に翻訳し、Markdownファイルとして保存します。

## 実行内容

1. **コンテンツの取得**
   - 指定されたURLから記事・ドキュメントを取得
   - HTML/Markdown形式のコンテンツを抽出

2. **翻訳処理**
   - 英語から日本語への翻訳
   - 技術用語は適切に保持または注釈付き
   - マークダウン構造を維持
   - コードブロックは翻訳せずに保持

3. **ファイル保存**
   - `_docs/translations/`ディレクトリに保存
   - ファイル名: `YYYY-MM-DD_[元タイトル-日本語訳].md`
   - 元の記事へのリンクを冒頭に記載

## 保存形式

```markdown
---
title: [日本語タイトル]
original_title: [元のタイトル]
original_url: [元のURL]
translated_date: YYYY-MM-DD
---

# [日本語タイトル]

*この記事は [元のタイトル]([URL]) の日本語訳です。*

[翻訳された本文]
```

## 使用例

```
/translate https://example.com/article
```

または、タイトルを指定：

```
/translate https://example.com/article --title "カスタムタイトル"
```

## オプション

- `--title [title]`: 保存時のファイル名に使用するタイトルを指定
- `--keep-original`: 原文を併記（対訳形式）
- `--technical`: 技術文書モード（専門用語を英語のまま保持）

## 注意事項

- 長い記事の場合は分割して処理
- 画像は元のURLをそのまま参照
- 表やコードブロックの構造を維持
- ライセンス情報がある場合は記載