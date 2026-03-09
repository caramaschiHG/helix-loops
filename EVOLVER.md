# 🔥 The Evolver (Level 5) Deep Dive

Traditional AI loops are static. You write a `rules.md` or a `prompt.txt`, and the agent follows it blindly. Over time, as your codebase shifts, those rules become outdated, leading to context rot and frustrating hallucinations.

HELIX v2.0 solves this permanently with **The Evolver (Level 5)**.

## 🧠 How it Works

The Evolver is an autonomous meta-agent that runs after a task is completed. 

It operates in 3 distinct steps:

1. **Diff Analysis:** It looks at the delta between what the Swarm Execution layer initially proposed and what was finally accepted (including Agentic Healing patches and manual human edits!).
2. **Pattern Recognition:** It identifies recurring anti-patterns, style violations, or inefficient library usage.
3. **Self-Modification:** It physically edits the files inside `.helix/` (like `learned_rules.md`, `templates/`, and `helix.config.json`).

## 🎨 Learning Your Coding Style

If your team prefers `fp-ts` over standard error throwing, but you forgot to put it in the prompt, HELIX might use standard `try/catch`. 

If you manually correct this in a PR, the next time the Evolver runs, it will deduce: *"The human replaced my try/catch with Either/TaskEither. I must update my standard TypeScript generation template."*

It will autonomously append to `.helix/learned_rules.md`:
```markdown
- **Error Handling:** ALWAYS use `fp-ts` Either/TaskEither patterns instead of `try/catch`.
```

## 🔄 What gets updated automatically?

1. **Learned Rules:** Project-specific architectural constraints.
2. **Templates:** Swarm execution prompts are honed for your specific context.
3. **Cost-Predictor:** Adjusts estimated token usage based on real-world latency and caching hit rates (Prompt Caching).
4. **Routing Rules:** Dynamically adjusts which model handles which task based on historical success rates.

The orchestrator adapts. HELIX v2.0 gets 1% smarter every single time it runs.