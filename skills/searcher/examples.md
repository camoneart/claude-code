# Searcher Skill 使用例

このドキュメントでは、Searcher Skillの具体的な使用例を紹介します。

---

## 例1: ローカルファイル検索（Desktop Commander）

### シナリオ
プロジェクト内で特定の関数を使用している箇所を探したい。

### ユーザーの質問
```
このプロジェクトでgetUserData関数を使っている場所を全て見つけて
```

### Searcherの判断プロセス

1. **検索対象の識別**: "このプロジェクトで" → ローカルファイル検索
2. **MCP選択**: Desktop Commander (content search)
3. **検索戦略**: 関数名 "getUserData" をコンテンツ検索

### 実行コマンド
```
🌟Claudeは Desktop Commander MCP サーバー を唱えた！

mcp__desktop-commander__start_search({
  path: "/path/to/project",
  pattern: "getUserData",
  searchType: "content",
  literalSearch: false
})
```

### 期待される結果
```
検索結果:
- src/api/user.ts:42 - function getUserData(userId: string) {...}
- src/components/Profile.tsx:18 - const data = await getUserData(user.id)
- src/hooks/useUser.ts:12 - const userData = getUserData(userId)
```

---

## 例2: 一般的なWeb検索（Brave Web Search）

### シナリオ
最新の技術情報を調べたい。

### ユーザーの質問
```
React 19の新機能を教えて
```

### Searcherの判断プロセス

1. **検索対象の識別**: "React 19の新機能" → Web上の最新情報
2. **MCP選択**: Brave Web Search
3. **検索戦略**: 技術的なトピックなので一般的なWeb検索

### 実行コマンド
```
🌟Claudeは Brave-Search MCP サーバー を唱えた！

mcp__brave-search__brave_web_search({
  query: "React 19 new features",
  count: 10
})
```

### 期待される結果
```
検索結果:
1. React 19 公式ブログ - 新機能の概要
2. React Server Components の詳細
3. React Compiler の紹介記事
...
```

---

## 例3: 場所検索（Brave Local Search）

### シナリオ
特定の場所付近の店舗を探したい。

### ユーザーの質問
```
渋谷駅近くの美味しいラーメン屋を探して
```

### Searcherの判断プロセス

1. **検索対象の識別**: "渋谷駅近く" + "ラーメン屋" → 場所検索
2. **MCP選択**: Brave Local Search
3. **検索戦略**: "ラーメン near 渋谷駅" 形式で検索

### 実行コマンド
```
🌟Claudeは Brave-Search MCP サーバー を唱えた！

mcp__brave-search__brave_local_search({
  query: "ラーメン near 渋谷駅",
  count: 5
})
```

### 期待される結果
```
検索結果:
1. ラーメン一蘭 渋谷店
   - 住所: 東京都渋谷区...
   - 評価: 4.5/5
   - 営業時間: 11:00-23:00

2. 麺屋武蔵 渋谷店
   - 住所: 東京都渋谷区...
   - 評価: 4.3/5
   - 営業時間: 11:30-22:00
...
```

---

## 例4: 詳細調査（Firecrawl Search）

### シナリオ
特定のトピックについて複数のソースから詳細な情報を集めたい。

### ユーザーの質問
```
TypeScriptの型安全なAPI設計について、ベストプラクティスを詳しく調べて
```

### Searcherの判断プロセス

1. **検索対象の識別**: "詳しく調べて" → 詳細調査
2. **MCP選択**: Firecrawl Search
3. **検索戦略**: 複数のソースから詳細コンテンツを抽出

### 実行コマンド
```
🌟Claudeは Firecrawl MCP サーバー を唱えた！

mcp__firecrawl__firecrawl_search({
  query: "TypeScript type-safe API design best practices",
  limit: 5,
  scrapeOptions: {
    formats: ["markdown"],
    onlyMainContent: true
  }
})
```

### 期待される結果
```
検索結果（スクレイピング済みコンテンツ付き）:
1. TypeScript Deep Dive - API Design
   - 詳細なMarkdown コンテンツ

2. Matt Pocock's Blog - Type-safe APIs
   - 実装例とベストプラクティス

3. Total TypeScript - API Patterns
   - パターン集とコード例
...
```

---

## 例5: 複合検索（複数MCPの組み合わせ）

### シナリオ
Web上の情報とローカルの実装を両方確認したい。

### ユーザーの質問
```
React Queryの最新の使い方を調べて、このプロジェクトでの使用状況も確認して
```

### Searcherの判断プロセス

1. **検索対象の識別**: Web情報 + ローカルコード → 複合検索
2. **MCP選択**: Brave Web Search + Desktop Commander
3. **検索戦略**: 並列実行で効率化

