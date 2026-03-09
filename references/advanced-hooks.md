# 🪝 HELIX Advanced Hooks & Auto-Activation (v2.1)

One of the standout features of HELIX v2.1 is **Total Auto-Activation**. 

Instead of requiring you to constantly type `/helix:init` or `/helix:evolve`, HELIX embeds itself into the lifecycle of your repository. It acts as an invisible pair programmer that jumps in precisely when needed.

## ⚙️ How it Works

HELIX uses a central dispatcher (`scripts/hook-runner.sh`) that responds to various system and git events. 

### 1. Git Hooks (Repository Lifecycle)

When you run `./scripts/install-hooks.sh`, HELIX integrates into your `.git/hooks` directory.

- **`pre-commit` (The Shield):** Before a commit is allowed, HELIX wakes up the **Level 4 Validator**. It runs your test suite and linters. If it finds a bug, it doesn't just yell at you—it attempts **Agentic Healing** to fix your code automatically before the commit goes through.
- **`post-merge` (The Learner):** After you pull from `main` or merge a PR, the **Level 5 Evolver** wakes up. It scans the incoming diffs, learns new architectural patterns introduced by your team, and updates the `.helix/learned_rules.md` file autonomously.

### 2. Internal Wave Hooks (Orchestration Lifecycle)

During a Swarm Execution, the Loop-Manager triggers internal events:

- **`pre-wave`:** Triggered before parallel agents are spawned. Excellent for taking database snapshots or sending a Slack/Discord notification that a massive refactor is beginning.
- **`post-wave`:** Triggered when a wave completes. Can be used to trigger external CI pipelines or update a custom dashboard.

## 🛠️ Configuration

You control Auto-Activation via `.helix/helix.config.json`. 

Example configuration block:

```json
{
  "hooks": {
    "enabled": true,
    "pre_commit": {
      "run_tests": true,
      "auto_heal_on_fail": true
    },
    "post_merge": {
      "auto_evolve": true
    }
  }
}
```

## 🚀 Installation

To enable Auto-Activation in your project:

```bash
# Make sure scripts are executable
chmod +x scripts/hook-runner.sh scripts/install-hooks.sh

# Install the hooks into the local git repository
./scripts/install-hooks.sh
```

## 🛑 Bypassing Hooks

If you ever need to make a quick change without triggering the Swarm (e.g., updating a typo in a README), you can bypass the git hooks natively:

```bash
git commit -m "docs: minor typo" --no-verify
```