---
name: helix
description: >
  Hierarchical Evolutionary Loop for Intelligent eXecution. Creates and manages
  hybrid Ralph/GSD/PAUL loops 5-10x more efficient with hierarchical swarm,
  cost prediction, real parallelism, model routing, and self-evolution after
  each execution. Use when the user wants to build complex projects autonomously
  (complete SaaS, large refactor, overnight batch, etc.).
version: 1.0.0
author: caramaschi
triggers:
  - helix
  - /helix
  - /helix:init
  - autonomous build
  - overnight project
  - create loop
---

# HELIX — Hierarchical Evolutionary Loop for Intelligent eXecution

## Purpose

HELIX is a self-improving meta-orchestrator that wraps Ralph, GSD, and PAUL into
a single autonomous execution engine. It routes tasks to the right model, runs
waves of parallel agents, predicts cost before spending, rolls back on failure,
and evolves its own templates after every run.

**Use HELIX when:**
- Building a complete product autonomously (SaaS, CLI tool, full-stack app)
- Executing large refactors across many files/services
- Running overnight batches where human supervision is minimal
- Any task where GSD, PAUL, or Ralph alone are insufficient

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
          │   1. META-PLANNER       │  model: gemini-2.5-flash
          │   Reads context,        │  reads: CLAUDE.md, STATE.md,
          │   emits PhaseGraph      │         ROADMAP.md, git log
          └────────────┬────────────┘
                       │ PhaseGraph (JSON)
          ┌────────────▼────────────┐
          │   2. LOOP-MANAGER       │  model: gemini-2.5-flash
          │   Generates Ralph loop  │  writes: ralph-optimized.md
          │   + GSD phases          │          gsd-phases.xml
          │   + wave schedule       │          wave-schedule.json
          └────────────┬────────────┘
                       │ wave-schedule.json
          ┌────────────▼────────────┐
          │   3. SWARM EXECUTION    │  parallel Claude Code agents
          │   Tier-1: Orchestrators │  model routing per task type
          │   Tier-2: Workers       │  max N workers (default: 3)
          └────────────┬────────────┘
                       │ results + logs
          ┌────────────▼────────────┐
          │   4. VALIDATOR +        │  model: gemini-2.5-flash
          │      OPTIMIZER          │  runs tests, monitors cost,
          │   auto git rollback     │  gates next wave
          └────────────┬────────────┘
                       │ execution-report.json
          ┌────────────▼────────────┐
          │   5. EVOLVER            │  model: gemini-2.5-flash
          │   Patches templates/    │  commits to skill repo
          │   Calibrates predictor  │  updates MEMORY.md
          └─────────────────────────┘
```

---

## Layer 1 — Meta-Planner

The Meta-Planner is a subagent (Sonnet) that runs once at HELIX startup.

### Inputs

- Project goal string from `/helix:init "<goal>"`
- `CLAUDE.md` (if present)
- `.paul/STATE.md` or `.gsd/roadmap.md` (if present)
- `git log --oneline -20` (recent commits)
- `~/.claude/skills/helix/state/current.json` (resume context)

### Outputs — PhaseGraph

```json
{
  "goal": "Create SaaS with auth, Stripe, React dashboard",
  "strategy": "overnight-gsd",
  "phases": [
    {
      "id": "phase-01-scaffold",
      "name": "Project Scaffold",
      "type": "execution",
      "model": "sonnet",
      "depends_on": [],
      "estimated_tokens": 45000,
      "parallelizable": false
    },
    {
      "id": "phase-02-auth",
      "name": "Auth System",
      "type": "critical-code",
      "model": "opus",
      "depends_on": ["phase-01-scaffold"],
      "estimated_tokens": 80000,
      "parallelizable": false
    },
    {
      "id": "phase-03-stripe",
      "name": "Stripe Integration",
      "type": "critical-code",
      "model": "opus",
      "depends_on": ["phase-02-auth"],
      "estimated_tokens": 70000,
      "parallelizable": true
    },
    {
      "id": "phase-03-ui",
      "name": "React Dashboard",
      "type": "execution",
      "model": "sonnet",
      "depends_on": ["phase-01-scaffold"],
      "estimated_tokens": 60000,
      "parallelizable": true
    }
  ],
  "total_estimated_tokens": 255000,
  "total_estimated_cost_usd": 1.53,
  "wave_count": 3
}
```

### Model Routing Rules

| Task type | Model assigned | Rationale |
|---|---|---|
| `planning` | `gemini-2.5-flash` | Fast, cheap for structure |
| `verification` | `gemini-2.5-flash` | Fast, sufficient accuracy |
| `execution` | `gemini-2.5-flash` | Default workhorse |
| `critical-code` | `gemini-2.5-pro` | Auth, payments, security |
| `debugging` | `gemini-2.5-flash` | Systematic debugging skill |
| `evolution` | `gemini-2.5-flash` | Meta-updates stay cheap |

---

## Layer 2 — Loop-Manager

Loop-Manager receives the PhaseGraph and produces three artifacts:

### 2a. Ralph Loop (`templates/ralph-optimized.md`)

```markdown
# HELIX-Generated Ralph Loop
interval: per-phase
max_iterations: {{WAVE_COUNT}}
stop_condition: all_phases_verified OR cost_ceiling_hit OR manual_cancel

