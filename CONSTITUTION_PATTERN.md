# The Constitution Pattern & Synchronization Engine
## Mechanical Enforcement of Multi-Agent Alignment without Configuration Drift

> *"If an engineering rule lives only in a wiki, an AI agent will never read it. If it lives in ten different IDE config files, they will drift within forty-eight hours."*

---

## 1. The Multi-Agent Fragmentation Dilemma

Modern engineering teams do not standardize on a single AI tool. Across a single engineering organization:
- Developer A uses **Claude Code** (`CLAUDE.md`).
- Developer B uses **Cursor** (`.cursor/rules/backstage.mdc` with YAML frontmatter).
- Developer C uses **GitHub Copilot** (`.github/copilot-instructions.md`).
- Developer D uses **Windsurf** (`.windsurf/rules/backstage.md`).
- Developer E uses **Cline / Roo Code** (`.clinerules` / `.roo/rules/`).
- Automated CI and autonomous background workers use **OpenCode / Codex / Universal** (`AGENTS.md`).

When guidelines change (e.g., a new security policy, a revised branch promotion rule, or a database migration constraint), updating dozens of files across multiple repositories is error-prone. Inevitably, instructions drift, leading to catastrophic misalignments where one agent obeys safety gates while another quietly bypasses them.

---

## 2. The Solution: Single-Source Constitution Engine

The Constitution Pattern decouples the **authoring of governance** from the **distribution to tool-specific adapters**:

```
                       ┌───────────────────────────────┐
                       │   governance/constitution.md  │
                       │   (Human-Authored Master)     │
                       └───────────────┬───────────────┘
                                       │
                                       ▼
                       ┌───────────────────────────────┐
                       │   governance/adapters.json    │
                       │   (Agent Target Mappings)     │
                       └───────────────┬───────────────┘
                                       │
                                       ▼
                       ┌───────────────────────────────┐
                       │   governance/components.json  │
                       │   (Scoped Directory Rules)    │
                       └───────────────┬───────────────┘
                                       │
               ┌───────────────────────┴───────────────────────┐
               ▼                                               ▼
        [npm run agents:sync]                         [npm run agents:install]
   (Generates 40+ local targets)               (Installs into implementation checkout)
               │                                               │
               ├─► CLAUDE.md                                   ├─► /desktop/AGENTS.md
               ├─► .cursor/rules/*.mdc                         ├─► /services/AGENTS.md
               ├─► .github/copilot-instructions.md             ├─► /mobile/AGENTS.md
               └─► AGENTS.md                                   └─► Root AGENTS.md
```

---

## 3. The 4 Key Architectural Mechanics

### Mechanic 1: Managed Marker Injections
Every generated target embeds the constitution inside explicit HTML comments:
```markdown
<!-- CONSTITUTION:START -->
Generated from https://github.com/my-org/my-specs/tree/meta/governance.
Source SHA-256: `a1b2c3d4...`.
Edit the canonical sources in my-specs; regenerate this managed block.

# Agent Constitution
[...Full Constitution Body...]
<!-- CONSTITUTION:END -->
```

#### Preserving Local Customizations:
The synchronization algorithm treats the file as three distinct segments:
```
[Pre-Block Text (e.g. human notes, custom tooltips)]
<!-- CONSTITUTION:START -->
[Managed Constitution Body]
<!-- CONSTITUTION:END -->
[Post-Block Text (e.g. developer scratch notes)]
```
If a developer adds local notes, scratchpads, or personal preferences outside the markers, `agents:sync` **preserves every single byte outside the block**. Only the text between the markers is rewritten.

### Mechanic 2: Tool-Specific Frontmatter Adaptations
Different tools require different metadata wrappers. For example:
- **Cursor** requires YAML frontmatter with `alwaysApply: true`:
  ```yaml
  ---
  description: Shared feature and governance instructions
  alwaysApply: true
  ---
  ```
- **Windsurf** requires `trigger: always_on`.
- **Kiro** requires `inclusion: always`.

These wrappers are declared declaratively in `governance/adapters.json`:
```json
[
  { "tool": "Universal / Codex", "path": "AGENTS.md" },
  { "tool": "Claude Code", "path": "CLAUDE.md" },
  { "tool": "GitHub Copilot", "path": ".github/copilot-instructions.md" },
  {
    "tool": "Cursor",
    "path": ".cursor/rules/backstage.mdc",
    "frontmatter": "---\ndescription: Shared governance instructions\nalwaysApply: true\n---\n\n"
  },
  {
    "tool": "Windsurf",
    "path": ".windsurf/rules/backstage.md",
    "frontmatter": "---\ntrigger: always_on\n---\n\n"
  }
]
```

### Mechanic 3: Subdirectory Scoping (Component Instructions)
In complex systems (e.g., front-end Electron app + Python microservice + native hardware drivers), a single global prompt wastes context and creates conflicting instructions.
`governance/components.json` maps architectural domains to specific filesystem paths:
```json
{
  "components": [
    {
      "id": "desktop",
      "path": "desktop",
      "description": "Electron and browser UI runtime",
      "instructions": [
        "Keep the renderer sandboxed; expose only validated IPC methods.",
        "Local playback must work without the optional Python service.",
        "Measure app payload; never bundle model weights or native build caches."
      ]
    },
    {
      "id": "services",
      "path": "services/converter",
      "description": "Python audio processing and model inference",
      "instructions": [
        "Keep conversion output/ and model weights out of Git.",
        "Publish validated completed jobs atomically; never expose partial files."
      ]
    }
  ]
}
```
When `agents:install --repo ../my-app` runs:
1. It validates whether each component directory exists in the target checkout.
2. If the directory exists, it generates an isolated `AGENTS.md` inside that folder containing both the root constitution pointer and the component-specific directives.
3. If an agent is working in `services/converter`, its local context is primed with service-specific constraints without polluting the desktop UI context.

### Mechanic 4: SHA-256 Tamper Detection & CI Drift Verification
To guarantee that no agent or developer has bypassed governance or modified a local configuration file in secret, the synchronizer calculates a SHA-256 cryptographic hash of:
$$\text{Hash} = \text{SHA-256}(\text{constitution.md} + \text{components.json})$$

This hash is stamped directly into the header of every generated block.
In Continuous Integration (GitHub Actions / GitLab CI):
```bash
npm run agents:install -- --repo . --check
```
If any file in the repository has drifted from the canonical specification or contains an outdated hash, **the build fails immediately** with a list of offending files:
```
Error: Instruction drift detected:
  .cursor/rules/backstage.mdc
  .github/copilot-instructions.md
Run 'npm run agents:install' to synchronize instructions.
```

---

## 4. Security & Path Traversal Guards

Because the synchronizer takes paths from JSON configuration files and writes to the filesystem, it implements strict path sanitization:
1. **Refusal of Symlinks:** Rejects any target path or intermediate directory that resolves to a symbolic link, preventing symlink overwrite attacks.
2. **Checkout Boundary Jail:** Asserts that the normalized target path stays strictly inside the designated repository root (`safePath` check).
3. **Protected Branch Protection:** Enforces that instructions can only be installed on `develop` or feature branches; installing directly onto `stage` or `main` without promotion history is forbidden.
