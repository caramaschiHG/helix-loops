# HELIX Cost Predictor
# Auto-calibrated by Evolver after each run.
# Do not edit manually — values are updated by the evolution engine.

## Token Estimates by Task Type

These are baseline estimates used by Meta-Planner to generate the cost forecast.
Evolver multiplies each by its calibration factor after each run.

| Task type | Base tokens | Calibration factor | Effective estimate |
|-----------|------------|-------------------|-------------------|
| planning (sonnet) | 15,000 | 1.00 | 15,000 |
| execution (sonnet) | 40,000 | 1.00 | 40,000 |
| critical-code (opus) | 80,000 | 1.00 | 80,000 |
| verification (sonnet) | 10,000 | 1.00 | 10,000 |
| debugging (sonnet) | 25,000 | 1.00 | 25,000 |
| evolution (sonnet) | 8,000 | 1.00 | 8,000 |

## Pricing Reference (as of 2026-03-09)

```
gemini-2.5-flash:
  input:  $3.00 / 1M tokens
  output: $15.00 / 1M tokens
  blended estimate: ~$6.00 / 1M (60% input, 40% output)

gemini-2.5-pro:
  input:  $15.00 / 1M tokens
  output: $75.00 / 1M tokens
  blended estimate: ~$39.00 / 1M (60% input, 40% output)
```

## Cost Formula

```
cost_per_phase = (estimated_tokens / 1_000_000) * blended_price[model]
total_estimated = sum(cost_per_phase for all phases)
warn_threshold = helix.config.json["cost_warn_threshold_usd"]
hard_ceiling   = helix.config.json["cost_ceiling_usd"]
```

## Calibration History

Evolver appends a row here after each run. Over time the factors converge to
accurate predictions for each project type.

| Date | Run ID | Task type | Predicted | Actual | New factor |
|------|--------|-----------|-----------|--------|------------|
| 2026-03-09 | baseline | all | — | — | 1.00 |

<!-- Evolver auto-appends rows -->

## Alert Thresholds

```
projected_cost > warn_threshold * 0.8  → advisory (show in status)
projected_cost > warn_threshold        → WARN, ask user to continue
spent_cost     > hard_ceiling          → HALT immediately, no retry
```