### 実行コマンド（並列実行）
```
🌟Claudeは Brave-Search MCP サーバー を唱えた！
🌟Claudeは Desktop Commander MCP サーバー を唱えた！

# 並列実行1: Web検索
mcp__brave-search__brave_web_search({
  query: "React Query latest usage 2025",
  count: 5
})

# 並列実行2: ローカルコード検索
mcp__desktop-commander__start_search({
  path: "/path/to/project",
  pattern: "useQuery|useMutation",
  searchType: "content",
  literalSearch: false
})
```

### 期待される結果
```
Web検索結果:
1. React Query v5 公式ドキュメント
2. 最新のベストプラクティス記事
...

ローカル検索結果:
- src/hooks/useUserData.ts:8 - const { data } = useQuery(['user', userId], ...)
- src/components/EditProfile.tsx:15 - const mutation = useMutation(updateUser, ...)
...

統合分析:
現在のプロジェクトではReact Query v4を使用中。
v5への移行ポイント: ...
```

---

## 例6: フォールバック検索（Brave失敗時）

### シナリオ
Brave Searchが利用できない場合の自動フォールバック。

### ユーザーの質問
```
Next.js 15の新機能について教えて
```

### Searcherの判断プロセス

1. **第一選択**: Brave Web Search を試行
2. **失敗検出**: Brave SearchがAPI制限やエラー
3. **フォールバック**: WebSearch に切り替え

### 実行フロー
```
# 第一試行
🌟Claudeは Brave-Search MCP サーバー を唱えた！
mcp__brave-search__brave_web_search(...)
→ エラー: API rate limit exceeded

# 自動フォールバック
WebSearch({
  query: "Next.js 15 new features"
})
```

### 期待される結果
```
WebSearchから結果取得:
1. Next.js 15 公式発表
2. 主要な新機能の概要
...

※ Brave Searchが一時的に利用できないため、WebSearchで代替しました。
```

---

## 例7: 並列検索の最適化

### シナリオ
関連する複数の情報を効率的に収集したい。

### ユーザーの質問
```
TailwindCSSの最新動向と、このプロジェクトで使用しているバージョンを確認して
```

### Searcherの判断プロセス

1. **検索対象の識別**: Web情報（最新動向） + ローカル情報（使用バージョン）
2. **最適化戦略**: 2つは独立しているため並列実行
3. **MCP選択**: Brave Web Search + ファイル読み取り

### 実行コマンド（並列実行）
```
🌟Claudeは Brave-Search MCP サーバー を唱えた！

# 並列実行1: 最新動向の検索
mcp__brave-search__brave_web_search({
  query: "TailwindCSS latest updates 2025",
  count: 5
})

# 並列実行2: package.json確認
Read({
  file_path: "/path/to/project/package.json"
})
```

### 期待される結果
```
最新動向:
- TailwindCSS v4.0のリリース
- 新しいカラーパレット
- パフォーマンス改善
...

プロジェクトの使用状況:
- 現在のバージョン: TailwindCSS v3.4.1
- 設定ファイル: tailwind.config.js
- カスタムテーマ: あり

推奨アクション:
v4.0へのアップグレードを検討...
```

---

## 例8: 段��的検索（初期検索 → 詳細調査）

### シナリオ
まず概要を把握してから、詳細を深堀りする。

### ユーザーの質問
```
GraphQLについて基本を教えてから、実装例も見せて
```

### Searcherの判断プロセス

1. **第一段階**: Brave Web Searchで基本情報
2. **第二段階**: Firecrawl Searchで実装例の詳細
3. **戦略**: 段階的に詳細度を上げる

### 実行フロー
```
# ステップ1: 基本情報
🌟Claudeは Brave-Search MCP サーバー を唱えた！
mcp__brave-search__brave_web_search({
  query: "GraphQL basics tutorial",
  count: 3
})

# 結果確認後、ステップ2: 詳細実装例
🌟Claudeは Firecrawl MCP サーバー を唱えた！
mcp__firecrawl__firecrawl_search({
  query: "GraphQL implementation examples TypeScript",
  limit: 3,
  scrapeOptions: {
    formats: ["markdown"],
    onlyMainContent: true
  }
})
```

### 期待される結果
```
基本情報:
- GraphQLとは: クエリ言語の概要
- RESTとの違い
- 主な利点
...

実装例（詳細コンテンツ付き）:
1. Apollo Server with TypeScript
   - サーバーセットアップコード
   - スキーマ定義例

2. GraphQL Code Generator
   - 型安全なクライアント実装

3. Best Practices
   - パフォーマンス最適化
   - エラーハンドリング
...
```

---

## まとめ

これらの例から学べる検索戦略：

1. **検索対象の正確な識別**: ローカル/Web/場所を見極める
2. **最適なMCPの選択**: 各MCPの強みを活かす
3. **並列実行の活用**: 独立した検索は並列化して効率化
4. **フォールバック戦略**: 失敗時の代替手段を準備
5. **段階的アプローチ**: 概要 → 詳細の順で情報収集
6. **複合検索**: 複数の情報源を組み合わせて総合的な回答を生成

Searcher Skillはこれらの戦略を自動的に適用し、最適な検索結果を提供します。
