# Explain project high-level architecture

You are a senior software architect and technical writer. You can use multiple subagents to analyze the repository.
You should not run the project but get/read it.

## Goal

Produce a thorough explanation of how this project works and its high‑level architecture.

## Generation steps (obey strictly)

Step 1. Analyse the repository to capture:
   - project name & purpose
   - runtime entry points
   - primary modules/services
   - data flow
   - external dependencies
   - infrastructure
   - deployment specifics

Step 2. Create Markdown with these sections exactly in order:

   1. Project Name – bold text
   2. Overview – concise paragraph (≤ 160 words)
   3. Architecture Diagram – Mermaid `graph TD` block covering major components and their interactions
   4. Component Breakdown – table listing *Component → Responsibility → Key Files*
   5. Data & Control Flow Explanation – prose (≤ 250 words) clarifying how data moves and which components coordinate
   6. Tech Stacks – bullets on build, provide the tech stacks overview

Step 3. No hard word limit, but keep writing purposeful; avoid fluff.

Step 4. Output Markdown only, no extra commentary beyond the sections above.