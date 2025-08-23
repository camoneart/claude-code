# /fetch-and-slide

## 概要

指定されたURLから記事をフェッチし、その内容を基にプレゼンテーション用スライドを自動生成します。

## 実行内容

1. **記事の取得**
   - 指定されたURLから記事コンテンツを取得
   - Zenn.dev API を使用（https://zenn.dev/api/articles?username=bojjidev&order=latest）
   - 最新記事の情報を取得後、個別記事のマークダウン形式の本文を抽出

2. **コンテンツ解析**
   - 記事の構造を分析（見出し、セクション、コードブロック）
   - 重要なポイントを抽出
   - 画像やコードスニペットの識別

3. **スライド生成**
   - Marp形式のマークダウンファイルを生成
   - 1スライドあたり適切な情報量に分割
   - コードハイライトとビジュアル要素の配置
   - `_docs/slides/`ディレクトリに保存

## スライドテンプレート

- **タイトルスライド**: 記事タイトル、著者、日付
- **概要スライド**: 記事の要約と主要ポイント
- **コンテンツスライド**: セクションごとの内容
- **コードスライド**: 重要なコード例
- **まとめスライド**: キーポイントの振り返り

## Marp設定

```yaml
marp: true
theme: default
paginate: true
backgroundColor: #fff
```

## 出力形式

```
_docs/slides/YYYY-MM-DD_[記事タイトル].md
```

## 使用例

```
/fetch-and-slide https://zenn.dev/api/articles?username=bojjidev&order=latest
```

または、最新記事を自動取得：

```
/fetch-and-slide latest
```

## オプション

- `--theme [theme-name]`: スライドテーマを指定（default, gaia, uncover）
- `--sections [number]`: スライド分割の粒度を調整
- `--code-highlight`: コードハイライトを有効化

## 注意事項

- 長い記事の場合、重要なセクションを優先的に抽出
- コードブロックは読みやすいサイズに分割
- 画像はURLリンクとして埋め込み