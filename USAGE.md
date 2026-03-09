# 🎮 Usage Guide

HELIX commands are designed to be intuitive but powerful. 

## 🛠️ Core Commands

### `/helix:init [prompt]`
Starts the main orchestration loop. 
**Example:** `/helix:init "Refactor the entire auth module to use NextAuth v5 and add magic links."`

### `/helix:status`
Outputs a real-time dashboard of the current Swarm Execution. Shows active parallel jobs, token usage, and predicted costs.

### `/helix:evolve`
Forces the Level 5 Evolver to run immediately. It will analyze your recent git history and update `.helix/learned_rules.md`.
**Example:** `/helix:evolve` (Run this after you manually fix a bug you wish HELIX had caught).

### `/helix:predict [prompt]`
A "dry run". The Meta-Planner will break down the task and give you a cost and time estimate without actually writing code.
**Example:** `/helix:predict "Migrate from SQLite to PostgreSQL"`

---

## 🌟 Real-World Examples

### 1. The "Zero-to-SaaS" Build
```bash
/helix:init "Build a minimalist task management SaaS. Use Next.js App Router, Tailwind, Shadcn UI, and Supabase. Implement email auth, a dashboard, and a Stripe checkout page. Ensure all components are accessible."
```
*HELIX will spawn 3-4 swarm agents to tackle UI, Auth, DB, and Payments concurrently.*

### 2. The Massive Legacy Refactor
```bash
/helix:init "Analyze the /src/legacy folder. Convert all class components to functional components with React Hooks. Maintain exact visual parity and ensure all existing Jest tests pass."
```
*HELIX will use the Loop-Manager to batch process files, verifying each with the Validator before moving to the next.*

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
2. **Use Predictions:** For huge tasks, run `/helix:predict` first to ensure the Meta-Planner's blueprint makes sense.
3. **Let it Learn:** Don't micromanage the prompts. Let the Evolver optimize the internal prompts for you over time.
