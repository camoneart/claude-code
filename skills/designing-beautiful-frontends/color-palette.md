# カラーパレットガイド

## パレット構築の原則

### 1. 支配的な色を1つ選ぶ
ブランドを象徴する主要色。ページの60-70%を占める。

### 2. 鮮明なアクセント色を追加
主要色と対照的な色。CTAやハイライトに使用。ページの10-20%。

### 3. ニュートラルカラーを設定
テキスト、背景用のグレースケール。ページの20-30%。

---

## 絶対に避ける組み合わせ

| 組み合わせ | 問題点 |
|-----------|-------|
| 紫グラデーション + 白背景 | 汎用SaaS感、使い古されている |
| 青 + グレーのみ | 企業テンプレ感 |
| Bootstrap青（#0d6efd） | 一目でBootstrapとわかる |
| Material Purple（#673ab7） | Googleのデフォルト感 |
| 虹色グラデーション | 安っぽい印象 |

---

## 推奨パレット例

### 1. ネオンテック（ダークモード）
```css
:root {
  /* 主要色 */
  --primary: #0ff;           /* シアン */
  --primary-dark: #0cc;

  /* アクセント */
  --accent: #f0f;            /* マゼンタ */
  --accent-secondary: #ff0;  /* イエロー */

  /* 背景 */
  --bg: #0a0a0f;             /* ダークネイビー */
  --bg-secondary: #12121a;

  /* テキスト */
  --text: #e0e0e0;
  --text-muted: #808080;
}
```
**適用**: 開発者ツール、ゲーム、テック系

### 2. アースウォーム（ライトモード）
```css
:root {
  /* 主要色 */
  --primary: #e07a5f;        /* テラコッタ */
  --primary-light: #f4a582;

  /* アクセント */
  --accent: #3d405b;         /* ダークブルー */
  --accent-secondary: #81b29a; /* セージグリーン */

  /* 背景 */
  --bg: #f4f1de;             /* クリーム */
  --bg-secondary: #fff;

  /* テキスト */
  --text: #2d2d2d;
  --text-muted: #6b6b6b;
}
```
**適用**: ウェルネス、食品、ライフスタイル

### 3. モノクロームインパクト
```css
:root {
  /* 主要色 */
  --primary: #000;

  /* アクセント */
  --accent: #ff3366;         /* ビビッドピンク */
  /* または */
  --accent: #00ff88;         /* ネオングリーン */

  /* 背景 */
  --bg: #fff;
  --bg-secondary: #f5f5f5;

  /* テキスト */
  --text: #1a1a1a;
  --text-muted: #666;
}
```
**適用**: ファッション、ポートフォリオ、ミニマリスト

### 4. ディープオーシャン（ダークモード）
```css
:root {
  /* 主要色 */
  --primary: #1e3a5f;        /* ディープブルー */
  --primary-light: #2d5a8f;

  /* アクセント */
  --accent: #f59e0b;         /* アンバー */
  --accent-secondary: #06b6d4; /* シアン */

  /* 背景 */
  --bg: #0f172a;             /* スレートダーク */
  --bg-secondary: #1e293b;

  /* テキスト */
  --text: #f1f5f9;
  --text-muted: #94a3b8;
}
```
**適用**: 金融、ビジネス、ダッシュボード

### 5. フォレストモダン
```css
:root {
  /* 主要色 */
  --primary: #2d4a3e;        /* フォレストグリーン */
  --primary-light: #3d5a4e;

  /* アクセント */
  --accent: #d4a373;         /* ゴールデンブラウン */
  --accent-secondary: #e9c46a;

  /* 背景 */
  --bg: #fefae0;             /* クリームイエロー */
  --bg-secondary: #fff;

  /* テキスト */
  --text: #1a1a1a;
  --text-muted: #6b6b6b;
}
```
**適用**: エコ、オーガニック、自然派

### 6. ネオブルータリズム
```css
:root {
  /* 主要色 - 原色を大胆に */
  --primary: #ff5722;        /* ビビッドオレンジ */
  /* または */
  --primary: #00bcd4;        /* シアン */
  --primary: #ffeb3b;        /* イエロー */

  /* アクセント */
  --accent: #000;            /* ブラック（ボーダー用） */

  /* 背景 */
  --bg: #f5f5dc;             /* ベージュ */
  /* または */
  --bg: #e8f5e9;             /* ライトグリーン */

  /* テキスト */
  --text: #000;
}
```
**適用**: クリエイティブエージェンシー、スタートアップ

---

## カラースキームの決め方

### 方法1: IDEテーマからインスピレーション

人気のIDEテーマはプロがデザインした配色：

| テーマ | 特徴 |
|-------|------|
| Dracula | 紫ベース、ダーク、ポップ |
| Nord | 北欧風、落ち着いた青 |
| One Dark | バランス良い、目に優しい |
| Monokai | ビビッド、コントラスト高い |
| Gruvbox | レトロ、暖色系 |

### 方法2: 文化的美学から

| 美学 | 配色特徴 |
|-----|---------|
| 和風 | 藍、朱、金、白 |
| スカンジナビア | 白、グレー、木の色、ブルー |
| 地中海 | テラコッタ、オリーブ、海の青 |
| サイバーパンク | ネオンピンク、シアン、ダーク |

### 方法3: 自然から

| ソース | 配色特徴 |
|-------|---------|
| 夕焼け | オレンジ、ピンク、パープル |
| 森林 | グリーン、ブラウン、クリーム |
| 海 | ブルー、ターコイズ、白 |
| 砂漠 | サンド、テラコッタ、オレンジ |

---

## Tailwind CSS での実装

### tailwind.config.js
```js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: 'var(--primary)',
          dark: 'var(--primary-dark)',
          light: 'var(--primary-light)',
        },
        accent: {
          DEFAULT: 'var(--accent)',
          secondary: 'var(--accent-secondary)',
        },
        background: {
          DEFAULT: 'var(--bg)',
          secondary: 'var(--bg-secondary)',
        },
      },
    },
  },
};
```

### 使用例
```tsx
<div className="bg-background text-text">
  <h1 className="text-primary">Title</h1>
  <button className="bg-accent text-white">CTA</button>
</div>
```

---

## アクセシビリティ

### コントラスト比の確認

| 用途 | 最小コントラスト比（WCAG AA） |
|-----|---------------------------|
| 本文テキスト | 4.5:1 |
| 大きな文字（18px以上） | 3:1 |
| UI要素 | 3:1 |

### ツール
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Coolors Contrast Checker](https://coolors.co/contrast-checker)

### ダークモード対応

```css
@media (prefers-color-scheme: dark) {
  :root {
    --bg: #0a0a0f;
    --text: #e0e0e0;
    /* ダークモード用の色を定義 */
  }
}
```
