#!/usr/bin/env bash
# HELIX Git Worktree Manager (v2.1)
# Manages isolated git worktrees for safe, collision-free multi-agent parallel execution.

set -euo pipefail

HELIX_HOME="${HOME}/.claude/skills/helix"
STATE_DIR="${HELIX_HOME}/state"
WORKTREES_DIR="${STATE_DIR}/worktrees"

mkdir -p "$WORKTREES_DIR"

# ─── Worktree Lifecycle ───────────────────────────────────────────────────────

create_worktree() {
  local phase_id="${1}"
  local task_slug="${2}"
  local base_branch="${3:-main}"
  
  local branch_name="helix/${phase_id}/${task_slug}"
  local wt_path="${WORKTREES_DIR}/${phase_id}_${task_slug}"

  echo "🌱 [HELIX Worktree] Spawning isolated environment for: $task_slug"
  
  # Ensure the base branch is up to date (conceptually)
  # Create a new branch from base branch and checkout into a new worktree
  if git show-ref --verify --quiet "refs/heads/$branch_name"; then
    echo "⚠️ Branch $branch_name already exists. Using existing branch."
    git worktree add "$wt_path" "$branch_name" > /dev/null 2>&1 || true
  else
    git worktree add -b "$branch_name" "$wt_path" "$base_branch" > /dev/null 2>&1
  fi

  # Return the isolated path so the Swarm Execution agent can cd into it
  echo "$wt_path"
}

teardown_worktree() {
  local phase_id="${1}"
  local task_slug="${2}"
  
  local wt_path="${WORKTREES_DIR}/${phase_id}_${task_slug}"

  if [[ -d "$wt_path" ]]; then
    echo "🧹 [HELIX Worktree] Tearing down isolated environment: $task_slug"
    # Remove the worktree safely
    git worktree remove --force "$wt_path" > /dev/null 2>&1
  else
    echo "⚠️ Worktree path not found: $wt_path"
  fi
}

merge_worktree() {
  local phase_id="${1}"
  local task_slug="${2}"
  local target_branch="${3:-main}"
  
  local branch_name="helix/${phase_id}/${task_slug}"

  echo "🧬 [HELIX Worktree] Merging $branch_name into $target_branch..."
  
  # Ensure we are in the main repo
  git checkout "$target_branch" > /dev/null 2>&1
  
  # Attempt merge. If conflicts occur, this is where Agentic Healing (L4) steps in.
  if git merge --no-ff -m "helix: merge task ${task_slug} from phase ${phase_id}" "$branch_name"; then
    echo "✅ Merge successful."
    # Cleanup branch
    git branch -d "$branch_name" > /dev/null 2>&1
  else
    echo "❌ Merge conflict detected! Triggering L4 Validator..."
    git merge --abort
    exit 1
  fi
}

list_worktrees() {
  echo "🌳 Active HELIX Worktrees:"
  git worktree list | grep "$WORKTREES_DIR" || echo "  No active isolated agents."
}

# ─── Main ─────────────────────────────────────────────────────────────────────

main() {
  local cmd="${1:-help}"
  shift || true

  case "$cmd" in
    spawn)    create_worktree "$@" ;;
    teardown) teardown_worktree "$@" ;;
    merge)    merge_worktree "$@" ;;
    list)     list_worktrees ;;
    help|--help)
      echo "HELIX Git Worktree Manager"
      echo "Usage:"
      echo "  spawn <phase_id> <task_slug> [base_branch]  - Creates an isolated worktree"
      echo "  teardown <phase_id> <task_slug>             - Removes a worktree"
      echo "  merge <phase_id> <task_slug> [target]       - Merges worktree branch to target"
      echo "  list                                        - List active isolated environments"
      ;;
    *) echo "Unknown command: $cmd"; exit 1 ;;
  esac
}

main "$@"