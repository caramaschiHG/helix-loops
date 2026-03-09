# 🎮 Usage Guide (HELIX v2.0)

HELIX commands are designed to be elegant, intuitive, and immensely powerful. 

## 🛠️ Core Commands

### `/helix:init [prompt]`
Starts the main orchestration loop with full Premium UX. 
**Example:** `/helix:init "Refactor the entire auth module to use NextAuth v5 and add magic links."`

### `/helix:status`
Outputs a real-time, elegant terminal dashboard of the current Swarm Execution. Shows active parallel jobs in isolated git worktrees, token usage, Prompt Caching savings, and Agentic Healing status.

### `/helix:evolve`
Forces the Level 5 Evolver to run immediately. It will analyze your recent git history and update `.helix/learned_rules.md`.
**Example:** `/helix:evolve` (Run this after you manually fix a bug you wish HELIX had caught).

### `/helix:predict [prompt]`
A "dry run". The Meta-Planner will break down the task, utilize Context Compression, and give you a cost and time estimate without actually writing code.

---

## 🌟 Real-World Examples

### 1. The "Zero-to-SaaS" Build
```bash
/helix:init "Build a minimalist task management SaaS. Use Next.js App Router, Tailwind, Shadcn UI, and Supabase. Implement email auth, a dashboard, and a Stripe checkout page. Ensure all components are accessible."
```
*HELIX will spawn 3-4 swarm agents to tackle UI, Auth, DB, and Payments concurrently in isolated worktrees, querying Supabase schemas via MCP if available.*

### 2. The Massive Legacy Refactor
```bash
/helix:init "Analyze the /src/legacy folder. Convert all class components to functional components with React Hooks. Maintain exact visual parity and ensure all existing Jest tests pass."
```
*HELIX uses Context Compression to understand the old logic, batches the files, and uses Agentic Healing if any Jest tests break during the refactor.*

### 3. Training the Evolver
You notice HELIX keeps using `margin-top: 1rem` instead of your team's preferred Tailwind class `mt-4`.
Instead of modifying a prompt, just fix it in code, commit it, and run:
```bash
/helix:evolve
```
HELIX will notice the change, update its style templates, and never make that mistake again.

---

## 💡 Best Practices

1. **Commit Often:** The Evolver learns best from clear git diffs.
2. **Embrace MCP:** If you have database schemas or external API docs, configure them via MCP. The Swarm Execution layer natively reads them.
3. **Let the Healer Work:** If tests fail, don't interrupt immediately. The Agentic Healer will attempt an autonomous patch.