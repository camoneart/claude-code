# プラグイン手動インストール チェックリスト

このチェックリストを使用して、プラグインの手動インストールプロセスを追跡します。
各ステップを完了したら、チェックボックスにマークを付けてください。

---

## プラグイン情報

- **プラグイン名**: `_________________`
- **マーケットプレイス**: `_________________`
- **インストール日時**: `_________________`
- **インストール先**:
  - [ ] グローバル (`~/.claude/`)
  - [ ] プロジェクトローカル (`.claude/`)

---

## Phase 1: 事前確認

### マーケットプレイスの確認
- [ ] マーケットプレイスが追加されている
  ```bash
  cat ~/.claude/plugins/known_marketplaces.json
  ```

- [ ] マーケットプレイスの実体が存在する
  ```bash
  ls -la ~/.claude/plugins/marketplaces/
  ```

### プラグインの確認
- [ ] プラグインディレクトリが存在する
  ```bash
  ls -la ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/
  ```

- [ ] プラグインの構造を確認した
  - [ ] `agents/` ディレクトリの存在: YES / NO
  - [ ] `commands/` ディレクトリの存在: YES / NO
  - [ ] `skills/` ディレクトリの存在: YES / NO
  - [ ] `.mcp.json` の存在: YES / NO
  - [ ] `hooks/hooks.json` の存在: YES / NO

---

## Phase 2: 診断

### インストール状況の診断
- [ ] `config.json` の内容を確認した
  ```bash
  cat ~/.claude/plugins/config.json
  ```
  - 結果: `repositories: {}` (空) / 他の内容

- [ ] `repos/` ディレクトリを確認した
  ```bash
  ls -la ~/.claude/plugins/repos/
  ```
  - 結果: 空 / プラグインあり

### 診断結果
- [ ] 公式インストールが **成功している** → 手動インストール不要
- [ ] 公式インストールが **失敗している** → 手動インストール必要

---

## Phase 3: コンポーネントの特定

### マーケットプレイスの定義確認
- [ ] `marketplace.json` でプラグイン定義を確認した
  ```bash
  grep -A 30 '"name": "[plugin-name]"' ~/.claude/plugins/marketplaces/[marketplace]/.claude-plugin/marketplace.json
  ```

### コンポーネント数の記録
- **Agents**: `_____` 個
- **Commands**: `_____` 個
- **Skills**: `_____` 個

---

## Phase 4: 手動インストール

### 方法の選択
- [ ] 自動スクリプトを使用する
  ```bash
  ~/.claude/skills/plugin-fallback-installer/scripts/install-plugin-manually.sh [marketplace] [plugin]
  ```

- [ ] 手動でコピーする（以下の手順に従う）

### Sub-agents のインストール
- [ ] コピーコマンドを実行した
  ```bash
  cp ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/agents/*.md ~/.claude/agents/
  ```

- [ ] コピーを確認した
  ```bash
  ls -la ~/.claude/agents/ | grep [agent-name]
  ```

- [ ] インストールされた Agents:
  - [ ] `_________________`
  - [ ] `_________________`
  - [ ] `_________________`

### Commands のインストール
- [ ] コピーコマンドを実行した
  ```bash
  cp ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/commands/*.md ~/.claude/commands/
  ```

- [ ] コピーを確認した
  ```bash
  ls -la ~/.claude/commands/ | grep [command-name]
  ```

- [ ] インストールされた Commands:
  - [ ] `_________________` → `/________________`
  - [ ] `_________________` → `/________________`
  - [ ] `_________________` → `/________________`

### Skills のインストール
- [ ] コピーコマンドを実行した
  ```bash
  cp -r ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/skills/* ~/.claude/skills/
  ```

- [ ] コピーを確認した
  ```bash
  ls -la ~/.claude/skills/ | grep [skill-name]
  ```

- [ ] インストールされた Skills:
  - [ ] `_________________`
  - [ ] `_________________`
  - [ ] `_________________`

### 特殊コンポーネントの対応
- [ ] `.mcp.json` がある場合
  - [ ] 内容を確認した
    ```bash
    cat ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/.mcp.json
    ```
  - [ ] `~/.claude/settings.json` の `mcpServers` セクションに手動でマージした

- [ ] `hooks/hooks.json` がある場合
  - [ ] 内容を確認した
    ```bash
    cat ~/.claude/plugins/marketplaces/[marketplace]/plugins/[plugin]/hooks/hooks.json
    ```
  - [ ] `~/.claude/settings.json` の `hooks` セクションに手動でマージした

---

## Phase 5: 検証

### ファイル存在確認
- [ ] すべての Agents が存在する
  ```bash
  ls -la ~/.claude/agents/[agent-name].md
  ```

- [ ] すべての Commands が存在する
  ```bash
  ls -la ~/.claude/commands/[command-name].md
  ```

- [ ] すべての Skills が存在する
  ```bash
  ls -la ~/.claude/skills/[skill-name]/
  ```

### Claude Code での確認
- [ ] Claude Code を再起動した

- [ ] `/help` で Commands が表示されることを確認した
  - 確認した Commands:
    - [ ] `/________________`
    - [ ] `/________________`
    - [ ] `/________________`

- [ ] `/agents` で Agents が表示されることを確認した
  - 確認した Agents:
    - [ ] `________________`
    - [ ] `________________`
    - [ ] `________________`

### 動作確認
- [ ] 少なくとも1つのコマンドを実行して動作を確認した
  - 実行したコマンド: `/________________`
  - 結果: 成功 / 失敗
  - メモ: `_______________________________`

- [ ] 少なくとも1つのエージェントを使用して動作を確認した
  - 使用したエージェント: `________________`
  - 結果: 成功 / 失敗
  - メモ: `_______________________________`

---

## Phase 6: 後処理

### ドキュメント化
- [ ] インストールしたコンポーネントをリストアップした（上記参照）

- [ ] 特殊な設定や注意事項をメモした
  ```
  メモ:
  _____________________________________
  _____________________________________
  _____________________________________
  ```

### チーム共有（プロジェクトローカルの場合）
- [ ] `.claude/` ディレクトリを Git にコミットした
  ```bash
  git add .claude/
  git commit -m "Add [plugin-name] plugin components"
  git push
  ```

- [ ] チームメンバーに通知した

---

## トラブルシューティング

### 問題が発生した場合
- [ ] 問題を記録した
  ```
  問題:
  _____________________________________
  _____________________________________
  ```

- [ ] 解決策を試した
  ```
  試した解決策:
  _____________________________________
  _____________________________________
  ```

- [ ] 最終結果
  - [ ] 解決した
  - [ ] 未解決（エスカレーション必要）

---

## まとめ

### インストール結果
- [ ] **成功** - すべてのコンポーネントが正常に動作している
- [ ] **部分的成功** - 一部のコンポーネントのみ動作している
- [ ] **失敗** - インストールできなかった

### 所要時間
- 開始時刻: `_________________`
- 終了時刻: `_________________`
- 合計時間: `_________________`

### 学んだこと・改善点
```
_____________________________________
_____________________________________
_____________________________________
_____________________________________
```

---

## 署名

- **作業者**: `_________________`
- **レビュー者** (該当する場合): `_________________`
- **承認日**: `_________________`

---

**注意**: このチェックリストは、手動インストールプロセスの追跡と品質保証のためのものです。各ステップを慎重に実行し、問題が発生した場合は記録してください。
