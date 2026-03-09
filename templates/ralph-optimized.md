# HELIX Ralph Loop Template
# Auto-evolved by Evolver after each run. Do not edit manually.
# Last calibrated: 2026-03-09

## Loop Configuration

```
interval: per-wave
max_iterations: {{WAVE_COUNT}}
timeout_per_wave_minutes: 90
stop_conditions:
  - all_phases_verified
  - cost_ceiling_hit
  - manual_cancel
  - critical_failure_no_retry
```

## Per-Iteration Protocol

```
iteration_start:
  1. Read state/current.json → get next_wave index
  2. Read state/wave-schedule.json → get phases in this wave
  3. Emit: "HELIX wave {{N}}/{{TOTAL}} starting: {{phase_names}}"

execution:
  4. For each phase in wave (parallel if wave.parallel == true):
     a. git tag helix/{{phase_id}}/pre
     b. Spawn gsd-executor agent (background if parallel)
     c. Monitor: check token spend every 5 minutes
  5. Wait for all agents: TaskOutput polling

validation:
  6. Run test gate (npm test, npm run build, tsc --noEmit)
  7. Update cost monitor → state/execution-report.json
  8. If FAILED: rollback → retry once → if still FAILED: HALT

checkpoint:
  9. Write state/current.json with updated wave index
  10. git tag helix/wave-{{N}}/done

iteration_end:
  11. If last wave: trigger Evolver
  12. Else: continue to next wave
```

## Retry Logic

```
max_retries_per_wave: 1
retry_strategy: add_debug_context
on_retry_inject:
  - "Previous attempt failed. Failure log: {{failure_summary}}"
  - "Focus on: {{failed_files}}"
  - "Do not repeat: {{failed_patterns}}"
```

## Calibration History

| Date | Strategy | Predicted tokens | Actual tokens | Delta |
|------|----------|-----------------|---------------|-------|
| 2026-03-09 | overnight-gsd | baseline | baseline | — |

<!-- Evolver appends rows after each run -->
