# 🔥 The Evolver (Level 5) Deep Dive

Traditional AI loops are static. You write a `rules.md` or a `prompt.txt`, and the agent follows it blindly. Over time, as your codebase shifts, those rules become outdated, leading to context rot and frustrating hallucinations.

HELIX solves this with **The Evolver (Level 5)**.

## 🧠 How it Works

The Evolver is an autonomous meta-agent that runs after a task is completed (specifically, after code is merged by the Validator). 

It operates in 3 steps:

1. **Diff Analysis:** It looks at the delta between what the Swarm Execution layer initially proposed and what was finally accepted (including manual human edits!).
2. **Pattern Recognition:** It identifies recurring anti-patterns, style violations, or inefficient library usage.
3. **Self-Modification:** It physically edits the files inside `.helix/` (like `learned_rules.md`, `style_guide.md`, and `cost_predictor.json`).

## 🎨 Learning Your Coding Style

If your team prefers `fp-ts` over standard error throwing, but you forgot to put it in the prompt, HELIX might use standard `try/catch`. 

If you manually correct this in a PR, the next time the Evolver runs, it will deduce: *"The human replaced my try/catch with Either/TaskEither. I must update my standard TypeScript generation template."*

It will autonomously append to `.helix/learned_rules.md`:
```markdown
- **Error Handling:** ALWAYS use `fp-ts` Either/TaskEither patterns instead of `try/catch`.
```

## 🔄 What gets updated automatically?

1. **Templates:** Prompt injections used by the Swarm Execution agents.
2. **Cost-Predictor:** Adjusts estimated token usage based on real-world latency and token counts from your specific API keys.
3. **Routing Rules:** If `flash` models consistently fail at complex SQL queries in your repo, the Evolver will update the routing table to always use a `pro` or `sonnet` model for database tasks.

## 📈 Example: Evolution After 5 Runs

**Run 1:** HELIX builds a UI component but uses standard CSS. Human corrects to Tailwind.
**Run 2:** HELIX uses Tailwind, but uses v3 syntax. Human corrects to v4.
**Run 3:** HELIX uses Tailwind v4 perfectly. Human is happy.
**Run 4 & 5:** HELIX consistently applies Tailwind v4 with perfect accuracy, zero human intervention.

*The loop isn't just executing; it's adapting.*
