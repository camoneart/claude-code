# Commit Prefix Reference

## 完全なPrefix一覧

| Prefix       | 用途 (日本語)          | 説明                                                         |
| ------------ | ---------------------- | ------------------------------------------------------------ |
| **fix**      | バグ修正               | コードの不具合を修正するコミット                             |
| **hotfix**   | クリティカルなバグ修正 | サービス停止レベルの緊急バグ対応                             |
| **add**      | 新規機能追加           | 新しいファイルや小規模機能を追加するコミット                 |
| **feat**     | 新機能                 | ユーザー向けの大きな機能追加または変更                       |
| **update**   | 機能修正               | 既存機能に対する修正・改善（バグ修正ではない）               |
| **change**   | 仕様変更               | 仕様そのものを変更するコミット                               |
| **clean**    | 整理                   | 使われていないコードの削除や軽微な整理                       |
| **disable**  | 無効化                 | 機能を一時的に無効化（コメントアウト等）                     |
| **refactor** | リファクタリング       | 挙動を変えずに内部構造のみ改善                               |
| **remove**   | 削除                   | ファイル・ライブラリ・機能を削除するコミット                 |
| **upgrade**  | バージョンアップ       | 依存ライブラリや FW のメジャーアップデート                   |
| **revert**   | 変更取り消し           | 以前のコミットを打ち消すコミット                             |
| **docs**     | ドキュメント           | README やコメントのみの変更                                  |
| **style**    | スタイル修正           | コードフォーマット、空白、セミコロンなど動作に影響しない変更 |
| **perf**     | パフォーマンス         | パフォーマンス改善のための実装変更                           |
| **test**     | テスト                 | テストコードの追加・更新・リファクタ                         |
| **chore**    | 雑多メンテ             | ビルド、CI、依存更新など本番コードに影響しない作業           |

## Prefix選択ガイドライン

### バグ関連
- 通常のバグ → `fix`
- 本番環境で重大な影響 → `hotfix`

### 機能追加
- 小規模・ファイル追加レベル → `add`
- ユーザー向けの大きな機能 → `feat`

### 既存コード変更
- バグではなく改善 → `update`
- 内部構造のみ変更 → `refactor`
- 仕様そのものの変更 → `change`

### その他
- テストのみ → `test`
- ドキュメントのみ → `docs`
- ビルド・CI → `chore`
- 不要コード削除 → `clean` or `remove`

## 不明なPrefixの扱い

上記一覧に含まれないPrefixを使用する場合は、**必ずユーザーに確認**してからコミットすること。

## コミットメッセージの例

### Good Examples
```
test: add edge-case tests for user authentication
feat: implement dark mode toggle in settings
fix: resolve memory leak in event listener
refactor: extract validation logic into separate module
```

### Bad Examples
```
update files
fix stuff
changes
wip
```

## 複数の変更がある場合

複数の目的が混在する場合は、**必ず分割**してコミット：

```bash
# ❌ 悪い例
git add -A
git commit -m "feat: add feature and fix bug"

# ✅ 良い例
git add src/feature.ts
git commit -m "feat: add new feature"

git add src/bugfix.ts
git commit -m "fix: resolve validation bug"
```
