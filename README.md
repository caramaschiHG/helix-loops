<div align="center">

<pre>
██╗  ██╗ ███████╗ ██╗      ██╗ ██╗  ██╗
██║  ██║ ██╔════╝ ██║      ██║ ╚██╗██╔╝
███████║ █████╗   ██║      ██║  ╚███╔╝ 
██╔══██║ ██╔══╝   ██║      ██║  ██╔██╗ 
██║  ██║ ███████╗ ███████╗ ██║ ██╔╝ ██╗
╚═╝  ╚═╝ ╚══════╝ ╚══════╝ ╚═╝ ╚═╝  ╚═╝

</pre>

**Hierarchical Evolutionary Loop for Intelligent eXecution**

[![GitHub stars](https://img.shields.io/github/stars/caramaschiHG/helix-loops?style=for-the-badge&color=ffd700)](https://github.com/caramaschiHG/helix-loops/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Version 2.0.0](https://img.shields.io/badge/version-2.0.0-success?style=for-the-badge)](https://github.com/caramaschiHG/helix-loops/releases)
[![Compatible with: Claude Code & Gemini CLI](https://img.shields.io/badge/Compatible-Claude_Code_%7C_Gemini_CLI-blueviolet?style=for-the-badge&logo=anthropic)](https://github.com/caramaschiHG/helix-loops)
[![MCP Native Support](https://img.shields.io/badge/MCP-Native_Support-orange?style=for-the-badge)](https://modelcontextprotocol.io)

*Stop writing static prompts. Start building with an orchestrator that learns.*

</div>

---

Welcome to the next generation of autonomous AI agents. If you've used **GSD** or **Ralph Loops**, you know the immense power of autonomous execution. But they share a fatal flaw: **they don't learn.** Every time you start a new loop, you start from zero.

**HELIX v2.0** introduces the **Hierarchical Evolutionary Loop**. It's a 5-level orchestration system that not only executes complex multi-agent tasks but *rewrites its own templates, cost predictors, and style guides* based on how it performs in your specific codebase. 

⚡ **Now featuring native MCP integration, Prompt Caching (-60% cost), Agentic Self-Healing, Context Compression, and a Premium CLI UX.**

---

## 🥊 The Evolution of Loops (Why HELIX?)

| Feature | 🐢 GSD | 🚀 Ralph Loops | 🧬 **HELIX v2.0** |
| :--- | :---: | :---: | :---: |
| **Execution Architecture** | Sequential | Parallel Waves | **Hierarchical Swarm** |
| **Self-Evolution** | ❌ No | ❌ No | **✅ Yes (Level 5 Evolver)** |
| **MCP Integration** | ❌ No | ❌ No | **✅ Native Support** |
| **Cost Efficiency** | Standard | Standard | **✅ Prompt Caching Built-in (-60% cost)** |
| **Model Routing** | ❌ Fixed | ❌ Fixed | **✅ Dynamic (Cost vs Quality)** |
| **Style Learning** | ❌ None | ❌ Manual | **✅ Auto-generates `.helix/learned_rules.md`** |
| **Failure Recovery** | ⚠️ Retry | ✅ Checkpoints | **✅ Agentic Self-Healing** |
| **CLI Experience** | Basic | Basic | **✅ Premium Dashboard & Elegant UX** |

---

## ⚡ 10-Second Install

Install directly via your favorite CLI:

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

> **The HELIX Workflow:**
> 1. 🧠 **Meta-Planner:** Analyzes context via Compression and breaks down the task.
> 2. ⚡ **Loop-Manager:** Schedules parallel waves leveraging Prompt Caching.
> 3. 🛠️ **Swarm Execution:** Multiple agents code simultaneously, reading data via MCP tools.
> 4. 🛡️ **Validator:** Tests the code. If it fails, the *Agentic Healer* kicks in autonomously.
> 5. 🔥 **Evolver:** Optimizes future runs based on this exact execution.

---

## 🏗️ Core Architecture (The 5 Levels)

HELIX abandons the traditional loop for a **5-Level Hierarchical Swarm**:

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

*See [ARCHITECTURE.md](./ARCHITECTURE.md) for a deep dive into the swarm mechanics.*

---

## 🔥 The Killer Feature: Self-Evolution (Level 5)

Stop writing `prompt.md` files over and over.

HELIX's **Evolver** runs silently after every successful (or failed) loop. It analyzes its own execution logs, identifies what worked, and **modifies its own internal templates** for your repository. 

After 5 runs in your codebase, HELIX will have perfectly adapted to your exact code style, architectural preferences, and testing frameworks without you typing a single configuration rule.

*Read more in [EVOLVER.md](./EVOLVER.md).*

---

## 💎 Premium CLI Experience

HELIX v2.0 isn't just smart; it's beautiful. We've replaced noisy, scary JSON dumps with an elegant, terminal-native UI. All outputs feature clean borders, minimal elegant emojis, and precise status updates. 

Run `/helix:status` anytime to see a gorgeous real-time dashboard of your swarm's progress and token costs.

---

## 🛠️ Advanced Commands

- `/helix:init [prompt]` - Start a new evolutionary loop.
- `/helix:status` - View current swarm execution state and cost metrics.
- `/helix:evolve` - Force the Evolver to analyze the last 5 commits and update rules.
- `/helix:predict [prompt]` - Simulate a run to get a cost and time estimate.

*Check out [USAGE.md](./USAGE.md) for real-world examples.*

---

## 🗺️ Master Roadmap

We are on a mission to be the undisputed #1 orchestration engine. See our full [ROADMAP.md](./ROADMAP.md) for details.

### Upcoming in v2.1 (Infrastructure Update)
- [ ] Visual Terminal Dashboard (`helix-dashboard`)
- [ ] Isolated Git Worktrees for true multi-agent collision safety *(Beta available in scripts/)*
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
