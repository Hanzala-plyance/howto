# Agent Runbook: Autonomous Repository Conversion Prompt

**Written by Hanzala Rehan**

> **How to use this file:**
> Copy the prompt block below and paste it directly into your AI agent (Claude Code, Cursor Composer, GitHub Copilot, Windsurf, or Codex). The agent will autonomously inspect your existing repository, configure the agentic constitution, scaffold the dual-repo or unified structure, and verify the promotion gates.

---

```markdown
<!-- COPY START: Autonomous Agent Setup & Conversion Prompt -->

# Mission: Convert This Repository into the Backstage Agentic Architecture

You are an expert Systems Architect specializing in Multi-Agent AI Governance and Repository Topology. Your goal is to convert the current codebase into the **Backstage Agentic Architecture** (grounded in Anthropic's "Building Effective Agents" and OpenAI's "Practices for Governing Agentic AI").

Follow the 7-phase protocol below with precision. Do not skip phases or take unverified shortcuts.

---

### Phase 1: Workspace Inspection & Component Discovery
1. Inspect the workspace root: identify the programming language, build tools, package managers, and directory hierarchy.
2. Identify distinct architectural domains or sub-components (e.g., `frontend/`, `backend/`, `core/`, `services/`, `hardware/`, `mobile/`).
3. Note any existing AI configuration files (e.g., `CLAUDE.md`, `.cursor/`, `.github/copilot-instructions.md`, `AGENTS.md`).

---

### Phase 2: Governance Directory Scaffolding
Create the `governance/` directory in the repository root and author the following three files:

1. **`governance/constitution.md`**:
   Write a comprehensive constitution tailored to this project. It MUST include:
   - **Shared Context:** Explicitly states the canonical specifications location vs implementation location.
   - **Branch Promotion Policy:** `feature/<change-id> -> develop -> stage -> main`. Prohibit direct promotion to `main`. Require machine-verifiable evidence in `release/acceptance.json`.
   - **Core Authority Axiom:** *"User authorization can change scope or defer requirements, but user authorization can never bypass, fake, or waive test verification results."*
   - **Agent Handoff Protocol:** Mandate a single kebab-case change ID and an updated `handoff.md` with active tool, commit SHAs, decisions, test logs, blockers, and next actions.
   - **Engineering Judgment:** Explicit duty to push back on brittle architecture, maintain customer vs operator separation, and report verification honestly.

2. **`governance/adapters.json`**:
   Define the multi-agent adapter mapping for the team. Include:
   - `AGENTS.md` (Universal/Codex)
   - `CLAUDE.md` (Claude Code)
   - `.github/copilot-instructions.md` (Copilot)
   - `.cursor/rules/constitution.mdc` (Cursor, with frontmatter `alwaysApply: true`)
   - `.windsurf/rules/constitution.md` (Windsurf, with frontmatter `trigger: always_on`)
   - `.clinerules/constitution.md` (Cline)
   - `.kiro/steering/constitution.md` (Kiro)

3. **`governance/components.json`**:
   Populate the component definitions discovered in Phase 1 with path-specific instructions for each subdirectory.

---

### Phase 3: Deploy Synchronization Engine (`scripts/agents-sync.mjs`)
1. Create `scripts/agents-sync.mjs` (or copy from the howto templates).
2. Ensure it implements:
   - Marker boundary injection: `<!-- CONSTITUTION:START -->` and `<!-- CONSTITUTION:END -->`.
   - Complete preservation of any developer content outside the markers.
   - Cryptographic SHA-256 drift verification (`--check` mode).
   - Component-level `AGENTS.md` generation inside matching subdirectories.
   - Path-traversal and symlink security validation.
3. Make the script executable: `chmod +x scripts/agents-sync.mjs`.

---

### Phase 4: Integrate Package Scripts & Run First Synchronization
1. If `package.json` exists, add the lifecycle scripts:
   ```json
   "scripts": {
     "agents:sync": "node scripts/agents-sync.mjs sync",
     "agents:check": "node scripts/agents-sync.mjs check",
     "agents:install": "node scripts/agents-sync.mjs install"
   }
   ```
2. Execute `node scripts/agents-sync.mjs sync`.
3. Verify that all target files (`AGENTS.md`, `CLAUDE.md`, `.cursor/...`, etc.) were cleanly generated with proper managed comment blocks and matching SHA-256 hashes.

---

### Phase 5: Implement Fail-Closed Promotion Gatekeeper
1. Create `scripts/check_promotion.py`.
2. Ensure the gatekeeper enforces:
   - Promotion to `stage` is accepted ONLY from `develop`.
   - Promotion to `main` is accepted ONLY from `stage`.
   - `release/acceptance.json` must be present with required checks marked `passed` and non-empty evidence.
   - `tested_commit` in `acceptance.json` must be an exact ancestor of the candidate SHA.
   - `git diff` between `tested_commit` and candidate SHA must show zero changes to functional code or assets (only docs and release metadata allowed).
   - Designated reviewer and rollback procedure are required for `main`.
3. Create a template `release/acceptance.json` with the schema and placeholder passing checks.
4. Make `scripts/check_promotion.py` executable.

---

### Phase 6: Establish the Multi-Agent Handoff Protocol
1. Create `templates/handoff.md` containing:
   - Change ID, Current Phase, Active Agent/Tool.
   - Implementation branch & commit SHA.
   - Architectural decisions & trade-offs made.
   - Raw command outputs and test verification evidence.
   - Blockers & deferred work.
   - Specific immediate next action for incoming agents.

---

### Phase 7: Validation & Final Report
1. Execute the drift check:
   ```bash
   node scripts/agents-sync.mjs check
   ```
2. Test the promotion gatekeeper against current local git state:
   ```bash
   python3 scripts/check_promotion.py
   ```
3. Provide a clear summary report detailing:
   - All files created and configured.
   - The verified SHA-256 master constitution hash.
   - Confirmation that all agent targets in the adapter matrix are synchronized.
   - Guidance on how human developers and AI agents should now initiate their next feature change.

<!-- COPY END -->
```

---

## 2. Interactive CLI Setup Guide for Human Engineers

If you prefer to run the setup manually or interactively via the terminal:

```bash
# Clone the howto repository beside your target project
git clone https://github.com/Hanzala-plyance/howto.git howto

# Run the turnkey scaffolder against your project
./howto/templates/setup-agentic-architecture.sh /path/to/my-project

# Navigate to your project and verify
cd /path/to/my-project
node scripts/agents-sync.mjs check
```