on_iteration:
  1. Pop next wave from wave-schedule.json
  2. Spawn Swarm (Layer 3) for that wave
  3. Wait for all workers to report DONE or FAILED
  4. Run Validator (Layer 4)
  5. If FAILED: git rollback to last checkpoint, retry once, then HALT
  6. Write checkpoint to state/current.json
  7. If last wave: trigger Evolver (Layer 5)
```

### 2b. GSD Phases (`templates/gsd-phases.xml`)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<helix-phases goal="{{GOAL}}" generated="{{DATE}}">
  {{#each phases}}
  <phase id="{{id}}" model="{{model}}" wave="{{wave}}">
    <name>{{name}}</name>
    <type>{{type}}</type>
    <skills>
      <skill>gsd:plan-phase</skill>
      <skill>gsd:execute-phase</skill>
      <skill>gsd:verify-work</skill>
    </skills>
    <acceptance-criteria>
      <!-- populated by Meta-Planner per phase -->
    </acceptance-criteria>
    <rollback-tag>helix/{{id}}/pre</rollback-tag>
  </phase>
  {{/each}}
</helix-phases>
```

### 2c. Wave Schedule (`state/wave-schedule.json`)

Groups phases into parallel waves based on dependency graph:

```json
{
  "waves": [
    {
      "wave": 1,
      "phases": ["phase-01-scaffold"],
      "parallel": false
    },
    {
      "wave": 2,
      "phases": ["phase-02-auth"],
      "parallel": false
    },
    {
      "wave": 3,
      "phases": ["phase-03-stripe", "phase-03-ui"],
      "parallel": true,
      "max_workers": 2
    }
  ]
}
```

---

## Layer 3 — Swarm Execution

### Tier 1 — Wave Orchestrators (sequential per wave)

Each wave gets one orchestrator agent that:
1. Reads phase spec from `gsd-phases.xml`
2. Runs `gsd:plan-phase` to generate task breakdown
3. Delegates tasks to Tier-2 workers
4. Aggregates worker results
5. Reports wave status to Loop-Manager

### Tier 2 — Task Workers (parallel within wave)

Workers are spawned via the `Agent` tool with `run_in_background: true`:

```
Agent(
  subagent_type: "gsd-executor",
  prompt: "<task spec + context>",
  run_in_background: true
)
```

**Worker constraints:**
- Max 3 workers simultaneously (configurable, hard cap 6)
- Each worker has a 45-minute timeout
- Workers commit atomically to their own branch (`helix/<phase>/<task>`)
- Worker reports: `{ status: DONE|FAILED, tokens_used, branch, summary }`

### Parallelism Decision Matrix

```
Single dependency chain → sequential workers
Sibling phases, no shared files → parallel workers (N=2-3)
Sibling phases, shared schema → sequential (avoid merge conflicts)
Any phase touching auth/payments → always sequential
```

---

## Layer 4 — Validator + Optimizer

Runs automatically after every wave. Never skipped.

### 4a. Test Gate

```bash
# helix runs these in order, stops on first failure
npm test --passWithNoTests        # unit tests
npm run build                      # type-check + bundle
npx tsc --noEmit                   # strict type gate
git diff --stat HEAD~1             # sanity: something changed
```

If any gate fails:
1. Log failure to `state/failures.json`
2. `git rollback` to pre-wave tag (`helix/<phase>/pre`)
3. Retry the wave once with extra debug context
4. If retry fails: HALT, write `state/halt-reason.md`, emit `<promise>FAILED</promise>`

### 4b. Cost Monitor (real-time)

HELIX tracks token spend against the cost predictor:

```json
{
  "budget_usd": 5.00,
  "spent_usd": 1.23,
  "remaining_usd": 3.77,
  "burn_rate_usd_per_wave": 0.41,
  "waves_remaining": 2,
  "projected_final_usd": 2.05,
  "status": "ON_TRACK"
}
```

**Cost alerts:**
- `projected > budget * 1.2` → WARN, ask user to continue
- `spent > budget` → HALT immediately

### 4c. Git Rollback Protocol

Before each wave, HELIX tags the current state:

```bash
git tag helix/<phase-id>/pre -m "HELIX pre-wave checkpoint"
```

On failure:

```bash
git checkout helix/<phase-id>/pre   # restore state
git tag -d helix/<phase-id>/pre     # clean tag
# log failure, retry or halt
```

---

## Layer 5 — Evolver (Self-Improving Meta-Layer)

Runs once after all waves complete successfully. This is what makes HELIX self-improving.

### 5a. Log Analysis

