#!/usr/bin/env bash
# Package interview-intel skill for GitHub / manual install
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="${1:-1.2.0}"
OUT="${SCRIPT_DIR}/dist/interview-intel-v${VERSION}.zip"
STAGE="${SCRIPT_DIR}/.pack-staging/interview-intel"

rm -rf "${SCRIPT_DIR}/.pack-staging"
mkdir -p "${STAGE}/references" "${STAGE}/examples" "${SCRIPT_DIR}/dist"

cp "${SCRIPT_DIR}/SKILL.md" "${STAGE}/"
cp "${SCRIPT_DIR}/references/"*.md "${STAGE}/references/"
cp "${SCRIPT_DIR}/examples/"*.md "${STAGE}/examples/"
cp "${SCRIPT_DIR}/install.sh" "${SCRIPT_DIR}/README.md" "${SCRIPT_DIR}/LICENSE" "${STAGE}/"
chmod +x "${STAGE}/install.sh"

rm -f "${OUT}"
(cd "${SCRIPT_DIR}/.pack-staging" && zip -rq "${OUT}" interview-intel)
rm -rf "${SCRIPT_DIR}/.pack-staging"

echo "Created: ${OUT}"
ls -lh "${OUT}"
