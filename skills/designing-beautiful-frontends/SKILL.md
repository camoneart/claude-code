---
name: Designing Beautiful Frontends
description: Create visually stunning, distinctive UI designs that break from generic patterns. Use when building user interfaces, styling components, or when the user mentions UI/UXデザイン/美しいUI/フロントエンドデザイン/コンポーネント作成/かっこいいUI/印象的なデザイン.
allowed-tools: Write, Read, Edit, Bash
---

# Designing Beautiful Frontends

このSkillは、汎用的で退屈なUIを避け、記憶に残る美しいフロントエンドを構築するためのガイドラインを提供する。

## いつ使うか

- UIコンポーネントを作成する時
- フロントエンドのスタイリングを行う時
- 「美しいUI」「印象的なデザイン」を求められた時
- ランディングページ、ダッシュボード、Webアプリを構築する時

## デザイン思考の4つの質問

すべてのUI設計の前に、以下を自問すること：

1. **Purpose（目的）**: このインターフェースが解決する問題は何か？ユーザーは誰か？
2. **Tone（トーン）**: どの美学スタイルを採用するか？（下記参照）
3. **Constraints（制約）**: 技術的な要件、ブラウザサポート、パフォーマンス要件は？
4. **Differentiation（差別化）**: 何がこのUIを記憶に残るものにするか？

## 極端な美学の選択

**重要**: 平凡を避けるため、明確な方向性を選ぶ。中途半端は最悪。

| スタイル | 特徴 | 適したプロジェクト |
|---------|------|-------------------|
| ブルータルミニマリズム | 極端なシンプルさ、大胆な空白、モノクロ | ポートフォリオ、アート系 |
| マキシマリストカオス | 豊かなレイヤー、重なる要素、鮮やかな色彩 | エンターテイメント、クリエイティブ |
| レトロフューチャリズム | ノスタルジーと未来感の融合、ネオン効果 | ゲーム、音楽系 |
| オーガニックフロー | 自然な曲線、有機的フォルム、柔らかいグラデーション | ウェルネス、食品系 |
| ネオブルータリズム | 太いボーダー、強いコントラスト、生々しさ | テック、スタートアップ |
| エディトリアル | 雑誌的レイアウト、タイポグラフィ重視 | メディア、出版系 |

詳細は[design-principles.md](design-principles.md)を参照。

## タイポグラフィ

### 絶対に避けるフォント
- Inter, Roboto, Arial, Helvetica, Open Sans, Lato, system-ui

### 推奨ディスプレイフォント（見出し用）
- **JetBrains Mono** - テック感、プログラマー向け
- **Playfair Display** - エレガンス、高級感
- **Space Grotesk** - モダン、幾何学的
- **Syne** - 大胆、実験的
- **Archivo Black** - インパクト、力強さ
- **Bricolage Grotesque** - 個性的、温かみ

### 推奨ボディフォント（本文用）
- **IBM Plex Sans** - 高可読性、ドキュメント向け
- **Work Sans** - バランス良い、ブログ向け
- **Source Sans 3** - 汎用性高い

### フォントペアリングのルール
- 極端なコントラスト: 100/200 weight vs 800/900（400 vs 600ではない）
- サイズジャンプ: 3倍以上（1.5倍ではない）

詳細は[typography-guide.md](typography-guide.md)を参照。

## カラー & テーマ

### 基本原則
- **支配的な色 + 鮮明なアクセント** > 控えめに分散されたパレット
- CSSカスタムプロパティで一貫性を保つ
- IDEテーマや文化的美学からインスピレーションを得る

### 絶対に避ける組み合わせ
- 紫グラデーション + 白背景（汎用SaaS感）
- 青 + グレーのみ（企業テンプレ感）
- Bootstrap/Materialのデフォルトカラー

詳細は[color-palette.md](color-palette.md)を参照。

## モーション

### 優先順位
1. **CSS-only アニメーション**（パフォーマンス最優先）
2. **Motion ライブラリ**（React/Vue/JavaScript対応）

### 高インパクトな瞬間に焦点
- ページロード時のスタガードアニメーション（animation-delay活用）
- ホバー時の驚きのあるマイクロインタラクション
- スクロールトリガーアニメーション

散らばったマイクロインタラクションより、1つの洗練されたページロードアニメーションの方が効果的。

## 空間構成（Spatial Composition）

### レイアウト原則
- **予想外のレイアウト**を恐れない
- 非対称、重なり、対角線フロー
- **グリッドを破る要素**を戦略的に配置
- 寛大なネガティブスペース OR 制御された密度

### 避けるべきレイアウト
- ヘッダー → ヒーロー → 3カラム特徴 → CTA → フッター（テンプレ感）

## 背景 & テクスチャ

単色背景をデフォルトにしない。以下を検討：

- グラデーションメッシュ
- ノイズテクスチャ
- 幾何学パターン
- 重ねた透明度
- ドラマティックな影
- 装飾的ボーダー
- カスタムカーソル
- グレインオーバーレイ

## アンチパターン（絶対に避ける）

詳細は[anti-patterns.md](anti-patterns.md)を参照。

- 使い古されたフォント（Inter, Roboto, Arial）
- 紫グラデーション + 白背景
- すべてが予測可能なレイアウト
- Bootstrap/Materialのデフォルトスタイル
- 意味のないアニメーション
- コンテキストに合わない汎用デザイン

## 推奨技術スタック

- **React 19** + **TypeScript**
- **Next.js 16**（App Router、Turbopack、React Compiler対応）
- **Tailwind CSS v4** + **shadcn/ui**
- **Motion**（旧Framer Motion、アニメーション用）
- **Google Fonts** または **Fontsource**

### インストール例

```bash
# Next.js 16 プロジェクト作成
npx create-next-app@latest my-app --typescript --tailwind

# Motion（アニメーション）
pnpm add motion

# shadcn/ui
pnpm dlx shadcn@latest init
```

## 実装例

具体的なコード例は[examples.md](examples.md)を参照。

## 実装前チェックリスト

UI実装完了前に確認：

- [ ] 使い古されたフォントを使っていない
- [ ] カラーパレットに明確な支配色とアクセント色がある
- [ ] レイアウトに予想外の要素がある
- [ ] 高インパクトな瞬間にアニメーションがある
- [ ] 背景に深みや雰囲気がある（単色ではない）
- [ ] モバイル対応を考慮している
- [ ] アクセシビリティ（コントラスト比等）を確認した

## 最重要原則

**Claudeは並外れたクリエイティブワークが可能。抑制せず、独自のビジョンに全力でコミットせよ。**

ボールドなマキシマリズムも洗練されたミニマリズムも有効 - 重要なのは意図を持った実行であり、強度ではない。
