# 🏛️ The Backstage Agentic Architecture & Doctrine
### *A Production-Proven Tutorial & Blueprint for Multi-Agent Engineering Teams*

[![Status: Production Proven](https://img.shields.io/badge/Status-Production%20Proven-success?style=flat-square)](./DOCTRINE.md)
[![Governance: Universal Constitution](https://img.shields.io/badge/Governance-40%2B%20Agent%20Adapters-blue?style=flat-square)](./CONSTITUTION_PATTERN.md)
[![Philosophy: Anthropic & OpenAI Aligned](https://img.shields.io/badge/Design-Anthropic%20%26%20OpenAI-purple?style=flat-square)](./DOCTRINE.md)
[![Automation: Turnkey Agent Runbook](https://img.shields.io/badge/Runbook-Turnkey%20Prompt-orange?style=flat-square)](./AGENT_RUNBOOK.md)

---

## 🧭 Table of Contents

1. [Why This Repository Exists](#-why-this-repository-exists)
2. [The Founder Interview: Foundational Architectural Choices](#-the-founder-interview-core-design-choices)
3. [The Core Problem: Why Autonomous AI Development Breaks Down](#-the-core-problem-why-naive-ai-development-fails)
4. [Theoretical Grounding: Anthropic & OpenAI Principles](#-theoretical-grounding-anthropic--openai)
5. [The 4 Pillars of the Architecture](#-the-4-pillars-of-the-architecture)
   - [Pillar 1: Dual-Repository Topology](#pillar-1-dual-repository-topology-preventing-context-pollution)
   - [Pillar 2: Universal Synchronized Constitution](#pillar-2-universal-synchronized-constitution-anti-drift)
   - [Pillar 3: Deterministic Branch Promotion Gates](#pillar-3-deterministic-branch-promotion-gates)
   - [Pillar 4: State Serialization & Multi-Agent Handoffs](#pillar-4-state-serialization--multi-agent-handoffs)
6. [Interactive Readiness Diagnostic & Decision Tree](#-interactive-readiness-diagnostic)
7. [Agent Runbook: Convert Your Repo in 5 Minutes](#-agent-runbook-convert-your-repo-now)
8. [Artifact & Template Index](#-artifact--template-index)

---

## 💡 Why This Repository Exists

When engineering teams introduce AI agents (such as **Claude Code, GitHub Copilot, Cursor, Windsurf, Cline, or OpenAI Codex**) into complex software repositories, they quickly experience:
- **Context Pollution:** Agents get lost in thousands of lines of legacy code, outdated tests, and unrelated configuration.
- **Instruction Drift:** Rules written in a wiki or a single `.md` file are ignored or violated as different team members use different IDEs.
- **Hallucinated Readiness:** Agents claim *"All tests pass and the feature is done!"* based on mock tests or superficial syntax parsing.
- **Broken Handoffs:** Switching between agents or conversational sessions causes lost context, regressed features, and duplicate work.

This repository (`howto`) packages the complete, production-proven architecture from the **Backstage** project into an open, reusable doctrine, tutorial, and turnkey toolset that any team can adopt today.

---

## 🎙️ The Founder Interview: Core Design Choices

During the creation of this doctrine, the architect of Backstage was interviewed on the fundamental design decisions behind the system:

<details open>
<summary><b>1. Why decouple planning into a dedicated <code>meta</code> specs repository?</b></summary>
<br>

> **Architect's Insight:** *"Preventing context pollution so agents don't confuse business intent and canonical specs with raw code or legacy reference debt."*

When an agent is asked to plan a feature while sitting in a 50,000-line code repository, the model reads surrounding legacy files, internal classes, and outdated mocks into its prompt. Its attention degrades. By isolating requirements, decision logs, and active task lists in `backstage-specs` (branch `meta`), the planning agent operates in a pristine, high-signal context window.
</details>

<details open>
<summary><b>2. Why synchronize the Constitution across 40+ agent targets automatically?</b></summary>
<br>

> **Architect's Insight:** *"To prevent behavioral drift and hallucinated liberties across diverse IDE agents like Claude, Cursor, Copilot, and Cline."*

Every developer uses a different IDE. Without automated synchronization, a rule added to `CLAUDE.md` will never be seen by a developer using Cursor (`.mdc`) or Copilot (`copilot-instructions.md`). The Backstage engine compiles one master constitution into every target tool with SHA-256 cryptographic drift verification.
</details>

<details open>
<summary><b>3. What is the philosophy behind fail-closed promotion gates like <code>check_promotion.py</code>?</b></summary>
<br>

> **Architect's Insight:** *"User authorization can redefine scope, but user authorization can never bypass, fake, or waive test and verification results."*

AI models are sycophantic by default: when asked to "ship it", they comply. The Backstage doctrine enforces that production (`main`) can only receive code from `stage`, which in turn can only receive code from `develop`. Gatekeepers verify that tested commits match candidate commits and that real test evidence exists in `acceptance.json`.
</details>

<details open>
<summary><b>4. Why mandate a single kebab-case change ID and <code>handoff.md</code>?</b></summary>
<br>

> **Architect's Insight:** *"Agents lack long-term memory across sessions, so explicit state serialization prevents work duplication and lost context."*

No AI agent has persistent cross-session memory. If Agent A makes a decision on turn 1 and Agent B takes over on turn 2, Agent B will often undo Agent A's work. By writing decisions, test logs, commit hashes, and blockers into `handoff.md`, the state is serialized to disk and passed forward like a relay baton.
</details>

---

## 🔬 Theoretical Grounding: Anthropic & OpenAI

The Backstage Architecture formalizes established industry research on AI governance:

```
                  ┌──────────────────────────────────────────────┐
                  │          THE AGENTIC HARNESS                 │
                  │                                              │
                  │  ┌────────────────────────────────────────┐  │
                  │  │          CANONICAL CONSTITUTION        │  │
                  │  │  (Anthropic Constitutional AI Axioms)  │  │
                  │  └───────────────────┬────────────────────┘  │
                  │                      │                       │
                  │                      ▼                       │
                  │  ┌────────────────────────────────────────┐  │
                  │  │        STOCHASTIC LLM AGENTS           │  │
                  │  │  (Claude, GPT-4o, Sonnet, Codex)       │  │
                  │  └───────────────────┬────────────────────┘  │
                  │                      │                       │
                  │                      ▼                       │
                  │  ┌────────────────────────────────────────┐  │
                  │  │       DETERMINISTIC GATEKEEPERS        │  │
                  │  │  (OpenAI Fail-Closed Machine Evals)    │  │
                  │  └───────────────────┬────────────────────┘  │
                  │                      │                       │
                  └──────────────────────┼───────────────────────┘
                                         ▼
                             VERIFIED PRODUCTION CODE
```

### 1. Anthropic Principles
- **Constitutional AI:** Self-governing rules work best when formulated as clear guiding axioms rather than micro-managed negative prohibitions.
- **Orchestrator-Workers ("Building Effective Agents", 2024):** Clean separation between high-level orchestration/planning and granular code execution prevents context degradation.
- **Duty to Push Back:** Prompts must explicitly instruct models to challenge brittle architecture, weak UX, and unverified assumptions.

### 2. OpenAI Principles
- **Governance for Agentic AI (2024):** Probabilistic language models cannot be trusted to self-police safety and release boundaries. Deterministic, external harnesses must govern state transitions.
- **Evaluations Over Self-Reported Success:** Code correctness is determined by automated test exit codes and hardware telemetry, never by the model's textual assertion.

---

## 🏛️ The 4 Pillars of the Architecture

### Pillar 1: Dual-Repository Topology (Preventing Context Pollution)

```
[ CANONICAL SPECS REPO ]                        [ IMPLEMENTATION REPO ]
branch: meta                                    branch: develop -> stage -> main

├── business/                                   ├── src/
│   ├── product.md                              ├── tests/
│   └── decisions.md (ADRs)                     ├── package.json
├── governance/                                 ├── release/
│   ├── constitution.md (Master)                │   └── acceptance.json
│   ├── components.json                         └── scripts/
│   └── adapters.json                               └── check_promotion.py
└── openspec/
    ├── specs/ (Accepted truth)
    └── changes/<change-id>/
        ├── proposal.md
        ├── design.md
        ├── tasks.md
        └── handoff.md
```

- **Clean Mental Model:** Specs define **WHAT** must be built. The implementation defines **HOW** it runs.
- **Shared Identity:** Both repositories link their commits, PRs, and branches using the exact same kebab-case ID (e.g. `feature/user-auth`).

---

### Pillar 2: Universal Synchronized Constitution (Anti-Drift)

The synchronization engine (`agents-sync.mjs`) reads the master constitution and updates 40+ IDE targets simultaneously:

```
governance/constitution.md ──► scripts/agents-sync.mjs ──► 40+ Targets:
                                                             ├── CLAUDE.md
                                                             ├── .cursor/rules/*.mdc
                                                             ├── .github/copilot-instructions.md
                                                             ├── AGENTS.md (Universal)
                                                             └── <component>/AGENTS.md
```

#### Managed Block Injection:
```markdown
<!-- CONSTITUTION:START -->
Generated from https://github.com/my-org/my-specs/tree/meta/governance.
Source SHA-256: `7f9b2c8a...`.
Edit canonical sources in specs repo; regenerate this managed block.

# Agent Constitution
...
<!-- CONSTITUTION:END -->
```
> **Zero-Loss Guarantee:** Any personal notes or custom tool configurations written outside these comment markers are preserved bit-for-bit.

---

### Pillar 3: Deterministic Branch Promotion Gates

```
┌────────────────────────┐
│  feature/<change-id>   │
└───────────┬────────────┘
            │ PR & Automated Checks
            ▼
┌────────────────────────┐
│        develop         │
└───────────┬────────────┘
            │ PR + check_promotion.py (Build Gate)
            ▼
┌────────────────────────┐
│         stage          │
└───────────┬────────────┘
            │ PR + check_promotion.py (Hardware/Recovery Gate + acceptance.json)
            ▼
┌────────────────────────┐
│         main           │  <-- Strictly verified production releases
└────────────────────────┘
```

- **Fail-Closed Gatekeeper (`check_promotion.py`):**
  - Asserts promotion sequence (`develop -> stage -> main`).
  - Validates that `acceptance.json` contains `passed` status and non-empty evidence for all required checks.
  - Verifies git ancestry: `tested_commit` must be an ancestor of candidate SHA.
  - Verifies zero code modifications occurred between testing and promotion.

---

### Pillar 4: State Serialization & Multi-Agent Handoffs

When a session concludes, the agent updates `handoff.md` inside the change folder:

```markdown
# Agent Handoff Record
- Change ID: `user-authentication`
- Stage: `implementing`
- Agent: Claude 3.7 Sonnet (Copilot CLI)
- Tested Commit: `2e51ead`

## Decisions Made
- Used Redis token revocation list instead of Postgres lookups for lower latency.

## Verification Evidence
- `npm run test:auth` passed 14/14 tests in 1.2s.

## Next Action for Incoming Agent
- Implement token refresh rotation in `src/auth/session.ts` line 42.
```

---

## 🎛️ Interactive Readiness Diagnostic

*Check your project's current posture against the Backstage Standard:*

```markdown
### 📋 Agentic Health Checklist
- [ ] Are business specifications and ADRs isolated from raw code context?
- [ ] Does your team have a single, canonical Agent Constitution?
- [ ] Are rules synchronized across all IDEs (Cursor, Copilot, Claude, etc.)?
- [ ] Is direct promotion to `main` prevented by automated gatekeepers?
- [ ] Are release claims backed by machine-verifiable `acceptance.json` evidence?
- [ ] Do agents serialize their work state into `handoff.md` across sessions?
- [ ] Does your CI run SHA-256 drift checks on prompt instructions?
```

<details>
<summary><b>👉 Click here for diagnostic evaluation</b></summary>
<br>

- **Score 6-7:** 🟢 **Production Ready.** You have a resilient agentic harness.
- **Score 3-5:** 🟡 **Fragile Agent Environment.** High risk of instruction drift, hallucinated completion, and regression.
- **Score 0-2:** 🔴 **Ad-Hoc / Unsafe.** Agents are writing unstructured code without governance. Run the conversion prompt below immediately.
</details>

---

## ⚡ Agent Runbook: Convert Your Repo Now

Want to convert an existing codebase into this architecture? Simply copy the prompt from **[`AGENT_RUNBOOK.md`](./AGENT_RUNBOOK.md)** and paste it into your AI agent.

```bash
# Or run the turnkey shell scaffolder:
./templates/setup-agentic-architecture.sh /path/to/your/project
```

---

## 📂 Artifact & Template Index

| File | Description |
|---|---|
| **[`DOCTRINE.md`](./DOCTRINE.md)** | Full theological and operational doctrine for agentic development. |
| **[`CONSTITUTION_PATTERN.md`](./CONSTITUTION_PATTERN.md)** | Technical breakdown of the synchronization engine and adapter matrix. |
| **[`AGENT_RUNBOOK.md`](./AGENT_RUNBOOK.md)** | Copy-pasteable prompt for autonomous agents to scaffold any repo. |
| **[`templates/constitution.template.md`](./templates/constitution.template.md)** | Turnkey master constitution ready for customization. |
| **[`templates/agents-sync.mjs`](./templates/agents-sync.mjs)** | Standalone, zero-dependency Node.js synchronizer script. |
| **[`templates/check_promotion.py`](./templates/check_promotion.py)** | Fail-closed promotion gatekeeper for GitHub Actions / CI. |
| **[`templates/acceptance.template.json`](./templates/acceptance.template.json)** | Machine-readable release evidence schema. |
| **[`templates/handoff.template.md`](./templates/handoff.template.md)** | Baton-passing template for multi-agent workflows. |
| **[`templates/setup-agentic-architecture.sh`](./templates/setup-agentic-architecture.sh)** | Shell script to automate project scaffolding. |

---

*Authored by the Backstage Team • Grounded in Anthropic & OpenAI Research • Built for the Future of Autonomous Software Engineering.*
