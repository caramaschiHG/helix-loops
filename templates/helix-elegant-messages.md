# HELIX Premium UX Guidelines

These templates define the visual language of HELIX v3.0. The CLI must strictly follow these formats when communicating with the user. The goal is a premium, calm, and highly professional terminal experience.

## 1. Initialization Banner (Triggered on `/helix:init` or `/helix`)

When HELIX starts, output this exact banner:

```text
 ██╗  ██╗  ███████╗  ██╗       ██╗  ██╗  ██╗ 
 ██║  ██║  ██╔════╝  ██║       ██║  ╚██╗██╔╝ 
 ███████║  █████╗    ██║       ██║   ╚███╔╝  
 ██╔══██║  ██╔══╝    ██║       ██║   ██╔██╗  
 ██║  ██║  ███████╗  ███████╗  ██║  ██╔╝ ██╗ 
 ╚═╝  ╚═╝  ╚══════╝  ╚══════╝  ╚═╝  ╚═╝  ╚═╝ 
──────────────────────────────────────────────────────────
 Hierarchical Evolutionary Loop — v3.0
 Ecosystem & Enterprise Update
──────────────────────────────────────────────────────────
 Date: {{DATE}} | Project: {{PROJECT_NAME}}
```

## 2. Standard Workflow Messages

Do not use noisy logs. Use this clean format for all state changes, wave transitions, and major events.

### Phase Transition / Progress
```text
🔄 WAVE {{CURRENT_WAVE}}/{{TOTAL_WAVES}} • {{PHASE_NAME}}
──────────────────────────────────────────────────────────
 {{STATUS_MESSAGE}}
 Context: Compressed to {{COMPRESSION_PERCENT}}% of original size.
 Cost Prediction: ${{COST}} ({{CACHE_PERCENT}}% cached)
 Progress: {{PROGRESS_PERCENT}}% • ETA: {{ETA_MINS}}m {{ETA_SECS}}s
 
 HELIX v3.0 • caramaschiHG
```

### Swarm Execution (Level 3)
```text
🛠️ SWARM EXECUTION • {{PHASE_NAME}}
──────────────────────────────────────────────────────────
 Spawning isolated worktrees...
 ├─ Agent 1 (UI): Running in background
 ├─ Agent 2 (API): Running in background
 └─ Agent 3 (DB): Completed in 45s

 Status: Waiting for remaining agents...
```

### Validator & Agentic Healing (Level 4)
```text
🛡️ VALIDATOR • Integrity Check
──────────────────────────────────────────────────────────
 Running test suite and static analysis...
 ❌ Error detected in `{{FILE_PATH}}` (Type mismatch).
 
 Agentic Healing triggered...
 └─ Micro-agent spawned to resolve issue.
 ✅ Healing successful. Proceeding to merge.
 
 HELIX v3.0 • caramaschiHG
```

### Cost Summary (End of Wave)
```text
💰 WAVE {{CURRENT_WAVE}} FINANCIAL REPORT
──────────────────────────────────────────────────────────
 Budget Ceiling: ${{BUDGET}}
 Spent This Wave: ${{WAVE_SPEND}}
 Total Spent: ${{TOTAL_SPENT}} ({{BUDGET_PERCENT}}% of budget)
 Cache Savings: ${{SAVED_AMOUNT}} saved via Prompt Caching
 
 HELIX v3.0 • caramaschiHG
```

## 3. The Evolver Final Report (Level 5)

When the execution completes, present the evolution report elegantly.

```text
🧠 SELF-EVOLUTION COMPLETE
──────────────────────────────────────────────────────────
 The Evolver has analyzed the recent Swarm execution.
 
 Updates applied to `.helix/`:
 ├─ Learned Rules: Added 2 new architectural constraints.
 ├─ Templates: Optimized React component generation.
 └─ Cost Model: Adjusted prediction multiplier by +0.05.

 HELIX is now permanently smarter for this repository.
 
 HELIX v3.0 • caramaschiHG
```

## 4. Calm Error Handling

When something goes wrong and cannot be healed, do not panic the user. Provide a calm, actionable error state.

```text
⚠️ EXECUTION HALTED • {{ERROR_TYPE}}
──────────────────────────────────────────────────────────
 Issue: {{ERROR_DESCRIPTION}}
 Action Taken: Safe rollback to `{{PREVIOUS_TAG}}`. No files were corrupted.
 
 Recommendation: {{ACTIONABLE_ADVICE}}
 
 HELIX v3.0 • caramaschiHG
```