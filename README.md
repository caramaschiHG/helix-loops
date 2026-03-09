<div align="center">

# 🧬 HELIX v2.0

**The First Self-Evolving AI Skill for Claude Code and Gemini CLI**

[![GitHub stars](https://img.shields.io/github/stars/caramaschiHG/helix-loops?style=for-the-badge&color=yellow)](https://github.com/caramaschiHG/helix-loops/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-2.0.0-success?style=for-the-badge)](https://github.com/caramaschiHG/helix-loops/releases)
[![Compatible with: Claude Code & Gemini CLI](https://img.shields.io/badge/Compatible-Claude_Code_%7C_Gemini_CLI-blueviolet?style=for-the-badge&logo=anthropic)](https://github.com/caramaschiHG/helix-loops)
[![MCP Ready](https://img.shields.io/badge/MCP-Native_Support-orange?style=for-the-badge)](https://modelcontextprotocol.io)

</div>

Welcome to the next generation of autonomous AI agents. If you've used GSD or Ralph Loops, you know the power of autonomous execution. But they share a fatal flaw: **they don't learn.**

**HELIX v2.0** introduces the **Hierarchical Evolutionary Loop for Intelligent eXecution**. It's a 5-level orchestration system that not only executes complex multi-agent tasks but *rewrites its own templates, cost predictors, and style guides* based on how it performs in your specific codebase. 

⚡ **v2.0 introduces native MCP integration, Prompt Caching, Agentic Healing, and Context Compression.**

---

## 🥊 Why HELIX? (The Evolution of Loops)

| Feature | 🐢 GSD | 🚀 Ralph Loops | 🧬 **HELIX v2.0** |
| :--- | :---: | :---: | :---: |
| **Execution Style** | Sequential | Parallel Waves | **Hierarchical Swarm** |
| **Self-Evolution** | ❌ No | ❌ No | **✅ Yes (Level 5 Evolver)** |
| **MCP Integration** | ❌ No | ❌ No | **✅ Native Support** |
| **Cost Efficiency** | Standard | Standard | **✅ Prompt Caching Built-in** |
| **Model Routing** | ❌ Fixed | ❌ Fixed | **✅ Dynamic (Cost vs Quality)** |
| **Style Learning** | ❌ None | ❌ Manual | **✅ Auto-generates `.helix/learned_rules.md`** |
| **Failure Recovery** | ⚠️ Retry | ✅ Checkpoints | **✅ Agentic Self-Healing** |

---

## ⚡ 10-Second Install

Install directly via your favorite CLI (make sure you have the latest versions):

**For Gemini CLI:**
```bash
gemini skill install github:caramaschiHG/helix-loops
```

**For Claude Code:**
```bash
claude-code install caramaschiHG/helix-loops
```

---

## 🚀 Quick Start

Initialize HELIX in your project and watch it build a full SaaS prototype in one prompt:

```bash
/helix:init "Build a full-stack Next.js SaaS with Stripe billing and Supabase auth"
```

HELIX will:
1. Spin up the **Meta-Planner** to break down the task.
2. Route tasks to the **Swarm Execution** layer (now with Prompt Caching!).
3. Use the **Loop-Manager** to parallelize the work.
4. Run the **Validator+Optimizer** to ensure quality (with Auto-Healing).
5. Trigger the **Evolver** to optimize future runs based on this execution.

---

## 🏗️ Core Architecture

HELIX operates on a 5-Level Hierarchical Swarm architecture:

```ascii
[ Level 1: Meta-Planner ]  --> Plans the holistic system and routes tasks.
          |
          v
[ Level 2: Loop-Manager ]  --> Orchestrates parallel execution waves with Context Compression.
          |
          v
[ Level 3: Swarm Execution] -> Does the actual coding via MCP and specific tools.
          |
          v
[ Level 4: Validator ]     --> Tests, lints, checks architectural integrity, and Auto-Heals.
          |
          v
[ Level 5: The Evolver ]   --> 🔥 The Magic: Rewrites its own rules for the next run.
```

*See [ARCHITECTURE.md](./ARCHITECTURE.md) for a deep dive into the swarm.*

---

## 🔥 The Killer Feature: Self-Evolution (Level 5)

Stop writing `prompt.md` files over and over.

HELIX's **Evolver** runs silently after every successful (or failed) loop. It analyzes its own execution logs, identifies what worked, and **modifies its own internal templates** for your repository. 

After 5 runs in your codebase, HELIX will have perfectly adapted to your exact code style, architectural preferences, and testing frameworks without you typing a single configuration rule.

*Read more in [EVOLVER.md](./EVOLVER.md).*

---

## 🛠️ Advanced Commands

- `/helix:init [prompt]` - Start a new evolutionary loop.
- `/helix:status` - View current swarm execution state and cost metrics.
- `/helix:evolve` - Force the Evolver to analyze the last 5 commits and update rules.
- `/helix:predict [prompt]` - Simulate a run to get a cost and time estimate.

*Check out [USAGE.md](./USAGE.md) for real-world examples.*

---

## 🎥 Demo

*Watch how HELIX builds a 10-page SaaS app and then rewrites its own coding style guide based on the output.*

[![HELIX 60s Demo Placeholder](https://img.shields.io/badge/Watch_Demo-Coming_Soon-red?style=for-the-badge&logo=youtube)](#) *(60s Loom coming soon)*

---

## 🗺️ Master Roadmap

We are aiming to be the undisputed #1 orchestration engine. See our full [ROADMAP.md](./ROADMAP.md) for details on how we are beating Conductor, Loki, and Superpowers.

### Upcoming in v2.1 (Infrastructure Update)
- [ ] Visual Terminal Dashboard (`helix-dashboard`)
- [ ] Isolated Git Worktrees for true multi-agent collision safety
- [ ] Advanced Hooks & Total Auto-Activation
- [ ] Centralized Observability & Logging (`helix-logs`)

### Upcoming in v3.0 (Ecosystem Update)
- [ ] Persistent Vector DB Memory (Cross-Session)
- [ ] Embedded Specialized Sub-Skills (TDD, Debugger, Reviewer)
- [ ] Auto PR Creation + Adversarial Review
- [ ] Universal Support (Cursor, Aider, Codex)

---

## 🤝 Contributing & Community

We want to make the smartest loops on the planet. PRs are highly welcome, and ironically, our Level 5 Evolver will learn from the PRs you submit!

Check out [CONTRIBUTING.md](./CONTRIBUTING.md) to get started.

---

<div align="center">
  <i>Made for people tired of dumb loops. Created by <a href="https://github.com/caramaschiHG">@caramaschiHG</a>.</i>
</div>