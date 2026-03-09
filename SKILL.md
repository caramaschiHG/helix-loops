---
name: helix
description: >
  Hierarchical Evolutionary Loop for Intelligent eXecution. The ultimate
  self-evolving orchestrator for Claude Code and Gemini CLI. Integrates MCP
  native tools, Context Compression, Prompt Caching, and a 5-tier Swarm architecture.
  Use when the user wants to build complex projects autonomously (complete SaaS, large refactor, overnight batch, etc.).
version: 2.0.0
author: caramaschiHG
triggers:
  - helix
  - /helix
  - /helix:init
  - /helix:evolve
  - /helix:status
  - autonomous build
  - overnight project
  - create loop
---

# HELIX v2.0 — Hierarchical Evolutionary Loop for Intelligent eXecution

## Purpose

HELIX is a self-improving meta-orchestrator that wraps Ralph, GSD, and PAUL into
a single autonomous execution engine. It routes tasks to the right model, runs
waves of parallel agents, predicts cost before spending, rolls back on failure,
and **evolves its own templates after every run**.

**New in v2.0:**
- **MCP (Model Context Protocol) Native:** Seamlessly plugs into external databases, GitHub, and custom APIs using MCP servers.
- **Context Compression:** Prevents context rot by dynamically summarizing long-running execution states and storing them in local Vector memory.
- **Prompt Caching:** Built-in support for Claude/Gemini prompt caching, cutting execution costs by up to 60%.
- **Agentic Healing:** The Validator doesn't just block bad code; it attempts autonomous self-healing before failing a wave.

**Use HELIX when:**
- Building a complete product autonomously (SaaS, CLI tool, full-stack app)
- Executing large refactors across many files/services
- Running overnight batches where human supervision is minimal

**Stop using HELIX when:**
- Task takes < 30 minutes — use a single GSD phase instead
- Cost estimate exceeds your hard ceiling and you decline
- Project has no clear acceptance criteria

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     HELIX Orchestrator                      │
│                    /helix:init <goal>                       │
└──────────────────────┬──────────────────────────────────────┘
                       │
          ┌────────────▼────────────┐
          │   1. META-PLANNER       │  model: gemini-2.5-pro / claude-3-7-sonnet
          │   Reads context,        │  reads: CLAUDE.md, STATE.md,
          │   emits PhaseGraph      │         ROADMAP.md, git log
          └────────────┬────────────┘
                       │ PhaseGraph (JSON)
          ┌────────────▼────────────┐
          │   2. LOOP-MANAGER       │  model: gemini-2.5-flash
          │   Context Compression   │  writes: ralph-optimized.md
          │   + Prompt Caching      │          gsd-phases.xml
          │   + wave schedule       │          wave-schedule.json
          └────────────┬────────────┘
                       │ wave-schedule.json
          ┌────────────▼────────────┐
          │   3. SWARM EXECUTION    │  parallel CLI agents
          │   MCP Tool Integration  │  model routing per task type
          │   Tier-1 & Tier-2       │  max N workers (default: 3)
          └────────────┬────────────┘
                       │ results + logs
          ┌────────────▼────────────┐
          │   4. VALIDATOR +        │  model: gemini-2.5-flash
          │      AGENTIC HEALING    │  runs tests, auto-fixes issues,
          │   auto git rollback     │  gates next wave
          └────────────┬────────────┘
                       │ execution-report.json
          ┌────────────▼────────────┐
          │   5. EVOLVER            │  model: gemini-2.5-flash
          │   Patches templates/    │  commits to .helix/learned_rules.md
          │   Calibrates predictor  │  updates project vectors
          └─────────────────────────┘
```

---

## Layer 1 — Meta-Planner (The Brain)

The Meta-Planner is a high-reasoning subagent (Sonnet 3.7 or Gemini 2.5 Pro) that runs once at HELIX startup.

### Outputs — PhaseGraph

It generates a structured PhaseGraph that dictates the rest of the execution:

```json
{
  "goal": "Create SaaS with auth, Stripe, React dashboard",
  "strategy": "overnight-gsd",
  "phases": [
    {
      "id": "phase-01-scaffold",
      "name": "Project Scaffold",
      "type": "execution",
      "model": "flash",
      "depends_on": [],
      "estimated_tokens": 45000,
      "parallelizable": false
    },
    {
      "id": "phase-02-auth",
      "name": "Auth System",
      "type": "critical-code",
      "model": "pro",
      "depends_on": ["phase-01-scaffold"],
      "estimated_tokens": 80000,
      "parallelizable": false
    }
  ],
  "total_estimated_tokens": 125000,
  "total_estimated_cost_usd": 0.85,
  "wave_count": 2
}
```

---

## Layer 2 — Loop-Manager (The Orchestrator)

The Loop-Manager ensures tasks are executed efficiently using **Context Compression**. Instead of passing the entire repo history to every agent, it injects only the relevant `summarized_state.md`. 

### Wave Schedule (`state/wave-schedule.json`)

Groups phases into parallel waves based on dependency graph. 

---

## Layer 3 — Swarm Execution (The Workers)

Workers operate in isolated `git worktrees` or branches, preventing merge conflicts during parallel execution. 

**MCP Integration:** 
Tier-2 Workers automatically bind to available MCP servers (e.g., GitHub MCP to read issues, PostgreSQL MCP to check DB schemas) based on the task type.

---

## Layer 4 — Validator + Agentic Healing

Runs automatically after every wave. Never skipped.

1. **Test Gate:** Runs linters, tests, and type-checks.
2. **Agentic Healing:** If a test fails, the Validator spawns a micro-agent with the error log and the specific file. It gets **1 attempt** to self-heal the code.
3. **Rollback:** If healing fails, it triggers a `git rollback` to the pre-wave tag (`helix/<phase>/pre`).

---

## Layer 5 — Evolver (Self-Improving Meta-Layer)

The crown jewel of HELIX. After every run (success or failure), the Evolver analyzes the delta between the requested task and the final accepted code.

It permanently updates:
1. `.helix/learned_rules.md` - Your architectural and style preferences.
2. `.helix/templates/` - Injects custom prompt templates for future agents.
3. `.helix/helix.config.json` - Adjusts token cost multipliers and preferred models.

---

## Configuration

**`.helix/helix.config.json`:**

```json
{
  "version": "2.0.0",
  "project_name": "helix-initialized-project",
  "execution": {
    "default_model": "claude-3-7-sonnet",
    "fast_model": "gemini-2.5-flash",
    "max_parallel_waves": 5,
    "enable_prompt_caching": true,
    "enable_mcp": true
  },
  "evolver": {
    "enabled": true,
    "auto_update_templates": true,
    "learn_from_git_diffs": true
  },
  "safety": {
    "cost_ceiling_usd": 10.0,
    "auto_healing_retries": 1
  }
}
```

---

*HELIX v2.0.0 — The orchestration engine that learns your code.*