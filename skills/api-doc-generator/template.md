# API ドキュメントテンプレート

このテンプレートを使用して、統一されたフォーマットで API ドキュメントを作成します。

---

## {エンドポイント名}

### 概要

**メソッド**: `GET` | `POST` | `PUT` | `DELETE` | `PATCH`
**パス**: `/api/v1/{resource}`
**説明**: この API が何をするかを簡潔に説明

### 認証

- 必要な認証方式（Bearer Token、API Key など）
- 例: `Authorization: Bearer {token}`

### パラメータ

#### パスパラメータ

| パラメータ名 | 型 | 必須 | 説明 |
|---|---|---|---|
| `id` | string | ✅ | リソースの一意な識別子 |

#### クエリパラメータ

| パラメータ名 | 型 | 必須 | デフォルト | 説明 |
|---|---|---|---|---|
| `limit` | number | ❌ | 10 | 取得件数の上限 |
| `offset` | number | ❌ | 0 | スキップする件数 |
| `sort` | string | ❌ | "createdAt" | ソート基準 |

#### リクエストボディ

```json
{
  "name": "string (required)",
  "email": "string (required)",
  "age": "number (optional)",
  "metadata": {
    "tags": ["string"],
    "priority": "high | medium | low"
  }
}
```

### リクエスト例

#### cURL

```bash
curl -X POST https://api.example.com/api/v1/users \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Camone",
    "email": "camone@example.com",
    "age": 30
  }'
```

#### JavaScript (fetch)

```javascript
const response = await fetch('https://api.example.com/api/v1/users', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer YOUR_TOKEN',
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    name: 'Camone',
    email: 'camone@example.com',
    age: 30
  })
});

const data = await response.json();
console.log(data);
```

### レスポンス

#### 成功時 (200 OK)

```json
{
  "success": true,
  "data": {
    "id": "usr_1234567890",
    "name": "Camone",
    "email": "camone@example.com",
    "age": 30,
    "createdAt": "2025-01-15T10:30:00Z",
    "updatedAt": "2025-01-15T10:30:00Z"
  },
  "message": "ユーザーが正常に作成されました"
}
```

#### エラー時 (400 Bad Request)

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "入力値が不正です",
    "details": [
      {
        "field": "email",
        "message": "メールアドレスの形式が正しくありません"
      }
    ]
  }
}
```

### ステータスコード

| コード | 説明 |
|---|---|
| 200 | リクエスト成功 |
| 201 | リソース作成成功 |
| 400 | リクエストが不正 |
| 401 | 認証エラー |
| 403 | 権限不足 |
| 404 | リソースが見つからない |
| 500 | サーバーエラー |

### エラーコード

| コード | 説明 | 対処方法 |
|---|---|---|
| `VALIDATION_ERROR` | 入力値のバリデーションエラー | リクエストパラメータを確認 |
| `UNAUTHORIZED` | 認証トークンが無効 | トークンを再取得 |
| `RESOURCE_NOT_FOUND` | 指定されたリソースが存在しない | ID を確認 |
| `RATE_LIMIT_EXCEEDED` | レート制限超過 | しばらく待ってから再試行 |

### レート制限

- **制限**: 100 リクエスト/分
- **ヘッダー**:
  - `X-RateLimit-Limit`: 制限数
  - `X-RateLimit-Remaining`: 残りリクエスト数
  - `X-RateLimit-Reset`: リセット時刻（Unix タイムスタンプ）

### 注意事項

- このエンドポイントに関する特記事項
- セキュリティ上の注意点
- パフォーマンスに関する考慮事項

### 変更履歴

| バージョン | 日付 | 変更内容 |
|---|---|---|
| v1.1.0 | 2025-01-15 | `metadata` フィールドを追加 |
| v1.0.0 | 2025-01-01 | 初版リリース |

---

## 補足情報

### 関連エンドポイント

- [ユーザー一覧取得](./get-users.md)
- [ユーザー更新](./update-user.md)
- [ユーザー削除](./delete-user.md)

### 参考リンク

- [API 利用ガイド](../guides/getting-started.md)
- [認証について](../guides/authentication.md)
