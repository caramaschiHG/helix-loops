#!/usr/bin/env bash
# HELIX Git Hook Installer
# Installs HELIX auto-activation hooks into the current repository.

set -euo pipefail

GIT_DIR=$(git rev-parse --git-dir 2>/dev/null || true)

if [[ -z "$GIT_DIR" ]]; then
  echo "❌ Error: Not a git repository. Cannot install hooks."
  exit 1
fi

HOOKS_DIR="${GIT_DIR}/hooks"
RUNNER_PATH="$(pwd)/scripts/hook-runner.sh"

echo "🛠️ [HELIX] Installing Advanced Hooks..."

# 1. Install pre-commit hook
PRE_COMMIT_FILE="${HOOKS_DIR}/pre-commit"
cat << 'EOF' > "$PRE_COMMIT_FILE"
#!/usr/bin/env bash
# HELIX Auto-Activation: pre-commit

# Find the project root
REPO_ROOT=$(git rev-parse --show-toplevel)

# Call the HELIX hook runner if it exists
if [[ -x "$REPO_ROOT/scripts/hook-runner.sh" ]]; then
  "$REPO_ROOT/scripts/hook-runner.sh" pre-commit
  # If the hook runner fails (e.g., tests fail and healing fails), block the commit
  if [[ $? -ne 0 ]]; then
    echo "❌ [HELIX] Commit blocked due to validation failure."
    exit 1
  fi
fi
EOF
chmod +x "$PRE_COMMIT_FILE"
echo "   ✅ Installed pre-commit hook."

# 2. Install post-merge hook
POST_MERGE_FILE="${HOOKS_DIR}/post-merge"
cat << 'EOF' > "$POST_MERGE_FILE"
#!/usr/bin/env bash
# HELIX Auto-Activation: post-merge

REPO_ROOT=$(git rev-parse --show-toplevel)

if [[ -x "$REPO_ROOT/scripts/hook-runner.sh" ]]; then
  "$REPO_ROOT/scripts/hook-runner.sh" post-merge
fi
EOF
chmod +x "$POST_MERGE_FILE"
echo "   ✅ Installed post-merge hook."

echo "🎉 [HELIX] Hooks successfully installed! Auto-Activation is now live."
echo "Modify .helix/helix.config.json to toggle specific hook behaviors."
