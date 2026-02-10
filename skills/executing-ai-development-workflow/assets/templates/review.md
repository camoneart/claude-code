# レビュー結果: {{FEATURE_NAME}}

**レビュー日**: {{DATE}}
**レビュー対象**: {{TARGET_BRANCH}} → {{BASE_BRANCH}}
**ステータス**: {{STATUS}}

---

## サマリー

| 優先度 | 件数 | 対応方針 |
|--------|------|----------|
| Critical | {{CRITICAL_COUNT}} | 即時修正 |
| High | {{HIGH_COUNT}} | 即時修正 |
| Medium | {{MEDIUM_COUNT}} | 人間が判断 |
| Low | {{LOW_COUNT}} | 記録のみ |

**総指摘数**: {{TOTAL_COUNT}}

---

## Sub-Agent レビュー結果

### 1. Code Reviewer
**実行時刻**: {{CODE_REVIEW_TIME}}

{{CODE_REVIEW_SUMMARY}}

#### 主な指摘事項
{{CODE_REVIEW_FINDINGS}}

---

### 2. Security Auditor
**実行時刻**: {{SECURITY_REVIEW_TIME}}

{{SECURITY_REVIEW_SUMMARY}}

#### 主な指摘事項
{{SECURITY_REVIEW_FINDINGS}}

---

### 3. Architect Review
**実行時刻**: {{ARCHITECT_REVIEW_TIME}}

{{ARCHITECT_REVIEW_SUMMARY}}

#### 主な指摘事項
{{ARCHITECT_REVIEW_FINDINGS}}

---

### 4. Test AI TDD Expert
**実行時刻**: {{TEST_REVIEW_TIME}}

{{TEST_REVIEW_SUMMARY}}

#### 主な指摘事項
{{TEST_REVIEW_FINDINGS}}

---

## CodeRabbit CLI レビュー結果

**実行時刻**: {{CODERABBIT_TIME}}
**コマンド**: `{{CODERABBIT_COMMAND}}`

{{CODERABBIT_SUMMARY}}

#### 主な指摘事項
{{CODERABBIT_FINDINGS}}

---

## Critical Issues（即時修正）

{{#each CRITICAL_ISSUES}}
### {{this.id}}. {{this.title}}
- **ファイル**: `{{this.file}}:{{this.line}}`
- **検出元**: {{this.source}}
- **説明**: {{this.description}}
- **推奨対応**: {{this.recommendation}}
- **ステータス**: {{this.status}}

{{/each}}

---

## High Priority Issues（即時修正）

{{#each HIGH_ISSUES}}
### {{this.id}}. {{this.title}}
- **ファイル**: `{{this.file}}:{{this.line}}`
- **検出元**: {{this.source}}
- **説明**: {{this.description}}
- **推奨対応**: {{this.recommendation}}
- **ステータス**: {{this.status}}

{{/each}}

---

## Medium Priority Issues（人間判断）

{{#each MEDIUM_ISSUES}}
### {{this.id}}. {{this.title}}
- **ファイル**: `{{this.file}}:{{this.line}}`
- **検出元**: {{this.source}}
- **説明**: {{this.description}}
- **推奨対応**: {{this.recommendation}}
- **判断**: [ ] 修正する / [ ] 保留 / [ ] 却下
- **理由**:

{{/each}}

---

## Low Priority Issues（記録のみ）

{{#each LOW_ISSUES}}
### {{this.id}}. {{this.title}}
- **ファイル**: `{{this.file}}:{{this.line}}`
- **検出元**: {{this.source}}
- **説明**: {{this.description}}

{{/each}}

---

## 修正完了リスト

{{#each FIXED_ISSUES}}
- [x] {{this.id}}: {{this.title}} - {{this.file}}:{{this.line}}
{{/each}}

---

## 次のアクション

1. [ ] Critical/High issues の修正を実装
2. [ ] Medium issues について人間と相談
3. [ ] 修正後に再レビュー実施
4. [ ] PR作成準備

---

**レビュー担当**: Claude Code (AI Development Workflow Skill)
**人間確認者**: {{HUMAN_REVIEWER}}
