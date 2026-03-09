# ⚡ Installation Guide

HELIX is designed to plug directly into your favorite AI CLI workflows.

## 📦 Requirements
- Node.js >= 20 or Python >= 3.11 (depending on your CLI environment)
- **Claude Code** (latest version) OR **Gemini CLI** (latest version)
- Git initialized in your project

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

This will create a `.helix/` directory containing:
- `helix.config.json`
- `templates/`
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
- **Out of context errors?** Use `/helix:status` to check the Loop-Manager's memory usage. The Swarm might need to flush its context window.
