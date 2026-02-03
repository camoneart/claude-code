# 実装例

## 1. ヒーローセクション（ネオブルータリズム）

```tsx
import { motion } from 'motion/react';

export function NeobrutalHero() {
  return (
    <section className="relative min-h-screen bg-[#f5f5dc] overflow-hidden">
      {/* 装飾的な幾何学要素 */}
      <div
        className="absolute top-20 right-20 w-64 h-64 bg-[#ff3366]
                   border-4 border-black rotate-12 hidden md:block"
      />
      <div
        className="absolute bottom-40 left-10 w-32 h-32 bg-[#00bcd4]
                   border-4 border-black -rotate-6 hidden md:block"
      />

      <motion.div
        initial={{ opacity: 0, y: 50 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8, ease: 'easeOut' }}
        className="relative z-10 max-w-4xl mx-auto pt-32 px-6"
      >
        <h1 className="font-display text-6xl md:text-8xl lg:text-9xl font-black
                       tracking-tight leading-[0.9]">
          Create<br />
          <span className="text-[#ff3366]">Bold</span><br />
          Design
        </h1>

        <p className="mt-8 text-xl max-w-md border-l-4 border-black pl-4 font-body">
          汎用的なテンプレートを超えて、記憶に残るUIを構築する
        </p>

        <motion.button
          whileHover={{ scale: 1.02, x: 4, y: 4 }}
          whileTap={{ scale: 0.98 }}
          className="mt-12 px-8 py-4 bg-black text-white font-bold text-lg
                     border-4 border-black shadow-[4px_4px_0_0_#ff3366]
                     hover:shadow-[8px_8px_0_0_#ff3366] transition-shadow"
        >
          Get Started
        </motion.button>
      </motion.div>
    </section>
  );
}
```

---

## 2. カードコンポーネント（グラスモーフィズム）

```tsx
interface GlassCardProps {
  title: string;
  description: string;
  icon?: React.ReactNode;
}

export function GlassCard({ title, description, icon }: GlassCardProps) {
  return (
    <div className="relative group">
      {/* 背景グロー効果 */}
      <div
        className="absolute -inset-1 bg-gradient-to-r from-[#6366f1] to-[#a855f7]
                   rounded-2xl blur-lg opacity-25 group-hover:opacity-75
                   transition-opacity duration-500"
      />

      <div
        className="relative p-8 bg-white/10 backdrop-blur-xl rounded-xl
                   border border-white/20 hover:border-white/40
                   transition-colors duration-300"
      >
        {icon && (
          <div className="w-12 h-12 mb-4 text-[#a855f7]">
            {icon}
          </div>
        )}
        <h3 className="text-2xl font-bold text-white font-display">
          {title}
        </h3>
        <p className="mt-4 text-gray-300 font-body leading-relaxed">
          {description}
        </p>
      </div>
    </div>
  );
}
```

---

## 3. ボタン（マイクロインタラクション付き）

```tsx
import { motion } from 'motion/react';

interface AnimatedButtonProps {
  children: React.ReactNode;
  variant?: 'primary' | 'secondary' | 'outline';
  onClick?: () => void;
}

export function AnimatedButton({
  children,
  variant = 'primary',
  onClick
}: AnimatedButtonProps) {
  const variants = {
    primary: 'bg-black text-white',
    secondary: 'bg-[#ff3366] text-white',
    outline: 'bg-transparent text-black border-2 border-black',
  };

  return (
    <motion.button
      onClick={onClick}
      whileHover={{ scale: 1.05 }}
      whileTap={{ scale: 0.95 }}
      className={`relative px-8 py-4 font-bold overflow-hidden group ${variants[variant]}`}
    >
      {/* ホバー時のスライドエフェクト */}
      <span
        className="absolute inset-0 bg-[#ff3366] translate-x-[-100%]
                   group-hover:translate-x-0 transition-transform
                   duration-300 ease-out"
      />
      <span className="relative z-10">{children}</span>
    </motion.button>
  );
}
```

---

## 4. ナビゲーションバー（スクロール対応）

```tsx
'use client';

import { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';

export function Navigation() {
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 50);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  return (
    <motion.nav
      initial={{ y: -100 }}
      animate={{ y: 0 }}
      className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
        scrolled
          ? 'bg-white/80 backdrop-blur-lg shadow-lg'
          : 'bg-transparent'
      }`}
    >
      <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
        <a href="/" className="font-display text-2xl font-bold">
          Brand
        </a>

        <div className="hidden md:flex items-center gap-8">
          {['Products', 'About', 'Blog', 'Contact'].map((item, i) => (
            <motion.a
              key={item}
              href={`#${item.toLowerCase()}`}
              initial={{ opacity: 0, y: -20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.1 }}
              className="font-body text-sm hover:text-[#ff3366] transition-colors
                         relative after:absolute after:bottom-0 after:left-0
                         after:w-0 after:h-0.5 after:bg-[#ff3366]
                         hover:after:w-full after:transition-all"
            >
              {item}
            </motion.a>
          ))}
        </div>
      </div>
    </motion.nav>
  );
}
```

---

## 5. フィーチャーセクション（スタガードアニメーション）

```tsx
'use client';

import { motion } from 'motion/react';
import { useInView } from 'framer-motion';
import { useRef } from 'react';

