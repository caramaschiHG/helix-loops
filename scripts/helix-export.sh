#!/usr/bin/env bash
# HELIX Spec Exporter (v3.0) — Universal Multi-Platform Support
# This script exports the HELIX orchestration spec for other AI tools.

set -euo pipefail

# Detect HELIX_HOME
if [[ -d "$(pwd)/.helix" ]]; then
  HELIX_HOME="$(pwd)/.helix"
else
  HELIX_HOME="${HOME}/.claude/skills/helix"
fi

STATE_FILE="${HELIX_HOME}/state/current.json"
EXPORT_FILE="helix.spec.json"

# ─── Export Logic ─────────────────────────────────────────────────────────────

export_spec() {
  if [[ ! -f "$STATE_FILE" ]]; then
    echo "No active HELIX state found to export."
    exit 1
  fi

  echo "Exporting HELIX orchestration spec to $EXPORT_FILE..."
  
  local goal=$(jq -r '.goal' "$STATE_FILE")
  local phase=$(jq -r '.current_phase' "$STATE_FILE")
  
  # Generate a universal spec based on the current state and roadmap
  cat <<EOF > "$EXPORT_FILE"
{
  "version": "3.0.0",
  "project": "helix-orchestrator",
  "goal": "$goal",
  "current_context": {
    "phase": "$phase",
    "status": "ready_for_external_orchestration"
  },
  "adapters": {
    "cursor": {
      "command": "composer:run",
      "steps": ["scaffold", "implement", "verify"]
    },
    "aider": {
      "command": "aider --architect",
      "auto_commit": true
    }
  }
}
EOF

  echo "Universal Spec exported successfully."
}

# ─── Main ─────────────────────────────────────────────────────────────────────

main() {
  local cmd="${1:-help}"
  shift || true

  case "$cmd" in
    generate) export_spec ;;
    help|--help)
      echo "HELIX Spec Exporter v3.0"
      echo ""
      echo "Commands:"
      echo "  generate    Generate helix.spec.json for multi-platform support"
      ;;
    *) echo "Unknown command: $cmd. Try: helix-export.sh help" ;;
  esac
}

main "$@"
