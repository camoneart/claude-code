# Next.js Basic Principles - 実装ガイド

## タスク別実装ガイド

### 🆕 新規プロジェクトのセットアップ

#### 判断ポイント
1. **App Router vs Pages Router**
   - 新規プロジェクト → App Router を選択
   - 既存プロジェクトの拡張 → 段階的移行を検討

2. **初期設計の考慮事項**
   ```tsx
   // app/layout.tsx
   export default function RootLayout({ children }) {
     return (
       <html>
         <body>
           {/* 共通レイアウトはServer Componentで */}
           <Header />
           {children}
           <Footer />
         </body>
       </html>
     );
   }
   ```

### 📄 ページコンポーネントの実装

#### Server Component ファーストで設計

```tsx
// ❌ 避けるべきパターン
'use client';  // 不必要にClient Component化

export default function ProductPage() {
  const [products, setProducts] = useState([]);
  useEffect(() => {
    fetch('/api/products').then(/* ... */);
  }, []);
  // ...
}

// ✅ 推奨パターン
// Server Componentとして実装
export default async function ProductPage() {
  const products = await fetch('https://api.example.com/products', {
    next: { revalidate: 3600 }
  }).then(res => res.json());

  return <ProductList products={products} />;
}
```

### 🔄 データフェッチング戦略

#### パターン選択フローチャート

1. **静的データ** → `fetch` with `cache: 'force-cache'`
2. **定期更新データ** → `fetch` with `next: { revalidate: seconds }`
3. **リアルタイムデータ** → Dynamic Rendering with `noStore()`
4. **ユーザー固有データ** → Client Component + API Route

#### 実装パターン

```tsx
// 1. 静的データ（ビルド時に取得）
const staticData = await fetch('https://api.example.com/static', {
  cache: 'force-cache'
});

// 2. ISR（定期的な再検証）
const isrData = await fetch('https://api.example.com/posts', {
  next: { revalidate: 60 } // 60秒ごと
});

// 3. 動的データ（リクエストごと）
import { unstable_noStore as noStore } from 'next/cache';

async function getDynamicData() {
  noStore();
  return fetch('https://api.example.com/realtime');
}

// 4. クライアントサイドフェッチ
'use client';
function UserProfile() {
  const { data } = useSWR('/api/user', fetcher);
  // ...
}
```

### 🎨 UI コンポーネントの設計

#### Client Component の判断基準

Client Component が**必要**な場合：
- `useState`, `useReducer` などの状態管理
- `useEffect` でのサイドエフェクト
- `onClick`, `onChange` などのイベントハンドラー
- ブラウザ専用API（`window`, `document`）の使用
- カスタムフックの使用

#### 実装戦略

```tsx
// Composition Pattern - 最小限のClient Component化
// ProductGrid.tsx (Server Component)
export default async function ProductGrid() {
  const products = await fetchProducts();

  return (
    <div>
      <ProductFilters /> {/* Client Component */}
      <ProductList products={products} /> {/* Server Component */}
    </div>
  );
}

// ProductFilters.tsx (Client Component)
'use client';
export default function ProductFilters() {
  const [filters, setFilters] = useState({});
  // インタラクティブな部分のみClient Component
}
```

### 🚀 パフォーマンス最適化

#### 最適化チェックリスト

1. **Suspense境界の設置**
   ```tsx
   <Suspense fallback={<Loading />}>
     <SlowComponent />
   </Suspense>
   ```

2. **並行フェッチの実装**
   ```tsx
   const [a, b, c] = await Promise.all([
     fetchA(), fetchB(), fetchC()
   ]);
   ```

3. **Dynamic Imports**
   ```tsx
   const HeavyComponent = dynamic(
     () => import('./HeavyComponent'),
     { loading: () => <p>Loading...</p> }
   );
   ```

4. **画像最適化**
   ```tsx
   import Image from 'next/image';
   <Image src="/hero.jpg" alt="" width={1200} height={600} priority />
   ```

### 🔐 認証の実装

#### Server Component での認証確認

```tsx
// app/dashboard/page.tsx
import { cookies } from 'next/headers';
import { redirect } from 'next/navigation';

export default async function DashboardPage() {
  const cookieStore = cookies();
  const token = cookieStore.get('auth-token');

  if (!token) {
    redirect('/login');
  }

  const user = await verifyToken(token.value);
  return <Dashboard user={user} />;
}
```

#### Middleware での保護

```tsx
// middleware.ts
export async function middleware(request: NextRequest) {
  const token = request.cookies.get('auth-token');

  if (!token && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url));
  }
}

export const config = {
  matcher: '/dashboard/:path*'
};
```

### ⚡ キャッシング戦略

#### キャッシュレイヤーの理解と活用

1. **Request Memoization** - 同一リクエスト内での重複排除
2. **Data Cache** - fetch結果のキャッシュ
3. **Full Route Cache** - ページ全体のキャッシュ
4. **Router Cache** - クライアントサイドのナビゲーションキャッシュ

#### キャッシュ無効化パターン