Evolver reads:
- `state/execution-report.json` — actual vs predicted tokens per phase
- `state/failures.json` — what failed and why
- Worker summaries — which patterns were fast/slow

### 5b. Template Patching

Evolver patches its own skill files:

**`templates/cost-predictor.md`** — recalibrates per-task token estimates:
```
actual_tokens["critical-code"] was 92k, predicted 80k → update multiplier to 1.15x
actual_tokens["execution"] was 38k, predicted 45k → update multiplier to 0.84x
```

**`templates/ralph-optimized.md`** — adjusts wave timing and retry logic based on what failed.

**`templates/gsd-phases.xml`** — adds acceptance criteria patterns that worked well.

### 5c. Evolution Commit

```bash
cd ~/.claude/skills/helix
git add templates/ state/evolution-log-$(date +%Y%m%d).md
git commit -m "helix: auto-evolution after run $(date +%Y%m%d-%H%M)"
```

### 5d. Memory Update

Evolver appends to `~/.claude/projects/memory/helix-patterns.md`:
- What strategy was chosen and why it worked
- Cost calibration updates
- Anti-patterns encountered

---

## Invocation Reference

### `/helix:init` — Start new HELIX run

```
/helix:init "Criar SaaS de agendamento com auth, Stripe e dashboard React"
```

HELIX will:
1. Show cost estimate + strategy, ask confirmation
2. Create `state/current.json` + git tag `helix/start`
3. Launch Meta-Planner → Loop-Manager → Swarm → Validator → Evolver
4. Emit `<promise>DONE</promise>` on success

### `/helix resume` — Continue interrupted run

```
/helix resume
```

Reads `state/current.json`, skips completed waves, continues from checkpoint.

### `/helix dry-run` — Cost estimate only

```
/helix dry-run "Build a REST API with JWT auth"
```

Shows PhaseGraph + cost breakdown, no execution.

### `/helix history` — View evolution log

```
/helix history
```

Lists all evolution commits and calibration changes.

### `/helix status` — Show current run state

```
/helix status
```

Shows waves completed, cost spent, next wave, estimated completion.

### `/helix cancel` — Stop current run safely

```
/helix cancel
```

Finishes current worker, rolls back partial wave, writes halt state.

---

## Configuration

**`~/.claude/skills/helix/helix.config.json`:**

```json
{
  "default_workers": 3,
  "max_workers": 6,
  "cost_ceiling_usd": 10.0,
  "cost_warn_threshold_usd": 5.0,
  "model_routing": {
    "planning": "gemini-2.5-flash",
    "execution": "gemini-2.5-flash",
    "critical_code": "gemini-2.5-pro",
    "verification": "gemini-2.5-flash",
    "evolution": "gemini-2.5-flash"
  },
  "auto_evolve": true,
  "auto_commit_evolution": true,
  "checkpoint_interval": "per_phase",
  "test_gate": true,
  "rollback_on_failure": true,
  "max_retries_per_wave": 1
}
```

---

## Stop Criteria (Ultra-Strict)

HELIX halts immediately (no retry) when:

1. `spent_usd > cost_ceiling_usd`
2. A wave fails its retry and the failure is in a critical path phase
3. `git rollback` itself fails (repo in bad state)
4. User runs `/helix cancel`
5. Any worker produces output violating these rules:
   - Commits directly to `main`/`master`
   - Force-pushes any branch
   - Deletes production data
   - Modifies `helix.config.json` or `SKILL.md` (only Evolver may do this)

On clean success: emits `<promise>DONE</promise>`
On halt: writes `state/halt-reason.md` and emits `<promise>FAILED</promise>`

---

## Safety Guardrails

- Workers never commit to `main`/`master` — always to `helix/<phase>/<task>`
- Evolver is the only layer that may modify skill files
- Cost ceiling is a hard stop, not a warning
- All destructive operations require explicit user confirmation
- `rollback_on_failure: true` is the default and cannot be disabled by workers

---

## Bundled Files

```
~/.claude/skills/helix/
├── SKILL.md                       ← this file
├── helix.config.json              ← user configuration
├── templates/
│   ├── ralph-optimized.md         ← Ralph loop template (auto-evolved)
│   ├── gsd-phases.xml             ← GSD phase template (auto-evolved)
│   └── cost-predictor.md          ← token estimates per task type
├── scripts/
│   ├── helix-orchestrator.sh      ← main entry point
│   └── spawn-parallel.sh          ← parallel worker launcher
├── references/
│   ├── model-routing.md           ← routing decision guide
│   ├── wave-scheduling.md         ← parallelism rules
│   └── evolution-protocol.md      ← how Evolver works in detail
├── assets/
│   └── architecture.svg           ← diagram source
├── evolution/                     ← auto-written after each run
├── state/                         ← runtime state (gitignored locally)
│   ├── current.json
│   ├── wave-schedule.json
│   ├── execution-report.json
│   └── failures.json
```

---

*HELIX v1.0.0 — self-improving, run after run.*
