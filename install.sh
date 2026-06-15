#!/usr/bin/env bash
# Install interview-intel Agent Skill for Cursor, Claude Code, and OpenAI Codex
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_NAME="interview-intel"

usage() {
  cat <<EOF
Usage: $(basename "$0") [all|cursor|claude|codex]

  all     Install to Cursor + Claude Code + Codex (default)
  cursor  ~/.cursor/skills/${SKILL_NAME}/
  claude  ~/.claude/skills/${SKILL_NAME}/
  codex   ~/.agents/skills/${SKILL_NAME}/ and ~/.codex/skills/${SKILL_NAME}/
EOF
}

install_to() {
  local target="$1"
  local label="$2"

  echo "→ ${label}: ${target}"

  if [[ -d "${target}" ]]; then
    echo "  backup: ${target}.bak"
    rm -rf "${target}.bak"
    mv "${target}" "${target}.bak"
  fi

  mkdir -p "${target}/references" "${target}/examples"
  cp "${SCRIPT_DIR}/SKILL.md" "${target}/"
  cp "${SCRIPT_DIR}/references/"*.md "${target}/references/"
  cp "${SCRIPT_DIR}/examples/agent-engineer.md" "${target}/examples/"
  echo "  ok"
}

install_cursor() { install_to "${HOME}/.cursor/skills/${SKILL_NAME}" "Cursor"; }
install_claude()  { install_to "${HOME}/.claude/skills/${SKILL_NAME}" "Claude Code"; }
install_codex() {
  install_to "${HOME}/.agents/skills/${SKILL_NAME}" "Codex (~/.agents/skills)"
  install_to "${HOME}/.codex/skills/${SKILL_NAME}" "Codex (~/.codex/skills)"
}

TARGET="${1:-all}"
case "${TARGET}" in
  all)    install_cursor; install_claude; install_codex ;;
  cursor) install_cursor ;;
  claude) install_claude ;;
  codex)  install_codex ;;
  -h|--help) usage; exit 0 ;;
  *) echo "Unknown: ${TARGET}" >&2; usage; exit 1 ;;
esac

echo ""
echo "Done. Usage examples:"
echo "  用 interview-intel，岗位：Agent 开发，公司范围：不限"
echo "  搜面经，岗位：后端，只看中小厂"
