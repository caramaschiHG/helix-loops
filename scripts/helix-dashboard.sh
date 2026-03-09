#!/usr/bin/env bash
# HELIX Visual Dashboard (v2.1)
# Provides a real-time, terminal-based visual dashboard of Swarm Execution, Costs, and Waves.

set -euo pipefail

HELIX_HOME="${HOME}/.claude/skills/helix"
STATE_DIR="${HELIX_HOME}/state"
WORKERS_DIR="${STATE_DIR}/workers"

# Colors & Formatting
ESC=$(printf '\033')
RESET="${ESC}[0m"
BOLD="${ESC}[1m"
DIM="${ESC}[2m"
CYAN="${ESC}[36m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
RED="${ESC}[31m"
MAGENTA="${ESC}[35m"
BLUE="${ESC}[34m"

# Ensure dirs exist
mkdir -p "$WORKERS_DIR"
touch "$STATE_DIR/execution-report.json"

clear_screen() {
  printf "\033c"
}

draw_header() {
  echo -e "${CYAN}${BOLD}"
  echo "  ██╗  ██╗  ███████╗  ██╗       ██╗  ██╗  ██╗"
  echo "  ██║  ██║  ██╔════╝  ██║       ██║  ╚██╗██╔╝"
  echo "  ███████║  █████╗    ██║       ██║   ╚███╔╝ "
  echo "  ██╔══██║  ██╔══╝    ██║       ██║   ██╔██╗ "
  echo "  ██║  ██║  ███████╗  ███████╗  ██║  ██╔╝ ██╗"
  echo "  ╚═╝  ╚═╝  ╚══════╝  ╚══════╝  ╚═╝  ╚═╝  ╚═╝ v3.0"
  echo -e "${RESET}${DIM}  Hierarchical Evolutionary Loop — Ecosystem & Enterprise${RESET}"
  echo ""
}

draw_metrics() {
  # Mock metrics reading - in reality, parse from execution-report.json
  local cost_ceiling="10.00"
  local cost_spent="1.45"
  local tokens="128,450"
  local cached="65%"
  local wave="2/5"
  
  echo -e "${BOLD}📊 SWARM METRICS${RESET}"
  echo -e " ├─ ${YELLOW}Wave:${RESET}        $wave"
  echo -e " ├─ ${GREEN}Spend:${RESET}       \$${cost_spent} / \$${cost_ceiling}"
  echo -e " ├─ ${CYAN}Tokens:${RESET}      $tokens"
  echo -e " └─ ${MAGENTA}Cache Hit:${RESET}   $cached (Prompt Caching Active)"
  echo ""
}

draw_workers() {
  echo -e "${BOLD}🐝 ACTIVE SWARM WORKERS (Isolated Worktrees)${RESET}"
  
  local count=0
  if [[ -d "$WORKERS_DIR" ]]; then
    for f in "$WORKERS_DIR"/*.json; do
      [[ -f "$f" ]] || continue
      count=$((count + 1))
      
      local id phase task status tokens branch
      id=$(jq -r '.worker_id // "unk"' "$f" 2>/dev/null || echo "unk")
      task=$(jq -r '.task_slug // "unk"' "$f" 2>/dev/null || echo "unk")
      status=$(jq -r '.status // "unk"' "$f" 2>/dev/null || echo "unk")
      tokens=$(jq -r '.tokens_used // "0"' "$f" 2>/dev/null || echo "0")
      branch="helix/w2/${task}"

      local stat_color=$CYAN
      if [[ "$status" == "DONE" ]]; then stat_color=$GREEN; fi
      if [[ "$status" == "FAILED" ]]; then stat_color=$RED; fi
      if [[ "$status" == "HEALING" ]]; then stat_color=$YELLOW; fi

      echo -e " ${BLUE}▶${RESET} [${stat_color}${status}${RESET}] ${BOLD}${task}${RESET} (PID: $id)"
      echo -e "    ${DIM}Branch: $branch | Tokens: $tokens${RESET}"
    done
  fi

  if [[ $count -eq 0 ]]; then
    echo -e "    ${DIM}No active workers. Waiting for Meta-Planner...${RESET}"
  fi
  echo ""
}

draw_logs() {
  echo -e "${BOLD}📋 ORCHESTRATOR LOGS${RESET}"
  # Just mock tailing logs for the dashboard layout
  echo -e " ${DIM}[10:30:12] Meta-Planner finalized PhaseGraph...${RESET}"
  echo -e " ${DIM}[10:30:15] Loop-Manager triggered Wave 2 (parallel: 3)${RESET}"
  echo -e " ${DIM}[10:30:17] Swarm spawned worker: auth-provider (Isolated Worktree)${RESET}"
  echo -e " ${DIM}[10:31:02] Validator auto-healing triggered for DB schema type mismatch.${RESET}"
  echo ""
}

main_loop() {
  while true; do
    clear_screen
    draw_header
    draw_metrics
    draw_workers
    draw_logs
    
    echo -e "${DIM}Press [Ctrl+C] to exit dashboard. Execution will continue in background.${RESET}"
    sleep 2
  done
}

main_loop