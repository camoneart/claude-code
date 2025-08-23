# /release-and-tag - プロジェクトのリリースノートとタグ作成を実行するコマンド

プロジェクトのリリースノートとタグ作成を実行するためのコマンドです。

## 使用方法

以下のリリースノート生成ルールを必ず守ってリリースノートとタグを作成してください。

## リリースノート生成ルール（Changesets & GitHub Release）

- すべてのリポジトリは **Changesets** を使ってバージョン管理・リリースノート自動生成を行うこと。
- タグ命名規則は `package-name@x.y.z` とし、MonoRepo でも一意に識別可能とする。
- `/.changeset/config.json` には下記設定を必ず含める：

```json
{
  "changelog": ["@changesets/changelog-github", { "repo": "<owner>/<repo>" }],
  "commit": false,
  "linked": [],
  "access": "public",
  "baseBranch": "main",
  "updateInternalDependencies": "patch"
}
```

- GitHub Actions では `changesets/action@v1` の `createGithubReleases: true` を有効化し、Release ページを自動作成する。
- ### フォーマット要件（shadcn-ui スタイル）

1. **タイトル / タグ**

   - タイトルとタグ名は必ず `package-name@x.y.z` 形式。
   - `Latest` バッジは GitHub が自動付与するため手動操作は不要。

2. **見出しの順序**

   1. Breaking Changes（あれば）
   2. Major Changes（メジャーバージョンアップ時）
   3. Minor Changes
   4. Patch Changes

3. **各エントリ行のフォーマット**

   ```md
   - #<PR 番号> <短 SHA> Thanks @<handle>! - <変更概要>
   ```

   例：

   ```md
   - #7782 06d03d6 Thanks @shadcn! - add universal registry items support
   ```

4. **エントリの並び順**

   - PR 番号昇順でソートする。複数パッケージが同時リリースされる場合でも共通。

5. **Assets セクション**

   - GitHub Release UI で自動添付される `Source code (zip)` / `(tar.gz)` のみが表示されることを確認する。

6. **例（完成イメージ）**

   ```md
   shadcn@2.9.0

   ### Major Changes

   - #7780 123abcd Thanks @shadcn! - implement registry synchronization

   ### Minor Changes

   - #7782 06d03d6 Thanks @shadcn! - add universal registry items support

   ### Patch Changes

   - #7795 6c341c1 Thanks @shadcn! - fix safe target handling
   - #7757 db93787 Thanks @shadcn! - implement registry path validation
   ```

   > 上記の **インデント / スペース数 / 改行位置** を厳密に守ること。

7. **自動生成後の手動編集禁止**

   - フォーマット崩れの原因になるため、基本は自動生成のまま公開する。追記が必要な場合は最下部に「Additional Notes」セクションを設ける。

8. **検証ステップ**
   - `gh release view <tag>` で Markdown が正しくレンダリングされているか確認し、問題があればタグを削除して再リリースする。
