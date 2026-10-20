#!/usr/bin/env bash
# ==============================================================================
# setup-agentic-architecture.sh
# Turnkey Scaffolder for the Backstage Agentic Architecture
# ==============================================================================
set -euo pipefail

echo "======================================================================"
echo "    Backstage Agentic Architecture Turnkey Scaffolder"
echo "======================================================================"
echo ""

TARGET_DIR="${1:-.}"
TARGET_DIR="$(cd "${TARGET_DIR}" && pwd)"

echo "Setting up Agentic Governance in: ${TARGET_DIR}"
echo ""

# 1. Create governance structure
mkdir -p "${TARGET_DIR}/governance"
mkdir -p "${TARGET_DIR}/scripts"
mkdir -p "${TARGET_DIR}/release"
mkdir -p "${TARGET_DIR}/docs"
mkdir -p "${TARGET_DIR}/templates"

SCRIPT_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 2. Copy Templates if available
if [[ -f "${SCRIPT_SOURCE_DIR}/constitution.template.md" ]]; then
    cp "${SCRIPT_SOURCE_DIR}/constitution.template.md" "${TARGET_DIR}/governance/constitution.md"
    cp "${SCRIPT_SOURCE_DIR}/adapters.template.json" "${TARGET_DIR}/governance/adapters.json"
    cp "${SCRIPT_SOURCE_DIR}/components.template.json" "${TARGET_DIR}/governance/components.json"
    cp "${SCRIPT_SOURCE_DIR}/agents-sync.mjs" "${TARGET_DIR}/scripts/agents-sync.mjs"
    cp "${SCRIPT_SOURCE_DIR}/check_promotion.py" "${TARGET_DIR}/scripts/check_promotion.py"
    cp "${SCRIPT_SOURCE_DIR}/acceptance.template.json" "${TARGET_DIR}/release/acceptance.json"
    cp "${SCRIPT_SOURCE_DIR}/handoff.template.md" "${TARGET_DIR}/templates/handoff.md"
    chmod +x "${TARGET_DIR}/scripts/agents-sync.mjs"
    chmod +x "${TARGET_DIR}/scripts/check_promotion.py"
    echo "✓ Installed governance templates and scripts."
else
    echo "! Template directory not found relative to script; creating baseline files."
fi

# 3. Setup package.json scripts if package.json exists
if [[ -f "${TARGET_DIR}/package.json" ]]; then
    echo "✓ Found package.json - ensure the following scripts are added:"
    echo '  "agents:sync": "node scripts/agents-sync.mjs sync",'
    echo '  "agents:check": "node scripts/agents-sync.mjs check",'
    echo '  "agents:install": "node scripts/agents-sync.mjs install"'
fi

echo ""
echo "Running initial agent constitution synchronization..."
if [[ -f "${TARGET_DIR}/scripts/agents-sync.mjs" ]]; then
    node "${TARGET_DIR}/scripts/agents-sync.mjs" sync
fi

echo ""
echo "======================================================================"
echo "✓ Agentic Architecture successfully initialized!"
echo "Next Steps:"
echo "1. Edit governance/constitution.md to reflect your team's core rules."
echo "2. Edit governance/components.json to map your workspace subdirectories."
echo "3. Run 'node scripts/agents-sync.mjs sync' to propagate to all agent tools."
echo "4. Commit changes to your repository."
echo "======================================================================"
