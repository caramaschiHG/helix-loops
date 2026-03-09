#!/usr/bin/env bash
# HELIX Memory Manager (v3.0) — Lightweight JSON-based Semantic Memory
# This script manages persistent memory by storing vectorized summaries (as text) in JSON.

set -euo pipefail

# Detect HELIX_HOME: prefer local .helix directory if it exists, otherwise use global home
if [[ -d "$(pwd)/.helix" ]]; then
  HELIX_HOME="$(pwd)/.helix"
else
  HELIX_HOME="${HOME}/.claude/skills/helix"
fi

MEMORY_FILE="${HELIX_HOME}/state/memory.json"
GLOBAL_MEMORY="${HOME}/.helix/memory.json"

mkdir -p "$(dirname "$MEMORY_FILE")"
mkdir -p "$(dirname "$GLOBAL_MEMORY")"

# ─── Initialization ───────────────────────────────────────────────────────────

init_memory() {
  if [[ ! -f "$MEMORY_FILE" ]]; then
    echo "[]" > "$MEMORY_FILE"
  fi
  if [[ ! -f "$GLOBAL_MEMORY" ]]; then
    echo "[]" > "$GLOBAL_MEMORY"
  fi
}

# ─── Store Memory ─────────────────────────────────────────────────────────────

store_memory() {
  local content="$1"
  local project="${2:-unknown}"
  local source="${3:-manual}"
  local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  local id=$(cat /proc/sys/kernel/random/uuid 2>/dev/null || date +%s%N)

  local entry=$(jq -n \
    --arg id "$id" \
    --arg project "$project" \
    --arg content "$content" \
    --arg source "$source" \
    --arg ts "$timestamp" \
    '{id: $id, project: $project, content: $content, source: $source, timestamp: $ts}')

  # Store in local project memory
  jq ". += [$entry]" "$MEMORY_FILE" > "${MEMORY_FILE}.tmp" && mv "${MEMORY_FILE}.tmp" "$MEMORY_FILE"

  # Store in global user memory
  jq ". += [$entry]" "$GLOBAL_MEMORY" > "${GLOBAL_MEMORY}.tmp" && mv "${GLOBAL_MEMORY}.tmp" "$GLOBAL_MEMORY"

  echo "Memory stored: $id"
}

# ─── Search Memory ────────────────────────────────────────────────────────────

search_memory() {
  local query="$1"
  local limit="${2:-5}"

  echo "Searching memory for: '$query'"
  
  # Since we don't have a real vector DB, we use grep for keywords and 
  # inform the orchestrator that it should use the Agent tool for full semantic search.
  
  local local_results
  local_results=$(jq -r '.[] | "\(.timestamp) [\(.project)] (\(.source)): \(.content)"' "$MEMORY_FILE" | grep -iE "$query" | head -n "$limit" || true)

  local global_results
  global_results=$(jq -r '.[] | "\(.timestamp) [\(.project)] (\(.source)): \(.content)"' "$GLOBAL_MEMORY" | grep -iE "$query" | head -n "$limit" || true)

  if [[ -n "$local_results" ]]; then
    echo "--- Local Project Memory ---"
    echo "$local_results"
  fi

  if [[ -n "$global_results" ]]; then
    echo "--- Global User Memory ---"
    echo "$global_results"
  fi

  if [[ -z "$local_results" && -z "$global_results" ]]; then
    echo "No matching memories found for '$query'."
  fi
}

# ─── Main ─────────────────────────────────────────────────────────────────────

main() {
  local cmd="${1:-help}"
  shift || true

  init_memory

  case "$cmd" in
    store)   store_memory "$@" ;;
    search)  search_memory "$@" ;;
    init)    init_memory ;;
    help|--help)
      echo "HELIX Memory Manager v3.0"
      echo ""
      echo "Commands:"
      echo "  store <content> [project] [source]    Save memory entry"
      echo "  search <query> [limit]                Keyword search across memory"
      echo "  init                                  Initialize memory files"
      ;;
    *) echo "Unknown command: $cmd. Try: helix-memory.sh help" ;;
  esac
}

main "$@"