```tsx
// On-demand Revalidation
import { revalidatePath, revalidateTag } from 'next/cache';

// パスベースの再検証
export async function updateProduct(id: string) {
  await updateDatabase(id);
  revalidatePath(`/products/${id}`);
}

// タグベースの再検証
export async function updateCategory(category: string) {
  await updateDatabase(category);
  revalidateTag(`category-${category}`);
}
```

### 🛠️ デバッグとトラブルシューティング

#### よくある問題と解決策

1. **"Hydration Mismatch" エラー**
   - 原因：Server/Client で異なるコンテンツ
   - 解決：`useEffect` で Client 側のみの処理を分離

2. **過度な Client Component 化**
   - 原因：1つのファイルに全て記述
   - 解決：Composition Pattern で分割

3. **キャッシュが更新されない**
   - 原因：revalidate 設定ミス
   - 解決：適切な revalidate 戦略の選択

### 📚 参考資料とリンク

詳細な原則については、以下を参照：

- [Part 1: サーバーコンポーネント基礎](principles/part_1/index.md)
- [Part 2: クライアントコンポーネント戦略](principles/part_2/index.md)
- [Part 3: キャッシングと動的レンダリング](principles/part_3/index.md)
- [Part 4: レンダリング最適化](principles/part_4/index.md)
- [Part 5: 実装技術とベストプラクティス](principles/part_5/index.md)

## 🆕 Next.js 16 への移行ガイド

### 移行前の準備

#### 1. 現在のバージョンを確認
```bash
npm list next
```

#### 2. 影響範囲の特定
```bash
# params/searchParamsを使用している箇所を検索
grep -r "params\|searchParams" app/ --include="*.tsx" --include="*.ts"
```

### 緊急対応が必要な項目（破壊的変更）

#### 非同期params/searchParamsへの対応

```tsx
// 移行スクリプトで一括変換可能なパターン
// Before
export default function Page({ params, searchParams }) {
  // ...
}

// After - 型定義を追加して非同期化
interface PageProps {
  params: Promise<{ [key: string]: string }>;
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}

export default async function Page(props: PageProps) {
  const params = await props.params;
  const searchParams = await props.searchParams;
  // ...
}
```

#### Node.js バージョンアップ

```bash
# NVMを使用している場合
nvm install 20.9
nvm use 20.9

# package.jsonの更新
{
  "engines": {
    "node": ">=20.9.0"
  }
}
```

### 新機能への段階的移行

#### Phase 1: 最小限の移行（1-2日）
1. Next.js 16へのアップグレード
   ```bash
   npm install next@16
   ```

2. 非同期params対応（自動化可能）
   ```bash
   # codemodツールの使用
   npx @next/codemod@latest upgrade 16
   ```

3. テストの実行
   ```bash
   npm test
   npm run build
   ```

#### Phase 2: キャッシング最適化（1週間）

1. 暗黙的キャッシングの明示化
   ```tsx
   // "use cache"ディレクティブの追加
   "use cache";

   export default async function CachedComponent() {
     // キャッシュされるコンポーネント
   }
   ```

2. Server Actions の改善
   ```tsx
   // revalidatePath → updateTag への移行
   import { updateTag } from 'next/cache';

   export async function updateData() {
     await saveToDatabase();
     updateTag('data-tag'); // 即座に反映
   }
   ```

#### Phase 3: パフォーマンス最適化（2週間）

1. Turbopackの活用（自動有効化）
2. React Compilerの設定
3. middleware.ts → proxy.ts への移行

### 移行時のテスト戦略

#### 1. E2Eテストの更新
```tsx
// Playwright/Cypressのテストケース更新
test('page with params', async ({ page }) => {
  await page.goto('/products/123?sort=price');
  // Next.js 16では非同期処理を考慮
  await page.waitForLoadState('networkidle');
  // ...
});
```

#### 2. パフォーマンステスト
```bash
# ビルド時間の比較
time npm run build

# Lighthouse CI
npx lhci autorun
```

### トラブルシューティング

#### よくある問題と解決策

1. **「params is not defined」エラー**
   ```tsx
   // 解決: propsからawaitで取得
   const params = await props.params;
   ```

2. **キャッシュが効かない**
   ```tsx
   // 解決: "use cache"ディレクティブを追加
   "use cache";
   ```

3. **middleware.tsが動作しない**
   ```tsx
   // 解決: proxy.tsに移行
   // proxy.ts
   export default function proxy(request) {
     // ...
   }
   ```

### 移行チェックリスト

- [ ] Node.js 20.9以上にアップグレード
- [ ] Next.js 16をインストール
- [ ] 全Page/Layoutでparams/searchParamsを非同期化
- [ ] テストスイートをパス
- [ ] ビルドエラーを解消
- [ ] "use cache"ディレクティブの検討
- [ ] updateTag() APIの活用検討
- [ ] proxy.tsへの移行検討
- [ ] パフォーマンステストの実施
- [ ] 本番環境へのデプロイ

詳細な移行ガイドは[Next.js 16 アップデート](next16-updates.md)を参照してください。