# 手動インストールの実例集

このドキュメントでは、様々なマーケットプレイスとプラグインタイプに対応した手動インストールの実例を紹介します。

## 目次

1. [claude-code-workflows マーケットプレイス](#claude-code-workflows-マーケットプレイス)
2. [claude-code-templates マーケットプレイス](#claude-code-templates-マーケットプレイス)
3. [カスタムローカルマーケットプレイス](#カスタムローカルマーケットプレイス)
4. [エッジケースと対処法](#エッジケースと対処法)

---

## claude-code-workflows マーケットプレイス

### 例1: javascript-typescript プラグイン

**特徴**: Sub-agents、Commands、Skillsのすべてを含む完全なプラグイン

**構造確認**:
```bash
ls -la ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/javascript-typescript/
# 出力:
# agents/javascript-pro.md
# agents/typescript-pro.md
# commands/typescript-scaffold.md
# skills/typescript-advanced-types/
# skills/nodejs-backend-patterns/
# skills/javascript-testing-patterns/
# skills/modern-javascript-patterns/
```

**手動インストール**:
```bash
# 1. Sub-agentsをコピー
cp ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/javascript-typescript/agents/*.md ~/.claude/agents/

# 2. Commandsをコピー
cp ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/javascript-typescript/commands/*.md ~/.claude/commands/

# 3. Skillsをコピー
cp -r ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/javascript-typescript/skills/* ~/.claude/skills/
```

**検証**:
```bash
ls -la ~/.claude/agents/ | grep -E "(javascript|typescript)"
ls -la ~/.claude/commands/ | grep typescript
ls -la ~/.claude/skills/ | grep -E "(javascript|typescript|nodejs)"
```

---

### 例2: python-development プラグイン

**特徴**: Python開発に特化したエージェントとスキル

**構造確認**:
```bash
ls -la ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/python-development/
```

**手動インストール**:
```bash
# Python関連のコンポーネントをコピー
cp ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/python-development/agents/*.md ~/.claude/agents/
cp ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/python-development/commands/*.md ~/.claude/commands/
cp -r ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/python-development/skills/* ~/.claude/skills/
```

**検証**:
```bash
# Python関連のコンポーネントを確認
ls -la ~/.claude/agents/ | grep python
ls -la ~/.claude/skills/ | grep python
```

---

### 例3: code-documentation プラグイン

**特徴**: ドキュメント生成に特化したエージェントとコマンド

**構造確認**:
```bash
ls -la ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/code-documentation/
# 出力:
# agents/docs-architect.md
# agents/tutorial-engineer.md
# agents/code-reviewer.md
# commands/doc-generate.md
# commands/code-explain.md
```

**手動インストール**:
```bash
# ドキュメント関連のコンポーネントをコピー
cp ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/code-documentation/agents/*.md ~/.claude/agents/
cp ~/.claude/plugins/marketplaces/claude-code-workflows/plugins/code-documentation/commands/*.md ~/.claude/commands/
```

**検証**:
```bash
ls -la ~/.claude/agents/ | grep -E "(docs|tutorial|reviewer)"
ls -la ~/.claude/commands/ | grep -E "(doc|explain)"
```

---

## claude-code-templates マーケットプレイス

### 例4: react-next-template プラグイン（仮想例）

**注意**: このマーケットプレイスは構造が異なる可能性があります。まず構造を確認してください。

**構造確認**:
```bash
ls -la ~/.claude/plugins/marketplaces/claude-code-templates/
# マーケットプレイスの構造を確認
find ~/.claude/plugins/marketplaces/claude-code-templates/ -name "*.md" | head -20
```

**手動インストール** (構造に応じて調整):
```bash
# テンプレート構造に応じてコピー
# 例: プラグインがフラットな構造の場合
cp ~/.claude/plugins/marketplaces/claude-code-templates/agents/*.md ~/.claude/agents/
cp ~/.claude/plugins/marketplaces/claude-code-templates/commands/*.md ~/.claude/commands/
```

---

## カスタムローカルマーケットプレイス

### 例5: 自分で作ったプラグインの手動インストール

**シナリオ**: `/Users/username/my-plugins/my-first-plugin` にカスタムプラグインがある場合

**構造確認**:
```bash
ls -la /Users/username/my-plugins/my-first-plugin/
# 出力例:
# .claude-plugin/plugin.json
# agents/my-agent.md
# commands/my-command.md
```

**手動インストール**:
```bash
# カスタムプラグインからコピー
cp /Users/username/my-plugins/my-first-plugin/agents/*.md ~/.claude/agents/
cp /Users/username/my-plugins/my-first-plugin/commands/*.md ~/.claude/commands/
```

---

## エッジケースと対処法

### ケース1: Skillsに依存関係がある場合

**問題**: 一部のSkillsが他のSkillsやスクリプトに依存している場合

**対処法**:
```bash
# Skill全体をディレクトリごとコピー（依存関係も含む）
cp -r ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/skills/[skill-name] ~/.claude/skills/

# 実行権限が必要なスクリプトがある場合
chmod +x ~/.claude/skills/[skill-name]/scripts/*.sh
```

**検証**:
```bash
# 依存ファイルも含めて確認
ls -laR ~/.claude/skills/[skill-name]/
```

---

### ケース2: 同名のコンポーネントが既に存在する場合

**問題**: コピー先に同じ名前のファイルが既に存在する

**対処法1: バックアップを作成**
```bash
# 既存ファイルをバックアップ
cp ~/.claude/agents/existing-agent.md ~/.claude/agents/existing-agent.md.backup

# 新しいコンポーネントをコピー
cp [source]/agents/existing-agent.md ~/.claude/agents/
```

**対処法2: 名前を変更してコピー**
```bash
# 別名でコピー
cp [source]/agents/agent.md ~/.claude/agents/agent-from-plugin.md
```

---

### ケース3: プラグインに `.mcp.json` が含まれている場合

**問題**: プラグインがMCPサーバーの設定を含んでいる

**手動対処**:
```bash
# .mcp.jsonの内容を確認
cat ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/.mcp.json

# グローバル設定にマージ（手動編集が必要）
# ~/.claude/settings.json の "mcpServers" セクションに追加
```

**注意**: MCPサーバーの設定は自動でマージできないため、手動で `~/.claude/settings.json` に追加する必要があります。

---

### ケース4: プラグインが Hooks を含む場合

**問題**: プラグインに `hooks/hooks.json` が含まれている

**手動対処**:
```bash
# hooks.jsonの内容を確認
cat ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/hooks/hooks.json

# グローバル設定にマージ（手動編集が必要）
# ~/.claude/settings.json の "hooks" セクションに追加
```

**注意**: Hooksの設定も自動でマージできないため、手動で `~/.claude/settings.json` に追加する必要があります。

---

## プロジェクトローカルへのインストール例

### 例6: プロジェクト固有のプラグインインストール

**シナリオ**: チームで共有するプラグインをプロジェクトローカルにインストール

**ディレクトリ作成**:
```bash
# プロジェクトルートで実行
mkdir -p .claude/agents .claude/commands .claude/skills
```

**手動インストール**:
```bash
# プロジェクトローカルにコピー
cp ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/agents/*.md .claude/agents/
cp ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/commands/*.md .claude/commands/
cp -r ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/skills/* .claude/skills/
```

**Gitにコミット**:
```bash
git add .claude/
git commit -m "Add [plugin-name] plugin components for team use"
git push
```

---

## 複数プラグインの一括インストール

### 例7: 複数プラグインをまとめてインストール

**シナリオ**: 開発環境セットアップで複数のプラグインを一度にインストール

**スクリプト例**:
```bash
#!/bin/bash

# インストールするプラグインのリスト
MARKETPLACE="claude-code-workflows"
PLUGINS=(
  "javascript-typescript"
  "python-development"
  "code-documentation"
)

# 各プラグインをインストール
for PLUGIN in "${PLUGINS[@]}"; do
  echo "Installing $PLUGIN..."

  # agents
  if [ -d ~/.claude/plugins/marketplaces/$MARKETPLACE/plugins/$PLUGIN/agents ]; then
    cp ~/.claude/plugins/marketplaces/$MARKETPLACE/plugins/$PLUGIN/agents/*.md ~/.claude/agents/ 2>/dev/null
  fi

  # commands
  if [ -d ~/.claude/plugins/marketplaces/$MARKETPLACE/plugins/$PLUGIN/commands ]; then
    cp ~/.claude/plugins/marketplaces/$MARKETPLACE/plugins/$PLUGIN/commands/*.md ~/.claude/commands/ 2>/dev/null
  fi

  # skills
  if [ -d ~/.claude/plugins/marketplaces/$MARKETPLACE/plugins/$PLUGIN/skills ]; then
    cp -r ~/.claude/plugins/marketplaces/$MARKETPLACE/plugins/$PLUGIN/skills/* ~/.claude/skills/ 2>/dev/null
  fi

  echo "✓ $PLUGIN installed"
done

echo "All plugins installed successfully!"
```

---

## トラブルシューティング実例

### 問題: コピー後、一部のコマンドが動作しない

**診断**:
```bash
# コマンドファイルの内容を確認
cat ~/.claude/commands/[command-name].md

# YAMLフロントマターが正しいか確認
head -n 10 ~/.claude/commands/[command-name].md
```

**解決策**:
- YAMLフロントマターの`description`フィールドが存在するか確認
- ファイルのパーミッションを確認: `chmod 644 ~/.claude/commands/[command-name].md`

---

### 問題: Skillsが認識されない

**診断**:
```bash
# SKILL.mdが存在するか確認
find ~/.claude/skills/ -name "SKILL.md"

# Skillディレクトリの構造を確認
ls -laR ~/.claude/skills/[skill-name]/
```

**解決策**:
- `SKILL.md`ファイル名が正確か確認（大文字小文字を含む）
- YAMLフロントマターの`name`と`description`が存在するか確認

---

## まとめ

手動インストールは、マーケットプレイスやプラグインの構造に応じて柔軟に対応できる強力な方法です。

**キーポイント**:
- まず構造を確認する（`ls -la`、`find`を活用）
- コンポーネントごとに個別にコピー
- 必ずコピー後に検証する
- Claude Codeを再起動する

これらの実例を参考に、様々なプラグインを確実にインストールできます！
