# Claude Code Skills

このディレクトリには、Claude Codeの動作を拡張するSkillsが含まれています。

## Skills一覧

### 1. Managing Timecard
**ディレクトリ**: `managing-timecard/`

勤怠打刻機能（`/dakoku` コマンド）を管理するスキル。

- TIME MCP Server を優先した日時取得
- Markdown/JSON 形式での保存
- フォールバック処理の自動実行

### 2. Logging Implementation
**ディレクトリ**: `logging-implementation/`

プロジェクト全体で一貫した実装ログ管理を行うスキル。

- `_docs/templates/` への自動保存
- 統一フォーマットでのログ作成
- 過去の実装履歴の参照

### 3. Enforcing Git Commit Workflow
**ディレクトリ**: `enforcing-git-commit-workflow/`

意味のあるコミット履歴を保つための厳格なGitワークフロー管理スキル。

- Semantic Commit Prefixの強制
- `git add -A` の禁止（例外あり）
- 個別ファイルステージングの徹底

### 4. Practicing TDD
**ディレクトリ**: `practicing-tdd/`

テスト駆動開発（TDD）のベストプラクティスに従った開発フローを管理するスキル。

- Red-Green-Refactorサイクルの徹底
- 80%以上のコードカバレッジ維持
- 品質ゲートの自動実行

### 5. Enforcing pnpm
**ディレクトリ**: `enforcing-pnpm/`

プロジェクトでpnpmを統一的に使用するための強制スキル。

- npm/yarn コマンドの自動検知
- pnpm への自動置き換え
- CI/CD設定の検証

### 6. Searching Web
**ディレクトリ**: `searching-web/`

MCPサーバーを優先順位付けして効率的にWeb検索を実行するスキル。

- Brave-Search MCP Server を第一優先
- WebFetch へのフォールバック
- Context7 MCP Server の活用（OSS情報）

### 7. Setting up Next.js Project
**ディレクトリ**: `setting-up-nextjs-project/`

Next.jsプロジェクトのセットアップ時に必要な設定を自動化するスキル。

- ESLint + Prettier の自動インストール
- 設定ファイルの自動作成
- VS Code 設定の推奨

## Skillsの仕組み

### 自動発動
各Skillは、ユーザーのリクエストやコンテキストに基づいて**自動的に発動**します。

例：
- ユーザーが「Next.jsプロジェクトをセットアップして」と言う → `Setting up Next.js Project` が発動
- `/dakoku in` を実行 → `Managing Timecard` が発動
- コミット操作を行う → `Enforcing Git Commit Workflow` が発動

### Progressive Disclosure
詳細な情報は別ファイルに分離されており、必要に応じて参照されます。

例：
- `enforcing-git-commit-workflow/SKILL.md` - 基本ルール
- `enforcing-git-commit-workflow/prefix-reference.md` - Prefix一覧の詳細

## Skillsの作成

新しいSkillを作成する場合は、`creating-skills/` Skillを参照してください。

### 基本構造
```
skill-name/
├── SKILL.md              # メインファイル（YAMLフロントマター必須）
├── reference.md          # 詳細リファレンス（オプション）
├── examples.md           # 使用例（オプション）
└── templates/            # テンプレートファイル（オプション）
```

### YAMLフロントマター
```yaml
---
name: Skill Name (動名詞形)
description: 具体的な説明。何をするか + いつ使うか。
allowed-tools: Read, Write, Edit  # オプション
---
```

## ベストプラクティス

1. **SKILL.mdは500行以下に保つ**
2. **descriptionに発動トリガーを明記**
3. **Progressive Disclosureパターンを使用**
4. **動名詞形（verb + -ing）で命名**
5. **具体的な例を含める**

## 参考リンク

- [Claude Code Skills公式ドキュメント](https://docs.claude.com/en/docs/agents-and-tools/agent-skills)
- [Skills Best Practices](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)
