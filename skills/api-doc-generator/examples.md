# API Documentation Generator - 使用例

このスキルを実際に使用する際の具体例を示します。

## 例 1: REST API エンドポイントのドキュメント生成

### 入力コード (src/api/users.ts)

```typescript
/**
 * ユーザー情報を作成する API
 * @route POST /api/v1/users
 */
export async function createUser(req: Request, res: Response) {
  const { name, email, age } = req.body;

  // バリデーション
  if (!name || !email) {
    return res.status(400).json({
      success: false,
      error: {
        code: 'VALIDATION_ERROR',
        message: '必須項目が不足しています'
      }
    });
  }

  // ユーザー作成
  const user = await db.users.create({
    name,
    email,
    age: age || null
  });

  return res.status(201).json({
    success: true,
    data: user,
    message: 'ユーザーが正常に作成されました'
  });
}
```

### ユーザーからの依頼

```
「src/api/users.ts の createUser 関数の API ドキュメントを作成してください」
```

### 生成されるドキュメント (docs/api/create-user.md)

template.md のフォーマットに従って、以下の情報を含むドキュメントが生成されます：

- エンドポイント: `POST /api/v1/users`
- パラメータ: name (string, required), email (string, required), age (number, optional)
- レスポンス例: 成功時 (201) とエラー時 (400) の両方
- エラーコード: VALIDATION_ERROR

---

## 例 2: クラスメソッドのドキュメント生成

### 入力コード (src/services/UserService.ts)

```typescript
export class UserService {
  /**
   * ユーザーを ID で検索
   * @param userId - ユーザーの一意な識別子
   * @returns ユーザーオブジェクトまたは null
   * @throws {NotFoundError} ユーザーが見つからない場合
   */
  async findById(userId: string): Promise<User | null> {
    const user = await db.users.findUnique({
      where: { id: userId }
    });

    if (!user) {
      throw new NotFoundError('ユーザーが見つかりません');
    }

    return user;
  }

  /**
   * すべてのユーザーを取得
   * @param options - ページネーションとソートオプション
   * @returns ユーザーのリスト
   */
  async findAll(options?: {
    limit?: number;
    offset?: number;
    sortBy?: 'createdAt' | 'name';
  }): Promise<User[]> {
    const { limit = 10, offset = 0, sortBy = 'createdAt' } = options || {};

    return await db.users.findMany({
      take: limit,
      skip: offset,
      orderBy: { [sortBy]: 'desc' }
    });
  }
}
```

### ユーザーからの依頼

```
「UserService クラスのメソッドのドキュメントを作成してください」
```

### 生成されるドキュメント (docs/api/user-service.md)

- クラス概要
- 各メソッドの詳細（パラメータ、戻り値、例外）
- 使用例コード

---

## 例 3: GraphQL リゾルバーのドキュメント生成

### 入力コード (src/graphql/resolvers/user.ts)

```typescript
export const userResolvers = {
  Query: {
    /**
     * ユーザーを ID で取得
     */
    user: async (_: any, { id }: { id: string }, context: Context) => {
      return context.db.user.findUnique({ where: { id } });
    },

    /**
     * すべてのユーザーを取得
     */
    users: async (_: any, { input }: { input: UsersInput }, context: Context) => {
      const { limit, offset } = input;
      return context.db.user.findMany({
        take: limit || 10,
        skip: offset || 0
      });
    }
  },

  Mutation: {
    /**
     * 新しいユーザーを作成
     */
    createUser: async (_: any, { input }: { input: CreateUserInput }, context: Context) => {
      const { name, email } = input;
      return context.db.user.create({
        data: { name, email }
      });
    }
  }
};
```

### ユーザーからの依頼

```
「この GraphQL リゾルバーのドキュメントを作成してください」
```

### 生成されるドキュメント (docs/api/user-resolvers.md)

- Query と Mutation の一覧
- 各リゾルバーの説明
- GraphQL スキーマ定義
- クエリ/ミューテーション例

---

## 例 4: 既存 API の更新ドキュメント生成

### シナリオ

既存の `GET /api/v1/users` エンドポイントに新しいフィルター機能を追加した場合。

### 更新後のコード

```typescript
export async function getUsers(req: Request, res: Response) {
  const {
    limit = 10,
    offset = 0,
    role,        // 新規追加
    status,      // 新規追加
    search       // 新規追加
  } = req.query;

  const filters: any = {};
  if (role) filters.role = role;
  if (status) filters.status = status;
  if (search) {
    filters.OR = [
      { name: { contains: search } },
      { email: { contains: search } }
    ];
  }

  const users = await db.users.findMany({
    where: filters,
    take: Number(limit),
    skip: Number(offset)
  });

  return res.json({ success: true, data: users });
}
```

### ユーザーからの依頼

```
「getUsers API に追加した新しいフィルター機能をドキュメントに反映してください」
```

### 更新内容

既存ドキュメント `docs/api/get-users.md` に以下を追加：

- 新しいクエリパラメータ: `role`, `status`, `search`
- 各パラメータの説明と使用例
- 変更履歴セクションに更新情報を追加

---

## スキル実行のフロー

1. **コード読み込み**: ユーザーが指定したファイルを Read ツールで読み込む
2. **テンプレート参照**: template.md を参照して構造を確認
3. **情報抽出**: コメント、型定義、関数シグネチャから情報を抽出
4. **ドキュメント生成**: テンプレートに沿って Markdown ドキュメントを作成
5. **保存**: `docs/api/` ディレクトリに適切な名前で保存
6. **確認**: 生成されたドキュメントをユーザーに提示

---

## ベストプラクティス

### コード側の準備

ドキュメント生成を効率化するために、コードに以下を含めることを推奨：

```typescript
/**
 * API の説明
 * @route メソッド パス
 * @param パラメータ名 - 説明
 * @returns 戻り値の説明
 * @throws エラーの種類と条件
 * @example
 * // 使用例
 * const result = await createUser({ name: 'test' });
 */
```

### ドキュメント管理

- バージョン管理: 変更履歴を必ず記録
- 関連リンク: 他の API との関係性を明示
- 具体例: 実際に動作するコード例を含める
- エラーケース: すべてのエラーパターンを文書化

---

## トラブルシューティング

### 問題: 型情報が不足している

**解決策**: TypeScript の型定義を明示的に記述する

```typescript
// 悪い例
export async function createUser(req, res) { ... }

// 良い例
export async function createUser(
  req: Request<{}, {}, CreateUserBody>,
  res: Response<UserResponse>
) { ... }
```

### 問題: レスポンス例が不明確

**解決策**: 実際のレスポンスオブジェクトをコードに含める

```typescript
// 成功レスポンスの例
const successResponse: UserResponse = {
  success: true,
  data: {
    id: 'usr_123',
    name: 'Camone',
    email: 'camone@example.com'
  }
};
```
