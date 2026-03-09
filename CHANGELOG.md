# 📝 Changelog

All notable changes to the HELIX framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v2.1.0] - Upcoming (The Infrastructure Update)
- **Planned:** Visual Terminal Dashboard (`helix-dashboard`)
- **Planned:** Isolated Git Worktrees for true multi-agent collision safety
- **Planned:** Advanced Hooks & Total Auto-Activation
- **Planned:** Centralized Observability & Logging (`helix-logs`)

## [v2.0.0] - March 2026

### Added (The "Best Currently" Update)
- **MCP Native Integration:** Swarm Execution (Level 3) agents now automatically bind to Model Context Protocol (MCP) servers (Postgres, GitHub, Linear, etc.) for zero-hallucination data gathering.
- **Prompt Caching:** Loop-Manager now utilizes provider-level prompt caching, reducing token costs by up to 60% on long-running waves.
- **Agentic Healing:** Validator (Level 4) no longer immediately rolls back on test failure. It now spawns a micro-agent to attempt an autonomous code fix (self-healing) before retreating.
- **Context Compression:** Prevents context window rot. Meta-Planner generates lightweight `summarized_state.md` vectors instead of passing massive git histories to every child node.

### Changed
- Refined `/helix:init` to automatically detect if `.helix/helix.config.json` is using outdated v1 keys and gracefully upgrade them.
- Updated default Swarm Agent template to respect new `safety` boundaries.

## [v1.0.0] - March 2026

### Added
- **Initial Release of HELIX (Hierarchical Evolutionary Loop for Intelligent eXecution)**.
- **Level 1 Meta-Planner:** Blueprint generation and task routing.
- **Level 2 Loop-Manager:** Parallel wave scheduling and context management.
- **Level 3 Swarm Execution:** Concurrent, isolated agent execution.
- **Level 4 Validator + Optimizer:** Pre-commit architectural integrity checks.
- **Level 5 The Evolver:** 🔥 First-of-its-kind self-modifying codebase logic. Analyzes diffs and rewrites its own `.helix/learned_rules.md`.
- **CLI Integrations:** Full native support for Gemini CLI and Claude Code via `/helix` commands.
- **Commands:** `/helix:init`, `/helix:status`, `/helix:evolve`, and `/helix:predict`.

---
*Maintained by [@caramaschiHG](https://github.com/caramaschiHG)*