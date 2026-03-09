# 🗺️ HELIX Master Roadmap

Our vision is clear: **to make HELIX the undisputed #1 autonomous AI orchestration engine on the planet.** 

While v2.0 brought MCP, Prompt Caching, and Agentic Healing, we are now setting our sights on crushing the current leaders (Conductor, Loki, Superpowers) in their best domains.

---

## 🚀 v2.1 — The Infrastructure & Observability Update
*Focus: Scaling the Swarm safely and making it beautiful to watch.*

- [ ] **Isolated Git Worktrees (Multi-Agent Seguro)**
  - Native support for `git worktree`.
  - Run 6+ Swarm Agents completely isolated without any git merge conflicts.
  - *Beats: Conductor & Loki on parallel safety.*

- [ ] **Visual Terminal Dashboard (`helix-dashboard`)**
  - A beautiful, real-time terminal UI (like `blessed` or `ink`).
  - See active parallel waves, live token consumption, real-time costs, and agent logs in one central view.
  - *Beats: Conductor's visualization.*

- [ ] **Advanced Hooks & Auto-Activation**
  - Robust hook system (`pre-wave`, `post-wave`, `on-heal-failed`, `git-pre-commit`).
  - True total auto-activation without manual `/helix` triggers when specific repo events happen.
  - *Beats: Superpowers & native Gemini CLI hooks.*

- [ ] **Centralized Observability & Logging (`helix-logs`)**
  - Analytics on your local machine: success rate of waves, total $ saved by caching, and evolution graphs.
  - Know exactly *how much* the Evolver improved your system over time.

---

## 🌟 v3.0 — The Ecosystem & Enterprise Update
*Focus: Long-term memory, specialized skills, and team scaling.*

- [ ] **Persistent Vector DB Memory (Cross-Session)**
  - Move beyond `summarized.md`. Integrate a local vector database (like ChromaDB or local SQLite-vss).
  - HELIX will remember architectural decisions from *months* ago across different repositories.
  
- [ ] **Embedded Specialized Sub-Skills Bundle**
  - Don't just orchestrate; execute with domain experts.
  - Bundled internal agents: `TDD-Master`, `4-Phase-Debugger`, `Strict-Code-Reviewer`.
  - *Beats: Superpowers' specific sub-skills.*

- [ ] **Auto PR Creation + Adversarial Review**
  - When the Swarm finishes a feature, the Evolver automatically generates a PR.
  - Before merging, an isolated "Adversarial Agent" attacks the PR looking for flaws.

- [ ] **Universal Multi-Platform Support**
  - Export the HELIX orchestration spec to run natively not just on Gemini CLI / Claude Code, but also **Cursor, Aider, Codex, and OpenCode**.

- [ ] **Team / Multi-User Mode (Enterprise)**
  - Share your `.helix/learned_rules.md` across your startup securely.
  - Collaborative evolution: When Dev A fixes a bug, the Evolver updates the prompt templates for Dev B automatically.

- [ ] **Internal Evolutionary Benchmarking**
  - Built-in `helix-bench`. Run a standard test suite to mathematically prove how much faster/cheaper HELIX runs after 10 evolutions vs its first run.
