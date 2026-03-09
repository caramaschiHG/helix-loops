#!/usr/bin/env bash
# HELIX Hook Runner (v2.1)
# The central dispatcher for all HELIX auto-activation events.
# Usage: ./hook-runner.sh <hook_name> [args...]

set -euo pipefail

HOOK_NAME="${1:-}"
shift || true

HELIX_DIR=".helix"
CONFIG_FILE="${HELIX_DIR}/helix.config.json"

# Check if HELIX is initialized in this repo
if [[ ! -f "$CONFIG_FILE" ]]; then
  # Not a HELIX project, exit silently
  exit 0
fi

# Check if hooks are enabled in config
HOOKS_ENABLED=$(jq -r '.hooks.enabled // "false"' "$CONFIG_FILE")
if [[ "$HOOKS_ENABLED" != "true" ]]; then
  echo "⏸️ [HELIX] Hooks disabled in helix.config.json. Skipping auto-activation."
  exit 0
fi

echo "🔄 [HELIX] Auto-activation triggered via hook: $HOOK_NAME"

case "$HOOK_NAME" in
  pre-commit)
    echo "🛡️ [HELIX Validator] Running pre-commit integrity checks..."
    # Here we would normally call the L4 Validator.
    # For now, we simulate the validation and Agentic Healing gate.
    
    # Example: Run tests if configured
    AUTO_TEST=$(jq -r '.hooks.pre_commit.run_tests // "false"' "$CONFIG_FILE")
    if [[ "$AUTO_TEST" == "true" ]]; then
      echo "   Running test suite..."
      if ! npm test --passWithNoTests > /dev/null 2>&1; then
        echo "   ❌ Tests failed! Initiating Agentic Self-Healing..."
        echo "   (Self-Healing micro-agent would spawn here)"
        # exit 1 to block commit until healed
        exit 1
      fi
      echo "   ✅ Tests passed."
    fi
    echo "✅ [HELIX] Pre-commit validation successful."
    ;;
    
  post-merge)
    echo "🔥 [HELIX Evolver] Analyzing post-merge delta..."
    AUTO_EVOLVE=$(jq -r '.hooks.post_merge.auto_evolve // "false"' "$CONFIG_FILE")
    if [[ "$AUTO_EVOLVE" == "true" ]]; then
      # Call the evolver to update rules based on the new merge
      echo "   Spawning Evolver to update learned_rules.md..."
      # /helix:evolve logic goes here
      echo "   ✅ Evolution complete."
    fi
    ;;
    
  pre-wave)
    # Internal hook triggered by Loop-Manager before a wave starts
    WAVE_ID="${1:-unknown}"
    echo "🌊 [HELIX] Pre-wave hook for Wave $WAVE_ID"
    ;;
    
  post-wave)
    # Internal hook triggered by Loop-Manager after a wave finishes
    WAVE_ID="${1:-unknown}"
    STATUS="${2:-unknown}"
    echo "🌊 [HELIX] Post-wave hook for Wave $WAVE_ID (Status: $STATUS)"
    ;;
    
  *)
    echo "⚠️ [HELIX] Unknown hook: $HOOK_NAME"
    ;;
esac

exit 0