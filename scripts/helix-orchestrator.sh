#!/usr/bin/env bash
# HELIX Orchestrator — main entry point
# Called by Claude Code when user invokes /helix or /helix:init
# This script manages state, git hooks, and cost monitoring.
# NOTE: Actual agent spawning happens via Claude Code's Agent tool, not shell.

set -euo pipefail

HELIX_HOME="${HOME}/.claude/skills/helix"
STATE_DIR="${HELIX_HOME}/state"
CONFIG="${HELIX_HOME}/helix.config.json"

# Load config with defaults
MAX_WORKERS=$(jq -r '.max_workers // 3' "$CONFIG" 2>/dev/null || echo 3)
COST_CEILING=$(jq -r '.cost_ceiling_usd // 10.0' "$CONFIG" 2>/dev/null || echo 10.0)
WARN_THRESHOLD=$(jq -r '.cost_warn_threshold_usd // 5.0' "$CONFIG" 2>/dev/null || echo 5.0)
AUTO_EVOLVE=$(jq -r '.auto_evolve // true' "$CONFIG" 2>/dev/null || echo true)

# ─── Subcommands ──────────────────────────────────────────────────────────────

cmd_init() {
  local goal="${1:-}"
  if [[ -z "$goal" ]]; then
    echo "Usage: /helix:init \"<project goal>\""
    exit 1
  fi

  echo "HELIX v1.0.0 — initializing"
  echo "Goal: $goal"

  mkdir -p "$STATE_DIR"

  # Write initial state
  cat > "${STATE_DIR}/current.json" <<EOF
{
  "goal": "$goal",
  "started": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "strategy": null,
  "phases_total": 0,
  "phases_done": 0,
  "waves_done": 0,
  "cost_spent_usd": 0,
  "status": "INITIALIZING"
}
EOF

  # Git safety tag
  git tag "helix/start" -m "HELIX run start: $goal" 2>/dev/null || true

  echo "State initialized at ${STATE_DIR}/current.json"
  echo "Handing control to Meta-Planner subagent..."
  # Claude Code agent orchestration continues from here via Skill instructions
}

cmd_resume() {
  if [[ ! -f "${STATE_DIR}/current.json" ]]; then
    echo "No active HELIX run found. Use /helix:init to start one."
    exit 1
  fi

  local status
  status=$(jq -r '.status' "${STATE_DIR}/current.json")
  local goal
  goal=$(jq -r '.goal' "${STATE_DIR}/current.json")
  local waves_done
  waves_done=$(jq -r '.waves_done' "${STATE_DIR}/current.json")

  echo "Resuming HELIX run"
  echo "Goal: $goal"
  echo "Status: $status"
  echo "Waves completed: $waves_done"
  echo "Continuing from checkpoint..."
}

cmd_status() {
  if [[ ! -f "${STATE_DIR}/current.json" ]]; then
    echo "No active HELIX run."
    exit 0
  fi

  jq '.' "${STATE_DIR}/current.json"

  local report="${STATE_DIR}/execution-report.json"
  if [[ -f "$report" ]]; then
    echo ""
    echo "Cost monitor:"
    jq '{spent_usd, remaining_usd, status}' "$report"
  fi
}

cmd_cancel() {
  echo "Cancelling HELIX run..."
  if [[ -f "${STATE_DIR}/current.json" ]]; then
    jq '.status = "CANCELLED"' "${STATE_DIR}/current.json" > /tmp/helix-state.json
    mv /tmp/helix-state.json "${STATE_DIR}/current.json"
  fi
  echo "HELIX cancelled. Last checkpoint preserved."
}

cmd_history() {
  echo "HELIX Evolution History:"
  echo ""
  if [[ -d "${HELIX_HOME}/evolution" ]]; then
    ls -lt "${HELIX_HOME}/evolution"/*.md 2>/dev/null | head -20 || echo "(no evolution logs yet)"
  fi
  echo ""
  echo "Cost calibration history (from templates/cost-predictor.md):"
  grep -A 3 "Calibration History" "${HELIX_HOME}/templates/cost-predictor.md" 2>/dev/null || true
}

cmd_dry_run() {
  local goal="${1:-}"
  echo "HELIX dry-run (no execution)"
  echo "Goal: $goal"
  echo ""
  echo "This would spawn Meta-Planner → produce PhaseGraph → show cost estimate"
  echo "No agents will be spawned. No git changes made."
  echo ""
  echo "Run /helix:init \"$goal\" to execute."
}

cmd_rollback() {
  local phase="${1:-}"
  local tag="helix/${phase}/pre"

  if git rev-parse "$tag" >/dev/null 2>&1; then
    echo "Rolling back to: $tag"
    git checkout "$tag"
    echo "Rollback complete."
  else
    echo "Tag not found: $tag"
    echo "Available HELIX tags:"
    git tag | grep "^helix/" | sort
    exit 1
  fi
}

cmd_checkpoint() {
  local phase="${1:-}"
  local tag="helix/${phase}/pre"
  git tag "$tag" -m "HELIX pre-phase checkpoint" 2>/dev/null && \
    echo "Checkpoint created: $tag" || \
    echo "Tag already exists: $tag"
}

# ─── Cost Hook ────────────────────────────────────────────────────────────────

check_cost() {
  local report="${STATE_DIR}/execution-report.json"
  if [[ ! -f "$report" ]]; then return; fi

  local spent
  spent=$(jq -r '.spent_usd // 0' "$report")

  # bc comparison
  if (( $(echo "$spent > $COST_CEILING" | bc -l) )); then
    echo "HELIX HALT: cost ceiling exceeded ($spent > $COST_CEILING)"
    cmd_cancel
    exit 2
  fi

  if (( $(echo "$spent > $WARN_THRESHOLD" | bc -l) )); then
    echo "HELIX WARNING: cost threshold reached ($spent > $WARN_THRESHOLD)"
    echo "Continue? [y/N]"
    read -r answer
    if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
      cmd_cancel
      exit 3
    fi
  fi
}

# ─── Main ─────────────────────────────────────────────────────────────────────

main() {
  local cmd="${1:-help}"
  shift || true

  check_cost

  case "$cmd" in
    init)        cmd_init "$@" ;;
    resume)      cmd_resume ;;
    status)      cmd_status ;;
    cancel)      cmd_cancel ;;
    history)     cmd_history ;;
    dry-run)     cmd_dry_run "$@" ;;
    rollback)    cmd_rollback "$@" ;;
    checkpoint)  cmd_checkpoint "$@" ;;
    help|--help)
      echo "HELIX Orchestrator v1.0.0"
      echo ""
      echo "Commands:"
      echo "  init <goal>      Start new run"
      echo "  resume           Continue from checkpoint"
      echo "  status           Show current run state"
      echo "  cancel           Stop safely"
      echo "  dry-run <goal>   Cost estimate only"
      echo "  history          Show evolution logs"
      echo "  rollback <phase> Git rollback to pre-phase tag"
      echo "  checkpoint <id>  Create git checkpoint tag"
      ;;
    *) echo "Unknown command: $cmd. Try: helix-orchestrator.sh help" ;;
  esac
}

main "$@"
