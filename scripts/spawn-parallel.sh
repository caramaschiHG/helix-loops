#!/usr/bin/env bash
# HELIX Parallel Worker Launcher
# Manages background task tracking for parallel wave execution.
# Note: Actual Claude Code agent spawning happens via the Agent tool (run_in_background=true).
# This script tracks worker PIDs and aggregates results from state/workers/.

set -euo pipefail

HELIX_HOME="${HOME}/.claude/skills/helix"
STATE_DIR="${HELIX_HOME}/state"
WORKERS_DIR="${STATE_DIR}/workers"

mkdir -p "$WORKERS_DIR"

MAX_WORKERS="${MAX_WORKERS:-3}"

# ─── Worker Registry ──────────────────────────────────────────────────────────

register_worker() {
  local worker_id="${1}"
  local phase_id="${2}"
  local task_slug="${3}"

  cat > "${WORKERS_DIR}/${worker_id}.json" <<EOF
{
  "worker_id": "$worker_id",
  "phase_id": "$phase_id",
  "task_slug": "$task_slug",
  "branch": "helix/${phase_id}/${task_slug}",
  "status": "RUNNING",
  "started": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "tokens_used": 0
}
EOF
  echo "Worker registered: $worker_id ($phase_id/$task_slug)"
}

update_worker() {
  local worker_id="${1}"
  local status="${2}"
  local tokens="${3:-0}"

  local file="${WORKERS_DIR}/${worker_id}.json"
  if [[ ! -f "$file" ]]; then
    echo "Worker not found: $worker_id"
    return 1
  fi

  jq --arg status "$status" \
     --arg tokens "$tokens" \
     --arg done "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
     '.status = $status | .tokens_used = ($tokens | tonumber) | .completed = $done' \
     "$file" > /tmp/worker-update.json
  mv /tmp/worker-update.json "$file"

  echo "Worker $worker_id → $status (tokens: $tokens)"
}

# ─── Wave Aggregator ──────────────────────────────────────────────────────────

aggregate_wave() {
  local wave_id="${1}"

  echo "Aggregating wave $wave_id results..."

  local total_workers=0
  local done_workers=0
  local failed_workers=0
  local total_tokens=0

  for f in "${WORKERS_DIR}"/*.json; do
    [[ -f "$f" ]] || continue
    local wave
    wave=$(jq -r '.phase_id' "$f" | cut -d- -f2)
    [[ "$wave" == "$wave_id" ]] || continue

    total_workers=$((total_workers + 1))
    local status
    status=$(jq -r '.status' "$f")
    local tokens
    tokens=$(jq -r '.tokens_used // 0' "$f")
    total_tokens=$((total_tokens + tokens))

    case "$status" in
      DONE) done_workers=$((done_workers + 1)) ;;
      FAILED) failed_workers=$((failed_workers + 1)) ;;
    esac
  done

  cat <<EOF
Wave $wave_id Summary:
  Workers total:  $total_workers
  Completed:      $done_workers
  Failed:         $failed_workers
  Tokens used:    $total_tokens
EOF

  if [[ $failed_workers -gt 0 ]]; then
    echo "WAVE_STATUS: FAILED"
    return 1
  else
    echo "WAVE_STATUS: SUCCESS"
    return 0
  fi
}

# ─── Parallelism Gate ─────────────────────────────────────────────────────────

can_spawn() {
  local running=0
  for f in "${WORKERS_DIR}"/*.json; do
    [[ -f "$f" ]] || continue
    local status
    status=$(jq -r '.status' "$f")
    [[ "$status" == "RUNNING" ]] && running=$((running + 1))
  done

  if [[ $running -ge $MAX_WORKERS ]]; then
    echo "Max workers ($MAX_WORKERS) reached. Waiting..."
    return 1
  fi
  return 0
}

wait_for_slot() {
  local max_wait="${1:-600}"  # 10 minutes default
  local elapsed=0

  while ! can_spawn; do
    sleep 5
    elapsed=$((elapsed + 5))
    if [[ $elapsed -ge $max_wait ]]; then
      echo "Timeout waiting for worker slot"
      return 1
    fi
  done
}

# ─── Cleanup ──────────────────────────────────────────────────────────────────

cleanup_wave() {
  local wave_id="${1}"
  echo "Cleaning up worker records for wave $wave_id..."
  for f in "${WORKERS_DIR}"/*.json; do
    [[ -f "$f" ]] || continue
    rm -f "$f"
  done
  echo "Cleanup done."
}

list_workers() {
  echo "Active workers:"
  for f in "${WORKERS_DIR}"/*.json; do
    [[ -f "$f" ]] || continue
    jq -r '"  \(.worker_id) | \(.phase_id)/\(.task_slug) | \(.status)"' "$f"
  done
}

# ─── Main ─────────────────────────────────────────────────────────────────────

main() {
  local cmd="${1:-help}"
  shift || true

  case "$cmd" in
    register)   register_worker "$@" ;;
    update)     update_worker "$@" ;;
    aggregate)  aggregate_wave "$@" ;;
    can-spawn)  can_spawn ;;
    wait-slot)  wait_for_slot "$@" ;;
    cleanup)    cleanup_wave "$@" ;;
    list)       list_workers ;;
    help|--help)
      echo "HELIX Parallel Worker Manager"
      echo ""
      echo "Commands:"
      echo "  register <id> <phase> <task>  Register new worker"
      echo "  update <id> <status> [tokens] Update worker status"
      echo "  aggregate <wave_id>            Aggregate wave results"
      echo "  can-spawn                      Check if slot available"
      echo "  wait-slot [timeout_sec]        Wait for available slot"
      echo "  cleanup <wave_id>              Remove wave worker records"
      echo "  list                           Show active workers"
      ;;
    *) echo "Unknown: $cmd" ;;
  esac
}

main "$@"
