# ⚡ Installation Guide

HELIX v2.0 is designed to plug directly into your favorite AI CLI workflows, transforming them into premium, self-evolving orchestrators.

## 📦 Requirements
- Node.js >= 20 or Python >= 3.11
- **Claude Code** (latest version) OR **Gemini CLI** (latest version)
- Git initialized in your project
- *(Optional but recommended)* configured MCP servers

## 🚀 Installing on Gemini CLI

Run the following command anywhere in your terminal:

```bash
gemini skill install github:caramaschiHG/helix-loops
```

## 🚀 Installing on Claude Code

Use the official Claude Code skill installation syntax:

```bash
claude-code install caramaschiHG/helix-loops
```

## ⚙️ Initializing in a Project

Once installed globally, you need to initialize HELIX in your specific repository so the **Evolver** has a place to store its learned rules.

Navigate to your project folder and run:

```bash
/helix:init
```

This will create an elegant `.helix/` directory containing:
- `helix.config.json` (Caching, MCP, and Model settings)
- `templates/` (Auto-updating agent prompts)
- `learned_rules.md` (This will start empty and grow over time!)

## 🔄 Updating After Self-Evolution

Because HELIX rewrites its own local configuration (`.helix/`), you do not need to manually pull updates for project-specific rules. The skill updates its own behavior locally.

To update the core engine binaries to the latest version by @caramaschiHG:

**Gemini:**
```bash
gemini skill update caramaschiHG/helix-loops
```

**Claude:**
```bash
claude-code update caramaschiHG/helix-loops
```

## 🛠️ Troubleshooting

- **Evolver isn't learning?** Ensure the `.helix` directory is committed to your repo so the agent has context across sessions.
- **Costs too high?** Ensure `enable_prompt_caching` is `true` in `helix.config.json`.