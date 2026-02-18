# Design System Guide

Principle-level guidance for building distinctive design systems. This file contains no specific font names, hex codes, or preset palettes — only thinking frameworks.

## Contents

- Typography principles
- Color system principles
- Motion principles
- Spatial composition principles

## Typography Principles

### Font Selection Thinking

The goal is to find typography that **reinforces the project's unique identity**. Never select a font because it is popular or familiar.

**Discovery process:**
1. Define the aesthetic direction first (before browsing fonts)
2. Ask: "What visual qualities does this aesthetic need?" (geometric? organic? sharp? flowing? heavy? delicate?)
3. Browse fonts filtered by those qualities, not by popularity
4. Test candidates at extreme sizes (12px body AND 120px headline) — both must work
5. Reject any font you have used in a recent project

**Sources for discovery:**
- Google Fonts (filter by category, then sort by "trending" or "date added" to find less common options)
- Fontsource (for npm-installable fonts)
- Independent foundries (for truly unique choices)

### Pairing Principles

Strong font pairings create tension and hierarchy:

- **Contrast is king**: Pair fonts from different classifications (serif + mono, display + humanist sans)
- **Shared skeleton, different dress**: Fonts that share similar letter proportions but differ in style pair well
- **One voice per role**: One font for display/headlines, one for body. Maximum three typefaces per project
- **Weight as architecture**: Use weight extremes (100-200 vs 700-900) to build visual hierarchy, not just size

### Scale and Rhythm

- **Type scale with large jumps**: Use ratios of 1.5+ (Major Third or higher). Avoid minor increments
- **Minimum 3x jump between body and primary heading**: If body is 16px, h1 should be 48px+
- **Line height decreases as size increases**: Body at 1.5-1.7, headings at 1.0-1.2
- **Letter spacing opens at small sizes, tightens at large sizes**

## Color System Principles

### Palette Construction Thinking

Do not start with a color picker. Start with the aesthetic direction.

**Process:**
1. What world does this aesthetic live in? (industrial? natural? digital? vintage?)
2. What emotional temperature? (warm? cool? neutral? mixed?)
3. What intensity level? (muted and sophisticated? vivid and energetic? dark and moody?)
4. Find 1 dominant color that answers those questions
5. Find 1 accent that creates deliberate tension with the dominant
6. Build supporting neutrals that carry the same temperature

### Inspiration Sources

Draw palettes from real-world sources, not from color theory tools:

- **IDE themes**: Dracula, Monokai, Nord, Solarized — these are well-tested color systems
- **Cultural aesthetics**: Japanese wabi-sabi (muted earth tones), Scandinavian (cool whites with warm wood), Art Deco (gold/black/cream)
- **Nature**: Specific ecosystems (deep ocean = dark blues + bioluminescent accents, autumn forest = warm browns + amber)
- **Film**: Color grading from specific genres or directors
- **Architecture**: Materials and finishes (concrete + copper, marble + brass)

### Implementation with CSS Variables

Structure color tokens semantically, not by hue:

```
--color-surface-primary
--color-surface-elevated
--color-text-primary
--color-text-secondary
--color-accent
--color-accent-subtle
```

This enables theme switching and maintains consistency without hard-coding specific colors throughout the codebase.

### Accessibility

- WCAG AA minimum: 4.5:1 contrast for normal text, 3:1 for large text
- Test with color blindness simulators
- Never rely on color alone to convey information

## Motion Principles

### When to Animate

Not everything should move. Focus animation budget on **high-impact moments**:

| Moment | Impact | Example |
|--------|--------|---------|
| Page load | Very high | Staggered element reveal |
| State transition | High | Content swap, route change |
| Hover / Focus | Medium | Button feedback, card lift |
| Scroll | Medium | Parallax, element reveal |
| Idle | Low | Subtle ambient motion |

### Animation Character

Motion should match the aesthetic direction:

- **Sharp and precise** → short durations (150-250ms), ease-out, crisp transforms
- **Fluid and organic** → longer durations (300-600ms), custom cubic-bezier, flowing paths
- **Playful and bouncy** → spring physics, overshoot, squash-and-stretch
- **Elegant and restrained** → subtle opacity + transform, ease-in-out

### CSS-First Approach

Prefer CSS animations for:
- Hover effects and micro-interactions
- Simple enter/exit transitions
- Loading states and skeleton screens
- Scroll-driven animations (using `animation-timeline` where supported)

Use Motion library (or similar) only for:
- Complex orchestrated sequences
- Layout animations (AnimatePresence)
- Gesture-driven interactions
- Spring physics

### Reduced Motion

Always implement `prefers-reduced-motion`:
- Replace motion with instant state changes or subtle opacity fades
- Never remove functional transitions entirely — reduce them
- Test with reduced motion enabled

## Spatial Composition Principles

### Breaking the Grid

Grids provide structure, but distinctive design knows when to break them:

- **Intentional overflow**: Let elements bleed beyond their containers
- **Overlapping layers**: Stack elements at different z-indexes with partial overlap
- **Asymmetric balance**: Unequal columns, off-center focal points
- **Diagonal flow**: Angled sections, rotated elements, non-horizontal reading paths
- **Scale contrast**: Mix very large and very small elements in the same view

### Negative Space as a Tool

- **Generous whitespace** communicates luxury, confidence, and focus
- **Controlled density** communicates energy, information richness, and urgency
- Choose one approach per project and commit — mixing them creates confusion

### Responsive Spatial Design

- Design for mobile-first, but do not just stack desktop elements vertically
- Each breakpoint should be a **reimagined layout**, not a collapsed one
- Touch targets: minimum 44x44px
- Consider spatial relationships at every viewport size

### Depth and Dimension

- **Layered backgrounds**: Multiple levels of depth using shadows, blur, and transparency
- **Foreground/background relationship**: Create clear spatial hierarchy
- **Z-axis thinking**: Consider which elements "sit on top of" others and why
