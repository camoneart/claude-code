# 詳細な検索戦略ガイド

このドキュメントでは、Searcher Skillが使用する詳細な検索戦略とアルゴリズムを説明します。

---

## 検索意図の分類

### 1. ローカルファイル検索意図

**トリガーワード**:
- "このプロジェクト"、"コード内"、"ファイル"
- "関数"、"変数"、"クラス"
- "実装"、"使っている場所"
- ファイルパスやファイル名の言及

**使用MCP**: Desktop Commander (`mcp__desktop-commander__start_search`)

**詳細戦略**:

#### ファイル名検索 (searchType: "files")
```javascript
条件:
- ユーザーが具体的なファイル名を指定
- ファイル拡張子を含む検索
- "*.js"、"package.json" などのパターン

実行:
{
  searchType: "files",
  pattern: "[ファイル名パターン]",
  ignoreCase: true
}
```

#### コンテンツ検索 (searchType: "content")
```javascript
条件:
- 関数名、変数名、クラス名の検索
- コード内のテキスト検索
- "TODO"、"FIXME" などのコメント検索

実行:
{
  searchType: "content",
  pattern: "[検索パターン]",
  literalSearch: false,  // 正規表現を使用
  contextLines: 5        // 前後5行を含める
}
```

#### リテラル検索 (literalSearch: true)
```javascript
条件:
- 特殊文字を含むパターン
  例: "toast.error('test')", "user.name.first"
- 正確な文字列マッチが必要

実行:
{
  searchType: "content",
  pattern: "[正確な文字列]",
  literalSearch: true,   // 正規表現を無効化
  ignoreCase: false      // 大文字小文字を区別
}
```

#### 早期終了 (earlyTermination)
```javascript
条件:
- 特定のファイルを探している（例: "package.json"）
- 最初の一致で十分

実行:
{
  searchType: "files",
  pattern: "package.json",
  earlyTermination: true
}
```

---

### 2. Web検索意図

**トリガーワード**:
- "最新"、"ニュース"、"記事"
- "とは"、"について"、"教えて"
- "方法"、"やり方"、"how to"
- 技術用語、製品名、トピック名

**使用MCP**: Brave Web Search (`mcp__brave-search__brave_web_search`)

**詳細戦略**:

#### 一般的な情報検索
```javascript
条件:
- 幅広い情報を求めている
- ニュース、記事、チュートリアル

実行:
{
  query: "[自然言語クエリ]",
  count: 10,           // 結果数
  offset: 0            // ページネーション
}
```

#### 時間制約のある検索
```javascript
条件:
- "最新"、"2025年"、"今年" などの時間指定

実行:
{
  query: "[クエリ] 2025",
  count: 10
}

注: クエリに年号を追加して鮮度を確保
```

#### 技術ドキュメント検索
```javascript
条件:
- 公式ドキュメント、APIリファレンス
- "docs"、"documentation"、"official"

実行:
{
  query: "[技術名] official documentation",
  count: 5
}
```

---

### 3. 場所検索意図

**トリガーワード**:
- "near me"、"近く"、"付近"
- 具体的な地名、駅名、エリア名
- "レストラン"、"カフェ"、"店舗"、"営業時間"
- "住所"、"電話番号"、"評価"

**使用MCP**: Brave Local Search (`mcp__brave-search__brave_local_search`)

**詳細戦略**:

#### 基本的な場所検索
```javascript
条件:
- ビジネス名 + 地名

実行:
{
  query: "[ビジネスタイプ] near [地名]",
  count: 5
}

例: "カフェ near 渋谷駅"
```

#### 詳細情報取得
```javascript
結果に含まれる情報:
- 店舗名
- 住所
- 評価 (rating)
- レビュー数 (review count)
- 営業時間
- 電話番号

自動的に取得される
```

---

### 4. 詳細調査意図

**トリガーワード**:
- "詳しく"、"詳細"、"深く"
- "比較"、"複数"、"いくつか"
- "ベストプラクティス"、"実装例"
- "チュートリアル"、"ガイド"

