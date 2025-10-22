# Next.js Basic Principles - 実装例

## Server Components の実装例

### 基本的なServer Component

```tsx
// app/products/page.tsx
// データフェッチをServer Componentで行う
async function ProductList() {
  // Server Componentではasync/awaitが直接使える
  const products = await fetch('https://api.example.com/products', {
    // Request Memoizationが自動的に適用される
    cache: 'force-cache',
    next: { revalidate: 3600 } // 1時間ごとに再検証
  }).then(res => res.json());

  return (
    <div className="grid grid-cols-3 gap-4">
      {products.map(product => (
        <ProductCard key={product.id} product={product} />
      ))}
    </div>
  );
}
```

### データローダーパターン

```tsx
// app/lib/loaders/user.ts
import { cache } from 'react';

// cache()でリクエストメモ化を明示的に適用
export const getUser = cache(async (userId: string) => {
  const user = await fetch(`/api/users/${userId}`);
  if (!user.ok) throw new Error('User not found');
  return user.json();
});

// app/profile/[id]/page.tsx
import { getUser } from '@/lib/loaders/user';

export default async function ProfilePage({ params }) {
  const user = await getUser(params.id);

  return <UserProfile user={user} />;
}
```

## Client Components の実装例

### Composition Pattern

```tsx
// app/components/SearchableList.tsx
// Server Component (親)
import SearchInput from './SearchInput';
import ProductList from './ProductList';

export default async function SearchableList() {
  const products = await fetchProducts();

  return (
    <div>
      {/* Client Componentを子として配置 */}
      <SearchInput />
      {/* Server Componentのまま維持 */}
      <ProductList products={products} />
    </div>
  );
}

// app/components/SearchInput.tsx
// Client Component (子)
'use client';

import { useState } from 'react';

export default function SearchInput() {
  const [query, setQuery] = useState('');

  return (
    <input
      type="search"
      value={query}
      onChange={(e) => setQuery(e.target.value)}
      placeholder="商品を検索..."
    />
  );
}
```

### Container/Presentational Pattern

```tsx
// app/components/UserDashboard.tsx
// Container Component (Client Component)
'use client';

import { useUser } from '@/hooks/useUser';
import DashboardView from './DashboardView';

export default function UserDashboard() {
  const { user, isLoading } = useUser();

  if (isLoading) return <div>Loading...</div>;

  return <DashboardView user={user} />;
}

// app/components/DashboardView.tsx
// Presentational Component (Server Component)
export default function DashboardView({ user }) {
  return (
    <div className="dashboard">
      <h1>Welcome, {user.name}</h1>
      <div className="stats">
        {/* UIのみを担当 */}
      </div>
    </div>
  );
}
```

## 並行フェッチの実装例

```tsx
// app/dashboard/page.tsx
export default async function DashboardPage() {
  // 並行フェッチ - Promise.allで複数のデータを同時に取得
  const [userData, analyticsData, notificationsData] = await Promise.all([
    fetch('/api/user').then(res => res.json()),
    fetch('/api/analytics').then(res => res.json()),
    fetch('/api/notifications').then(res => res.json())
  ]);

  return (
    <div>
      <UserInfo data={userData} />
      <Analytics data={analyticsData} />
      <Notifications data={notificationsData} />
    </div>
  );
}
```

## Suspense & Streaming の実装例

```tsx
// app/posts/page.tsx
import { Suspense } from 'react';
import PostList from './PostList';
import Sidebar from './Sidebar';

export default function PostsPage() {
  return (
    <div className="flex gap-4">
      <main className="flex-1">
        <Suspense fallback={<PostListSkeleton />}>
          <PostList />
        </Suspense>
      </main>
      <aside className="w-80">
        <Suspense fallback={<SidebarSkeleton />}>
          <Sidebar />
        </Suspense>
      </aside>
    </div>
  );
}

// PostListとSidebarは独立してストリーミングされる
async function PostList() {
  const posts = await fetchPosts(); // 時間がかかる処理
  return <>{/* posts rendering */}</>;
}

async function Sidebar() {
  const trending = await fetchTrending(); // 時間がかかる処理
  return <>{/* sidebar rendering */}</>;
}
```

## Dynamic I/O の実装例

```tsx
// app/api/data/route.ts
import { unstable_noStore as noStore } from 'next/cache';

export async function GET() {
  // Dynamic I/Oを使用してキャッシュを無効化
  noStore();

  const data = await fetchRealtimeData();

  return Response.json(data);
}
```

## エラーハンドリングの実装例

```tsx
// app/products/error.tsx
'use client';

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <div className="error-container">
      <h2>エラーが発生しました</h2>
      <p>{error.message}</p>
      <button onClick={reset}>再試行</button>
    </div>
  );
}

// app/products/page.tsx
export default async function ProductsPage() {
  const products = await fetchProducts();

  if (!products) {
    throw new Error('商品データの取得に失敗しました');
  }

  return <ProductGrid products={products} />;
}
```

## Partial Pre-Rendering (PPR) の実装例

