# Anti-Convergence Patterns

Thinking frameworks for breaking out of AI-generated design convergence. No code examples — only mental models for making distinctive choices.

## Contents

- What is convergence and why it matters
- The five convergence axes
- Self-verification questions

## What Is Convergence and Why It Matters

**Distributional convergence** happens when Claude defaults to the most common patterns in training data. The result: every AI-generated interface looks like it came from the same designer. Users and designers can instantly identify "AI slop" because the same fonts, colors, layouts, and animations appear repeatedly.

Breaking convergence is not about being weird for the sake of it. It is about making **intentional, context-specific choices** instead of reaching for comfortable defaults.

## The Five Convergence Axes

### 1. Font Convergence

**The problem**: Claude reaches for the same small set of "safe alternative" fonts. Even when avoiding Inter/Roboto, there is a tendency to always pick the same replacements (e.g., Space Grotesk, DM Sans).

**Why it matters**: Typography is the most immediately recognizable element of a design. Repeated font choices across projects are the fastest way to signal "AI-generated."

**Thinking shift**:
- Do NOT maintain a mental "favorites list" of alternative fonts
- For every project, actively search for fonts you have never used before
- Start from the aesthetic direction, not from a font name
- Ask: "What visual quality does this project need?" then find fonts that match
- If a font name comes to mind instantly, it is probably a convergence trap

### 2. Color Convergence

**The problem**: Claude defaults to certain color patterns — purple gradients, blue-gray corporate palettes, or neon-on-dark schemes. Even "creative" choices tend to cluster around the same hues.

**Why it matters**: Color creates the strongest emotional first impression. Recycled palettes make different projects feel identical.

**Thinking shift**:
- Never start with a hex code or a color name in mind
- Start with the source world: "What real-world environment does this aesthetic evoke?"
- Derive colors from that environment, not from a color wheel
- If building a dark theme, find a dark theme that is NOT the typical dark gray. Consider dark greens, dark browns, dark blues
- Ask: "Have I used similar colors recently?" If yes, deliberately choose a different temperature

### 3. Layout Convergence

**The problem**: Claude defaults to the same structural patterns: centered hero, three-column feature grid, testimonial carousel, CTA section, footer. This is "the template layout."

**Why it matters**: Layout is the skeleton of a design. If the skeleton is identical, no amount of font or color changes will make designs look different.

**Thinking shift**:
- Before placing any element, ask: "Where would a template put this?" Then consider putting it somewhere else
- Try one structural surprise per page: an overlapping section, a diagonal divider, a sidebar that is not a sidebar
- Study magazine layouts, poster design, or editorial design for non-web layout inspiration
- Consider: what if the most important content is NOT at the top?
- Break the vertical scroll monotony with horizontal elements, sticky sections, or parallax layers

### 4. Animation Convergence

**The problem**: Claude defaults to the same animations — fade-in-up on scroll, gentle hover scale, smooth opacity transitions. These are fine individually but create a homogeneous feel across projects.

**Why it matters**: Motion defines personality. When every interface moves the same way, they feel the same regardless of visual differences.

**Thinking shift**:
- Match animation character to the aesthetic direction, not to "what looks professional"
- A brutalist site should have abrupt, snappy animations — not smooth ease-in-out
- An elegant site might use very slow, barely perceptible transitions
- Consider: what if the animation is NOT a fade? What about clip-path reveals, blur transitions, color shifts, scale from unexpected origins?
- One distinctive animation is worth more than ten generic ones

### 5. Component Convergence

**The problem**: Claude builds the same component patterns — rounded-corner cards with shadows, pill-shaped buttons, hero sections with gradient text. These are the "component defaults."

**Why it matters**: Components are the building blocks. If every building uses the same bricks, every building looks the same.

**Thinking shift**:
- Question the default shape: why rounded corners? What about sharp corners, irregular shapes, or no visible container at all?
- Question the default feedback: why a shadow on hover? What about a border change, a background shift, a text effect?
- Question the default container: why a card? What about a list, a table, a freeform arrangement, overlapping elements?
- Ask: "What would this component look like if designed by a specific design studio or in a specific era?"

## Self-Verification Questions

Run through these during and after implementation:

### The Convergence Check
- [ ] Could someone identify this as AI-generated by its visual patterns?
- [ ] Have I used any of these fonts in my last 3 projects?
- [ ] Have I used similar colors in my last 3 projects?
- [ ] Is the layout structurally similar to a common template?
- [ ] Do the animations feel generic or personality-driven?

### The Intention Check
- [ ] Can I articulate WHY I chose each font? (Not "it looks good" — why it fits THIS project)
- [ ] Can I articulate WHY I chose each color? (What source world or emotion drove it)
- [ ] Does the layout serve the content, or does the content fill a predetermined layout?
- [ ] Does the animation reinforce the aesthetic direction or just add "polish"?

### The Distinctiveness Check
- [ ] Is there at least one element that would surprise a viewer?
- [ ] Would a human designer be proud of this combination of choices?
- [ ] If I showed this alongside my last 5 designs, would it stand out as different?
- [ ] Does this design have a clear personality that could be described in one sentence?