**使用MCP**: Firecrawl Search (`mcp__firecrawl__firecrawl_search`)

**詳細戦略**:

#### 標準的な詳細検索
```javascript
条件:
- 複数のソースから詳細情報を抽出

実行:
{
  query: "[詳細トピック]",
  limit: 5,
  scrapeOptions: {
    formats: ["markdown"],
    onlyMainContent: true,
    waitFor: 2000        // 動的コンテンツの待機
  }
}
```

#### 言語・地域指定検索
```javascript
条件:
- 特定の言語や地域の情報が必要

実行:
{
  query: "[クエリ]",
  lang: "ja",           // 日本語
  country: "jp",        // 日本
  limit: 5
}
```

#### キャッシュ活用（高速化）
```javascript
条件:
- 最近アクセスしたページの再検索
- 頻繁に参照する情報源

実行:
{
  query: "[クエリ]",
  limit: 5,
  scrapeOptions: {
    formats: ["markdown"],
    maxAge: 3600000      // 1時間以内のキャッシュを使用
  }
}

効果: 500%の高速化
```

---

## 検索意図の優先順位アルゴリズム

### 優先順位決定フロー

```
ステップ1: トリガーワードの検出
  ↓
ステップ2: 検索対象の分類
  - ローカル: Desktop Commander
  - 場所: Brave Local Search
  - Web一般: Brave Web Search
  - Web詳細: Firecrawl Search
  ↓
ステップ3: 実行
  ↓
ステップ4: 結果評価
  ↓
ステップ5: 必要に応じて追加検索またはフォールバック
```

### 優先順位マトリックス

| 検索タイプ | 第一選択 | 第二選択 | フォールバック |
|-----------|----------|----------|----------------|
| ローカルファイル | Desktop Commander | Grep/Glob | - |
| Web一般 | Brave Web Search | Firecrawl | WebSearch |
| 場所 | Brave Local Search | Brave Web Search | - |
| Web詳細 | Firecrawl Search | Brave Web Search | WebSearch |

---

## 並列検索戦略

### 並列実行の条件

以下の場合に並列実行を推奨：

1. **独立した検索**: 2つの検索が相互に依存しない
2. **異なるソース**: ローカル + Web など
3. **補完的な情報**: 概要 + 詳細

### 並列実行のパターン

#### パターン1: ローカル + Web
```javascript
並列実行:
- Desktop Commander でローカル検索
- Brave Web Search で関連情報検索

統合:
ローカルの実装状況 + Webの最新情報
```

#### パターン2: 概要 + 詳細
```javascript
並列実行:
- Brave Web Search で概要検索
- Firecrawl Search で詳細記事検索

統合:
概要理解 + 実装詳細
```

#### パターン3: 複数キーワード
```javascript
並列実行:
- Brave Web Search でキーワード1
- Brave Web Search でキーワード2

統合:
総合的な情報収集
```

### 並列実行の注意点

1. **コンテキスト制限**: 大量の結果は要約
2. **優先順位**: 主要な結果を先に提示
3. **統合**: 関連性のある情報を結びつける

---

## フォールバック戦略

### フォールバック発動条件

1. **API制限エラー**: レート制限、クォータ超過
2. **タイムアウト**: 応答時間が長すぎる
3. **エラーレスポンス**: 4xx、5xxエラー
4. **空の結果**: 検索結果が0件

### フォールバックフロー

```
Brave Web Search
  ↓ (失敗)
Firecrawl Search
  ↓ (失敗)
WebSearch
  ↓ (失敗)
エラーメッセージ + 手動検索の提案
```

### Brave Local Search フォールバック
```
Brave Local Search
  ↓ (失敗)
Brave Web Search + 地名キーワード
```

### Desktop Commander フォールバック
```
Desktop Commander
  ↓ (失敗)
Grep ���ール（コンテンツ検索）
Glob ツール（ファイル検索）
```

---

## クエリ最適化テクニック

### 1. キーワード抽出

ユーザーの自然言語から検索に適したキーワードを抽出：

```javascript
入力: "React Hooksの使い方を詳しく教えて"
  ↓
抽出: ["React Hooks", "usage", "tutorial"]
  ↓
クエリ: "React Hooks usage tutorial"
```

