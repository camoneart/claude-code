# タイポグラフィガイド

## 絶対に避けるフォント

以下のフォントは使い古されており、汎用的な印象を与える：

| フォント | 問題点 |
|---------|-------|
| Inter | SaaS/スタートアップで多用されすぎ |
| Roboto | Googleのデフォルト感 |
| Arial | Windows感、古い |
| Helvetica | 差別化不可能 |
| Open Sans | 無個性 |
| Lato | どこにでもある |
| system-ui | デフォルト感 |

---

## 推奨フォントライブラリ

### ディスプレイフォント（見出し用）

#### テック/モダン系
| フォント名 | 特徴 | Google Fonts |
|-----------|------|--------------|
| JetBrains Mono | モノスペース、開発者向け | Yes |
| Space Grotesk | 幾何学的、モダン | Yes |
| Syne | 実験的、大胆 | Yes |
| Outfit | クリーン、現代的 | Yes |
| Bricolage Grotesque | 個性的、温かみ | Yes |

#### エレガント/高級系
| フォント名 | 特徴 | Google Fonts |
|-----------|------|--------------|
| Playfair Display | セリフ、高級感 | Yes |
| Fraunces | クラシック、温かみ | Yes |
| Cormorant Garamond | 優雅、エディトリアル | Yes |
| Libre Baskerville | 伝統的、信頼感 | Yes |

#### インパクト/力強さ系
| フォント名 | 特徴 | Google Fonts |
|-----------|------|--------------|
| Archivo Black | 太字、インパクト | Yes |
| Bebas Neue | コンデンス、スポーティ | Yes |
| Oswald | 力強い、見出し向け | Yes |

### ボディフォント（本文用）

| フォント名 | 可読性 | 特徴 | Google Fonts |
|-----------|-------|------|--------------|
| IBM Plex Sans | 高い | テック感、ドキュメント向け | Yes |
| Work Sans | 中〜高 | バランス良い、多用途 | Yes |
| Source Sans 3 | 高い | Adobe製、汎用性高い | Yes |
| Nunito | 中 | 丸みがある、親しみやすい | Yes |
| DM Sans | 高い | 幾何学的、モダン | Yes |

---

## フォントペアリング例

### 1. テックスタートアップ
```css
:root {
  --font-display: 'Space Grotesk', sans-serif;
  --font-body: 'IBM Plex Sans', sans-serif;
}

h1 { font-family: var(--font-display); font-weight: 700; }
body { font-family: var(--font-body); font-weight: 400; }
```

### 2. 高級ブランド
```css
:root {
  --font-display: 'Playfair Display', serif;
  --font-body: 'Work Sans', sans-serif;
}

h1 { font-family: var(--font-display); font-weight: 600; }
body { font-family: var(--font-body); font-weight: 300; }
```

### 3. クリエイティブエージェンシー
```css
:root {
  --font-display: 'Syne', sans-serif;
  --font-body: 'DM Sans', sans-serif;
}

h1 { font-family: var(--font-display); font-weight: 800; }
body { font-family: var(--font-body); font-weight: 400; }
```

### 4. エディトリアル/メディア
```css
:root {
  --font-display: 'Cormorant Garamond', serif;
  --font-body: 'Source Sans 3', sans-serif;
}

h1 { font-family: var(--font-display); font-weight: 500; }
body { font-family: var(--font-body); font-weight: 400; }
```

### 5. 開発者向けツール
```css
:root {
  --font-display: 'JetBrains Mono', monospace;
  --font-body: 'IBM Plex Sans', sans-serif;
  --font-code: 'JetBrains Mono', monospace;
}

h1 { font-family: var(--font-display); font-weight: 700; }
body { font-family: var(--font-body); font-weight: 400; }
code { font-family: var(--font-code); }
```

---

## タイポグラフィのルール

### 1. 極端なコントラストを使う

**悪い例:**
```css
h1 { font-weight: 600; }
body { font-weight: 400; }
/* 差が小さすぎて印象が弱い */
```

**良い例:**
```css
h1 { font-weight: 900; }
body { font-weight: 300; }
/* 極端な差でインパクトを出す */
```

### 2. サイズジャンプは大胆に

**悪い例:**
```css
h1 { font-size: 2rem; }   /* 32px */
h2 { font-size: 1.5rem; } /* 24px */
p { font-size: 1rem; }    /* 16px */
/* 1.5倍の増加は弱い */
```

**良い例:**
```css
h1 { font-size: 4rem; }   /* 64px */
h2 { font-size: 2rem; }   /* 32px */
p { font-size: 1rem; }    /* 16px */
/* 2-3倍のジャンプで視覚的階層を明確に */
```

### 3. letter-spacingの活用

```css
/* 大きな見出しはトラッキングを狭く */
h1 {
  font-size: 4rem;
  letter-spacing: -0.02em;
}

/* 小さなテキストや大文字はトラッキングを広く */
.label {
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
}
```

### 4. line-heightの最適化

```css
/* 見出し: タイト */
h1 {
  font-size: 4rem;
  line-height: 1.1;
}

/* 本文: 読みやすさ重視 */
p {
  font-size: 1rem;
  line-height: 1.6;
}

/* 長文: さらに余裕を */
article p {
  line-height: 1.8;
}
```

---

## Next.js / React での実装

### Google Fonts（next/font）
```tsx
import { Space_Grotesk, IBM_Plex_Sans } from 'next/font/google';

const spaceGrotesk = Space_Grotesk({
  subsets: ['latin'],
  variable: '--font-display',
  weight: ['400', '500', '600', '700'],
});

const ibmPlexSans = IBM_Plex_Sans({
  subsets: ['latin'],
  variable: '--font-body',
  weight: ['300', '400', '500', '600'],
});

export default function RootLayout({ children }) {
  return (
    <html className={`${spaceGrotesk.variable} ${ibmPlexSans.variable}`}>
      <body>{children}</body>
    </html>
  );
}
```

### Tailwind CSS設定
```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      fontFamily: {
        display: ['var(--font-display)', 'sans-serif'],
        body: ['var(--font-body)', 'sans-serif'],
      },
    },
  },
};
```

### 使用例
```tsx
<h1 className="font-display text-6xl font-bold tracking-tight">
  Bold Heading
</h1>
<p className="font-body text-lg leading-relaxed">
  Body text with good readability.
</p>
```
