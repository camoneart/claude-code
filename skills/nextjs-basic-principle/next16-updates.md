# Next.js 16 アップデート＆移行ガイド

*2025年10月21日リリース*

## 🚨 破壊的変更（Breaking Changes）

### 1. 非同期 params と searchParams

#### Before (Next.js 15以前)
```tsx
// 同期的にアクセス可能
export default function Page({ params, searchParams }) {
  const id = params.id;
  const query = searchParams.q;
  return <div>{id} - {query}</div>;
}
```

#### After (Next.js 16)
```tsx
// 非同期でアクセス必須
export default async function Page(props) {
  const params = await props.params;
  const searchParams = await props.searchParams;
  const id = params.id;
  const query = searchParams.q;
  return <div>{id} - {query}</div>;
}
```

### 2. Node.js 最小要件
- **必須**: Node.js 20.9 以上
- Node.js 18系のサポート終了

### 3. キャッシングAPI変更
```tsx
// Before
revalidateTag('posts');

// After - cacheLifeプロファイルが必須
revalidateTag('posts', { expire: 300 });
```

## ✨ 新機能

### 1. Cache Components ("use cache"ディレクティブ)

明示的なキャッシング戦略を提供：

```tsx
// ファイルレベルでのキャッシング
"use cache";

export default async function CachedPage() {
  const data = await fetchData();
  return <div>{data}</div>;
}
```

```tsx
// 関数レベルでのキャッシング
export async function getCachedData() {
  "use cache";
  const data = await expensiveOperation();
  return data;
}
```

### 2. updateTag() API

Server Action内で即座にキャッシュを更新：

```tsx
'use server';

import { updateTag } from 'next/cache';

export async function updatePost(postId: string) {
  // データベース更新
  await updateDatabase(postId);

  // 即座にキャッシュを更新（ユーザーに変更が見える）
  updateTag(`post-${postId}`);
}
```

### 3. proxy.ts (middleware.ts の代替)

ネットワーク境界をより明確に定義：

```tsx
// proxy.ts
export default function proxy(request: Request) {
  const url = new URL(request.url);

  if (url.pathname.startsWith('/api/')) {
    // APIルートの処理
    return handleApiRoute(request);
  }

  // その他のルート
  return NextResponse.next();
}
```

### 4. Turbopack がデフォルトに

```json
// next.config.js - 設定不要でTurbopackが有効
{
  // turbo: true が不要に
}
```

パフォーマンス向上：
- **2-5倍高速**な本番ビルド
- **最大10倍高速**なFast Refresh

### 5. React Compiler 統合

自動的なメモ化とコンポーネント最適化：

```tsx
// React Compilerが自動最適化
function ExpensiveComponent({ data }) {
  // 自動的にメモ化される
  const processedData = heavyComputation(data);

  return <div>{processedData}</div>;
}
```

## 📋 移行チェックリスト

### 環境準備
- [ ] Node.js を 20.9 以上にアップデート
- [ ] package.json の engines フィールドを更新
  ```json
  "engines": {
    "node": ">=20.9.0"
  }
  ```

### コード更新
- [ ] 全ての Page/Layout コンポーネントで params/searchParams を非同期化
- [ ] revalidateTag() 呼び出しにcacheLifeプロファイルを追加
- [ ] middleware.ts を proxy.ts に移行（必要な場合）

### キャッシング戦略の見直し
- [ ] 暗黙的なキャッシングに依存した箇所を特定
- [ ] "use cache" ディレクティブで明示的なキャッシングに移行
- [ ] updateTag() を使用してServer Actionを最適化

### パフォーマンス最適化
- [ ] Turbopack の利点を活用（追加設定不要）
- [ ] React Compiler の自動最適化を確認

## 🔄 段階的移行戦略

### Phase 1: 準備（必須）
1. Node.js 20.9以上にアップデート
2. Next.js 16にアップグレード
3. 非同期params/searchParamsに対応

### Phase 2: 最適化（推奨）
1. "use cache"ディレクティブの導入
2. updateTag()でキャッシュ更新を改善
3. middleware.tsからproxy.tsへの移行検討

### Phase 3: 先進機能（オプション）
1. React Compilerの活用
2. Turbopackの詳細設定
3. 新しいキャッシング戦略の全面導入

## ⚠️ 注意事項

### next/image の変更
- 最小キャッシュTTL: 60秒 → **4時間**
- 品質設定: `[1..100]` → **`[75]`のみ**

```tsx
// Next.js 16では品質設定が制限される
<Image
  src="/hero.jpg"
  quality={75} // 75のみ許可
  alt=""
/>
```

### 後方互換性
- Next.js 15のプロジェクトはアップグレード前に必ず破壊的変更への対応が必要
- 特に非同期params/searchParamsは全てのページで修正が必要

## 📚 参考リンク

- [Next.js 16 公式ブログ](https://nextjs.org/blog/next-16)
- [アップグレードガイド](https://nextjs.org/docs/app/building-your-application/upgrading/version-16)
- [Cache Components詳細](https://nextjs.org/docs/app/building-your-application/caching#cache-components)