### 2. 同義語の活用

```javascript
"方法" → "how to", "tutorial", "guide"
"最新" → "latest", "2025", "new"
"ベストプラクティス" → "best practices", "patterns"
```

### 3. 否定語の除外

```javascript
クエリ: "TypeScript エラー"
最適化: "TypeScript -error handling"  // "error handling"を除外

注: 検索精度を上げるため
```

### 4. フレーズ検索

```javascript
完全一致が必要な場合:
クエリ: "\"exact phrase\""

例: "\"React Server Components\""
```

---

## パフォーマンス最適化

### 1. 結果数の調整

```javascript
概要検索: count = 5
詳細検索: count = 10
網羅的検索: count = 20

バランス: 精度 vs 速度
```

### 2. タイムアウト設定

```javascript
Desktop Commander:
timeout_ms: 10000  // 10秒

Firecrawl:
waitFor: 2000     // 2秒（動的コンテンツ）

調整: コンテンツの複雑さに応じて
```

### 3. キャッシュ戦略

```javascript
Firecrawl maxAge:
- 頻繁に更新: 300000   // 5分
- 安定したコンテンツ: 3600000  // 1時間
- 静的ページ: 86400000  // 24時間
```

### 4. 段階的検索

```javascript
フェーズ1: 少数の結果で評価（count: 3）
  ↓
評価: 十分か？
  ↓ (不十分)
フェーズ2: 追加検索（count: 7）
```

---

## エラーハンドリング

### 一般的なエラーと対処

#### 1. API制限エラー
```
エラー: "API rate limit exceeded"

対処:
1. フォールバックMCPに切り替え
2. 少し待機してリトライ（exponential backoff）
3. ユーザーに状況を説明
```

#### 2. タイムアウトエラー
```
エラー: "Request timeout"

対処:
1. timeout値を増やして再試行
2. 別のMCPで試行
3. クエリを簡略化
```

#### 3. 空の結果
```
エラー: 検索結果が0件

対処:
1. クエリを一般化（より広い検索語）
2. 同義語で再検索
3. 別のMCPで試行
```

#### 4. 認証エラー
```
エラー: "Authentication failed"

対処:
1. MCP設定を確認
2. 別のMCPにフォールバック
3. ユーザーに設定確認を依頼
```

---

## 検索品質の評価

### 結果の評価基準

1. **関連性**: クエリとの一致度
2. **鮮度**: 情報の新しさ
3. **信頼性**: ソースの信頼度
4. **完全性**: 必要な情報がすべて含まれているか

### 品質スコアリング（内部）

```javascript
スコア = 関連性(0-40) + 鮮度(0-30) + 信頼性(0-20) + 完全性(0-10)

70点以上: 高品質
50-69点: 中品質（追加検索を検討）
50点未満: 低品質（再検索または別MCP）
```

---

## ベストプラクティス

### 検索実行前

1. **意図を明確化**: 何を探しているか
2. **最適なMCPを選択**: 検索対象に応じて
3. **クエリを最適化**: キーワード抽出、同義語活用

### 検索実行中

1. **並列実行を活用**: 独立した検索は並列化
2. **タイムアウトを設定**: 無限待機を避ける
3. **進捗を通知**: ユーザーに状況を伝える

### 検索実行後

1. **結果を評価**: 品質スコアリング
2. **必要に応じて追加検索**: 不十分な場合
3. **結果を統合**: 複数ソースの情報を結合

---

## まとめ

効果的な検索戦略の鍵：

1. **正確な意図識別**: トリガーワードから検索タイプを判断
2. **最適なMCP選択**: 各MCPの強みを活かす
3. **クエリ最適化**: キーワード抽出、同義語、フレーズ
4. **並列実行**: 独立した検索は並列化して効率化
5. **フォールバック**: 失敗時の代替手段を準備
6. **品質評価**: 結果を評価し、必要に応じて追加検索

これらの戦略を組み合わせることで、Searcher Skillは常に最適な検索結果を提供します。