```tsx
// app/layout.tsx
export const experimental_ppr = true; // PPRを有効化

// app/page.tsx
import { Suspense } from 'react';

export default function HomePage() {
  return (
    <div>
      {/* 静的な部分 - ビルド時にプリレンダリング */}
      <Header />

      {/* 動的な部分 - リクエスト時にレンダリング */}
      <Suspense fallback={<ContentSkeleton />}>
        <DynamicContent />
      </Suspense>

      {/* 静的な部分 */}
      <Footer />
    </div>
  );
}
```

## Server Actions の実装例

```tsx
// app/actions/user.ts
'use server';

import { revalidatePath } from 'next/cache';

export async function updateUser(formData: FormData) {
  const name = formData.get('name');
  const email = formData.get('email');

  // データベース更新
  await db.user.update({
    where: { email },
    data: { name }
  });

  // キャッシュの再検証
  revalidatePath('/profile');
}

// app/profile/EditForm.tsx
import { updateUser } from '@/actions/user';

export default function EditForm({ user }) {
  return (
    <form action={updateUser}>
      <input name="email" type="hidden" value={user.email} />
      <input name="name" defaultValue={user.name} />
      <button type="submit">更新</button>
    </form>
  );
}

## Next.js 16 新機能の実装例

### 非同期 params/searchParams

```tsx
// app/products/[id]/page.tsx
// Next.js 16では非同期アクセスが必須
export default async function ProductPage(props: {
  params: Promise<{ id: string }>;
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}) {
  // awaitを使用してパラメータにアクセス
  const params = await props.params;
  const searchParams = await props.searchParams;

  const productId = params.id;
  const sortBy = searchParams.sort || 'name';

  const product = await fetchProduct(productId);

  return (
    <div>
      <h1>{product.name}</h1>
      <ProductDetails product={product} sortBy={sortBy} />
    </div>
  );
}
```

### "use cache" ディレクティブの実装例

```tsx
// app/components/ExpensiveData.tsx
// ファイル全体をキャッシュ
"use cache";

export default async function ExpensiveDataComponent() {
  // この計算処理全体がキャッシュされる
  const data = await fetchExpensiveData();
  const processed = await processComplexCalculation(data);

  return (
    <div className="data-visualization">
      <DataChart data={processed} />
    </div>
  );
}

// app/lib/cached-functions.ts
// 関数レベルでのキャッシュ
export async function getCachedUserStats(userId: string) {
  "use cache";

  // この関数の結果がキャッシュされる
  const stats = await calculateUserStatistics(userId);
  return stats;
}
```

### updateTag() でのキャッシュ即座更新

```tsx
// app/actions/blog.ts
'use server';

import { updateTag } from 'next/cache';

export async function createBlogPost(formData: FormData) {
  const title = formData.get('title') as string;
  const content = formData.get('content') as string;

  // ブログ投稿を作成
  const post = await db.post.create({
    data: { title, content }
  });

  // 即座にキャッシュを更新（ユーザーがすぐに新しい投稿を見られる）
  updateTag('blog-posts');
  updateTag(`author-${post.authorId}`);

  return { success: true, postId: post.id };
}

// app/blog/page.tsx
export default async function BlogPage() {
  // updateTag()により即座に最新データが反映される
  const posts = await fetch('/api/posts', {
    next: { tags: ['blog-posts'] }
  }).then(res => res.json());

  return <PostList posts={posts} />;
}
```

### proxy.ts の実装例

```tsx
// proxy.ts
import { NextResponse } from 'next/server';

export default function proxy(request: Request) {
  const url = new URL(request.url);

  // 認証が必要なルート
  if (url.pathname.startsWith('/dashboard')) {
    const token = request.headers.get('authorization');

    if (!token) {
      return NextResponse.redirect(new URL('/login', request.url));
    }
  }

  // APIルートの処理
  if (url.pathname.startsWith('/api/')) {
    // APIのレート制限
    const ip = request.headers.get('x-forwarded-for');
    if (shouldRateLimit(ip)) {
      return new Response('Too Many Requests', { status: 429 });
    }
  }

  return NextResponse.next();
}
```

### React Compiler 最適化の例

```tsx
// app/components/OptimizedComponent.tsx
// React Compilerが自動的に最適化
function AutoOptimizedComponent({ data, filter }) {
  // React Compilerが自動的にuseMemoを適用
  const filteredData = data.filter(item =>
    item.category === filter
  );

  // 自動的にuseCallbackが適用される
  const handleClick = (id: string) => {
    console.log('Clicked:', id);
  };

  return (
    <div>
      {filteredData.map(item => (
        <ItemCard
          key={item.id}
          item={item}
          onClick={handleClick}
        />
      ))}
    </div>
  );
}
```

### 動的ルートでの非同期パラメータパターン

```tsx
// app/shop/[category]/[product]/page.tsx
interface PageProps {
  params: Promise<{
    category: string;
    product: string;
  }>;
  searchParams: Promise<{
    variant?: string;
    size?: string;
  }>;
}

export default async function ProductDetailPage(props: PageProps) {
  // 並行してパラメータを取得
  const [params, searchParams] = await Promise.all([
    props.params,
    props.searchParams
  ]);

  const { category, product } = params;
  const { variant = 'default', size = 'M' } = searchParams;

  const productData = await fetchProductData(category, product, variant);

  return (
    <ProductView
      product={productData}
      selectedVariant={variant}
      selectedSize={size}
    />
  );
}
```
```