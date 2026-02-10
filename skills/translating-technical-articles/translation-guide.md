# Translation Guide

This guide provides detailed guidance for translating technical articles from English to Japanese.

## Table of Contents

- Technical term handling patterns
- Layout preservation techniques
- Common translation patterns
- Quality assurance checklist

## Technical Term Handling

### Proper Nouns (Keep Original)

**Products and Services**:
- Claude Code → Claude Code
- Agent Skills → Agent Skills
- Model Context Protocol (MCP) → Model Context Protocol (MCP)
- GitHub → GitHub
- Docker → Docker

**Protocols and Standards**:
- HTTP → HTTP
- REST API → REST API
- JSON → JSON
- YAML → YAML

### General Technical Terms

**First mention**: Include original in parentheses
- context window → コンテキストウィンドウ (context window)
- progressive disclosure → 段階的開示 (progressive disclosure)
- token → トークン (token)

**Subsequent mentions**: Japanese only
- コンテキストウィンドウ
- 段階的開示
- トークン

### Industry-Established Terms

Use original if well-established in Japanese tech community:
- API → API
- SDK → SDK
- CLI → CLI
- Frontend → フロントエンド
- Backend → バックエンド

## Layout Preservation

### Headings

Preserve exact heading levels:

```markdown
# Original H1
## Original H2
### Original H3
```

Becomes:

```markdown
# 翻訳されたH1
## 翻訳されたH2
### 翻訳されたH3
```

### Lists

**Numbered lists**:

```markdown
1. First item
2. Second item
3. Third item
```

Becomes:

```markdown
1. 最初の項目
2. 2番目の項目
3. 3番目の項目
```

**Bulleted lists**:

```markdown
- Point one
- Point two
  - Nested point
```

Becomes:

```markdown
- ポイント1
- ポイント2
  - ネストされたポイント
```

### Code Blocks

Preserve syntax highlighting and do not translate code:

````markdown
```python
def example():
    return "Do not translate"
```
````

Stays exactly the same.

**Comments in code**: Translate if helpful, but not required:

```python
# This is a comment
```

Can become:

```python
# これはコメントです
```

### Images and Links

Preserve all URLs and image links exactly:

```markdown
![Alt text](https://example.com/image.png)
[Link text](https://example.com/page)
```

Translate only the alt text and link text:

```markdown
![代替テキスト](https://example.com/image.png)
[リンクテキスト](https://example.com/page)
```

## Common Translation Patterns

### Active Voice Preference

English active voice → Japanese active voice

**Example**:
- "Claude processes the file" → "Claudeはファイルを処理する"
- "The system validates input" → "システムは入力を検証する"

### Natural Japanese Structure

Avoid literal word-order translation. Restructure for natural Japanese:

**Literal** (awkward):
"Agent Skills that are organized folders of instructions"
→ "指示の整理されたフォルダーであるAgent Skills"

**Natural** (better):
→ "Agent Skillsは、指示を整理したフォルダーだ"

### Verb Forms

Use present tense for descriptions:
- "helps" → "助ける" (not "助けた")
- "extends" → "拡張する" (not "拡張した")
- "provides" → "提供する" (not "提供した")

### Politeness Level

Use plain form (だ/である体) for technical documentation, not polite form (です/ます体).

**Plain**: これは例だ。
**Polite**: これは例です。

Use **plain form** for consistency with technical writing conventions.

## Quality Assurance Checklist

After translation, verify:

### Structure
- [ ] All heading levels match original
- [ ] List nesting preserved
- [ ] Code blocks have correct syntax highlighting
- [ ] Tables formatted correctly (if present)

### Content
- [ ] Technical terms consistent throughout
- [ ] Proper nouns unchanged
- [ ] URLs and image links intact
- [ ] No untranslated English fragments

### Natural Japanese
- [ ] Sentences flow naturally
- [ ] No awkward literal translations
- [ ] Consistent verb forms
- [ ] Appropriate politeness level (plain form)

### Metadata
- [ ] Original URL included
- [ ] Publication date included
- [ ] Translated title natural and clear

## Edge Cases

### Acronyms

First mention: Full term + acronym + Japanese
- "Test-Driven Development (TDD)" → "テスト駆動開発 (Test-Driven Development, TDD)"

Subsequent: Acronym only
- TDD → TDD

### Brand Names with Descriptors

Keep brand name, translate descriptor:
- "GitHub repository" → "GitHubリポジトリ"
- "Docker container" → "Dockerコンテナ"
- "Python script" → "Pythonスクリプト"

### Code Comments vs. Prose

**In code blocks**: Optional translation
**In prose**: Always translate

Example:

```python
# Optional: コメント
def function():
    pass
```

But in prose: "The comment says..." → "コメントには...と書かれている"

## Common Mistakes to Avoid

1. **Over-translating**: Don't translate well-known technical terms
   - Bad: "ギットハブ" for GitHub
   - Good: "GitHub"

2. **Under-translating**: Don't leave general terms in English
   - Bad: "This feature helps developers"
   - Good: "この機能は開発者を助ける"

3. **Inconsistent terminology**: Use same translation for same term
   - Bad: Mix "フィールド" and "項目" for "field"
   - Good: Always "フィールド" for "field"

4. **Breaking links**: Always preserve URL structure
   - Bad: Translate URL components
   - Good: Keep exact URL, translate only link text

5. **Polite form mixing**: Don't mix plain and polite forms
   - Bad: "これは例だ。機能を提供します。"
   - Good: "これは例だ。機能を提供する。"