const features = [
  { title: 'Lightning Fast', description: 'Optimized for speed' },
  { title: 'Secure by Default', description: 'Built-in security' },
  { title: 'Scalable', description: 'Grows with your needs' },
];

export function FeatureSection() {
  const ref = useRef(null);
  const isInView = useInView(ref, { once: true, margin: '-100px' });

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.2,
      },
    },
  };

  const itemVariants = {
    hidden: { opacity: 0, y: 50 },
    visible: {
      opacity: 1,
      y: 0,
      transition: { duration: 0.6, ease: 'easeOut' },
    },
  };

  return (
    <section className="py-24 bg-[#0a0a0f]">
      <motion.div
        ref={ref}
        variants={containerVariants}
        initial="hidden"
        animate={isInView ? 'visible' : 'hidden'}
        className="max-w-6xl mx-auto px-6 grid md:grid-cols-3 gap-8"
      >
        {features.map((feature) => (
          <motion.div
            key={feature.title}
            variants={itemVariants}
            className="p-8 border border-white/10 rounded-lg
                       hover:border-[#0ff]/50 transition-colors group"
          >
            <h3 className="text-xl font-display font-bold text-white
                          group-hover:text-[#0ff] transition-colors">
              {feature.title}
            </h3>
            <p className="mt-4 text-gray-400 font-body">
              {feature.description}
            </p>
          </motion.div>
        ))}
      </motion.div>
    </section>
  );
}
```

---

## 6. 背景パターン（ノイズテクスチャ）

```tsx
export function NoiseBackground({ children }: { children: React.ReactNode }) {
  return (
    <div className="relative">
      {/* ノイズオーバーレイ */}
      <div
        className="absolute inset-0 opacity-[0.03] pointer-events-none"
        style={{
          backgroundImage: `url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E")`,
        }}
      />
      {children}
    </div>
  );
}
```

---

## 7. グラデーションメッシュ背景

```tsx
export function MeshGradientBackground() {
  return (
    <div className="fixed inset-0 -z-10 overflow-hidden">
      <div
        className="absolute top-0 -left-1/4 w-1/2 h-1/2
                   bg-[#ff3366] rounded-full blur-[128px] opacity-30"
      />
      <div
        className="absolute bottom-0 -right-1/4 w-1/2 h-1/2
                   bg-[#6366f1] rounded-full blur-[128px] opacity-30"
      />
      <div
        className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2
                   w-1/3 h-1/3 bg-[#0ff] rounded-full blur-[100px] opacity-20"
      />
    </div>
  );
}
```

---

## 8. 引用ブロック（エディトリアルスタイル）

```tsx
interface QuoteBlockProps {
  quote: string;
  author: string;
  role?: string;
}

export function QuoteBlock({ quote, author, role }: QuoteBlockProps) {
  return (
    <blockquote className="relative py-12 px-8 md:px-16">
      {/* 装飾的なクォーテーションマーク */}
      <span
        className="absolute top-0 left-0 text-[200px] font-display
                   text-[#ff3366]/10 leading-none select-none"
      >
        "
      </span>

      <p className="relative z-10 text-3xl md:text-4xl font-display
                    font-medium leading-relaxed italic">
        {quote}
      </p>

      <footer className="mt-8 flex items-center gap-4">
        <div className="w-12 h-0.5 bg-[#ff3366]" />
        <div>
          <cite className="not-italic font-display font-bold">
            {author}
          </cite>
          {role && (
            <p className="text-sm text-gray-500 font-body">{role}</p>
          )}
        </div>
      </footer>
    </blockquote>
  );
}
```

---

## 9. カスタムカーソル

```tsx
'use client';

import { useEffect, useState } from 'react';
import { motion } from 'motion/react';

export function CustomCursor() {
  const [position, setPosition] = useState({ x: 0, y: 0 });
  const [isPointer, setIsPointer] = useState(false);

  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      setPosition({ x: e.clientX, y: e.clientY });

      const target = e.target as HTMLElement;
      setIsPointer(
        window.getComputedStyle(target).cursor === 'pointer' ||
        target.tagName === 'A' ||
        target.tagName === 'BUTTON'
      );
    };

    window.addEventListener('mousemove', handleMouseMove);
    return () => window.removeEventListener('mousemove', handleMouseMove);
  }, []);

  return (
    <>
      {/* メインカーソル */}
      <motion.div
        className="fixed top-0 left-0 w-4 h-4 bg-[#ff3366] rounded-full
                   pointer-events-none z-[9999] mix-blend-difference"
        animate={{
          x: position.x - 8,
          y: position.y - 8,
          scale: isPointer ? 2 : 1,
        }}
        transition={{ type: 'spring', stiffness: 500, damping: 28 }}
      />
      {/* トレイルカーソル */}
      <motion.div
        className="fixed top-0 left-0 w-8 h-8 border border-[#ff3366]
                   rounded-full pointer-events-none z-[9998]"
        animate={{
          x: position.x - 16,
          y: position.y - 16,
          scale: isPointer ? 1.5 : 1,
        }}
        transition={{ type: 'spring', stiffness: 150, damping: 15 }}
      />
    </>
  );
}
```

---

## 使用時の注意

1. **Motion** が必要: `pnpm add motion`
2. **Tailwind CSS** の設定が必要
3. **Next.js App Router** 前提のコード（`'use client'`）
4. フォントは別途設定が必要（typography-guide.md参照）
