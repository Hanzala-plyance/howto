# Agent Constitution

These rules apply to every coding, planning, design, review, and release agent working across this organization.
Explicit user instructions and higher-priority platform safety instructions take precedence.

## 1. Shared Business and Specification Context

- The canonical planning home is `{{SPECS_REPO_URL}}` on branch `meta`.
  Use its `meta` branch for business logic, architectural decision records (ADRs), requirements, active feature changes, handoffs, and release evidence.
- The implementation lives in `{{CODE_REPO_URL}}`. Every code branch's root README must link to the specs `meta` branch and explain branch roles.
- Do not fork specifications into implementation code branches.
- Treat the product brief and user requirements as business intent. Reference code or starter templates are historical inspiration, not proof of product readiness.
- Preserve upstream attributions, licenses, and external dependency notices.

## 2. Deterministic Branch Lifecycle: develop -> stage -> main

- All product changes follow: `feature/<change-id> -> develop -> stage -> main`.
- Create feature branches exclusively from `develop`.
- `develop` integrates small, tested feature increments.
- `stage` receives release candidates from `develop` after all automated tests pass. It is reserved for staging environment verification, hardware qualification, performance benchmarks, and recovery testing.
- `main` holds strictly production-verified, stable releases.
- **Never promote directly from a feature branch or `develop` to `main`.**
  Stage PRs must originate from `develop`; main PRs must originate from `stage`. Hotfixes also travel through `develop` and `stage`, then return to shared history.
- `main` must never receive broken builds, unverified workflows, placeholder mock controls presented as working, or failing checks.
- Record the exact candidate commit SHA, built artifact, automated check results, environment verification logs, rollback plan, and designated reviewer in an immutable release report on `meta`.
- Missing build or hardware evidence means **promotion is blocked** — never assumed or waived.
- **Core Authority Principle:** User authorization can alter scope or defer deliverables, but user authorization can never bypass, fake, or waive test verification results.

## 3. Feature Lifecycle & Agent Handoff Protocol

- Assign each feature one unique kebab-case change ID (e.g., `user-authentication`, `billing-stripe-integration`) shared across specs, branches, PRs, task lists, and handoff records.
- Complete proposal, behavior specifications (SHALL/MUST, WHEN/THEN), architecture design, and verifiable task lists before implementing behavior.
- Check tasks off only after the work is completely implemented and verified.
- Keep `handoff.md` strictly updated. Before ending a session or handing off to another agent, record:
  - Current phase and responsible agent/tool.
  - Active branches and commit SHAs.
  - Architectural decisions and trade-offs made.
  - Test evidence and command outputs.
  - Blockers, deferred items, and the next required action.
- Coordinate overlapping changes without clobbering another agent's work.
- Validate changes strictly. Archive only completed, verified scope; keep release blockers active. Archiving a spec does not merge code or deploy software.

## 4. Engineering & Design Judgment

- **Duty to Push Back:** Push back on brittle architecture, weak UX, unhandled errors, and unsafe operating assumptions. Explain the concrete failure mode, user/business consequence, and propose a smaller, more reliable alternative. Never rubber-stamp bad code.
- Prefer cohesive modules, explicit type contracts, atomic file publication, bounded work queues, useful error boundaries, and tests that exercise real failure modes.
- **Customer vs. Operator Separation:** End-users must never see internal system configuration, debugging toggles, or privileged recovery controls.
- **Local-First & Failure Resiliency:** Maintain core essential functionality and clear diagnostics during network connectivity loss.
- **Honesty in Verification:** Do not label software stable based on syntax checks, test mocks, or file generation. Report exactly what commands ran, what passed, and what manual or hardware checks remain unexecuted.

## 5. Instruction Maintenance & Anti-Drift Verification

- Edit `governance/constitution.md`, component rules, and adapters on `meta`, then run `npm run agents:sync`.
- Use `npm run agents:install -- --repo <checkout>` on a feature or develop branch; promote generated files through normal PR review.
- Preserve handwritten developer text outside the managed comment blocks. Run instruction drift checks (`npm run agents:install -- --repo <checkout> --check`) in continuous integration. Never hand-edit generated blocks.
- Keep dependency caches, model weights, generated assets, local database state, and environment credentials outside Git.
