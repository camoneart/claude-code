# Implementation Checklist

Run through this checklist before delivering any UI implementation. All items should pass.

## Anti-Convergence Check

- [ ] Fonts are NOT from the convergence trap list (Inter, Roboto, Arial, Helvetica, Open Sans, Lato, system-ui)
- [ ] Fonts are NOT the same as those used in recent projects
- [ ] Color palette is NOT a commonly AI-generated combination (purple gradient + white, blue + gray only)
- [ ] Color palette is NOT recycled from a recent project
- [ ] Layout does NOT follow the template pattern (hero → features → CTA → footer)
- [ ] Layout contains at least one structurally unexpected element
- [ ] Animations are NOT all generic fade-in-up transitions
- [ ] Component shapes and interactions are NOT all default patterns (rounded cards + shadow hover)

## Aesthetic Quality Check

- [ ] Typography hierarchy is clear with sufficient contrast (weight AND size jumps)
- [ ] Color palette has a clear dominant + accent relationship
- [ ] At least one high-impact animation moment exists (page load, state transition, or interaction)
- [ ] Background has depth or texture (not plain white/gray/black)
- [ ] Visual personality is consistent — all elements reinforce the same aesthetic direction
- [ ] Design has at least one element of surprise or delight

## Technical Quality Check

- [ ] Responsive design works across mobile, tablet, and desktop
- [ ] Touch targets are minimum 44x44px on mobile
- [ ] Color contrast meets WCAG AA (4.5:1 for normal text, 3:1 for large text)
- [ ] `prefers-reduced-motion` media query is implemented
- [ ] Images have alt text
- [ ] Semantic HTML elements are used (nav, main, section, article, etc.)
- [ ] No layout shifts on load (CLS consideration)
- [ ] Fonts are loaded efficiently (preload, font-display: swap)
- [ ] Animations use transform/opacity for GPU acceleration (not top/left/width/height)
