#!/usr/bin/env bash
#
# Installs Jerry's commonly-used pi extensions.
# Safe to re-run; pi will skip already-installed packages.
#
# Usage:
#   bash install.sh          # global install (default)
#   bash install.sh -l       # project-local install
#

set -euo pipefail

LOCAL_FLAG=""
while getopts "l" opt; do
    case "$opt" in
        l) LOCAL_FLAG="-l" ;;
        *) echo "Usage: $0 [-l]" >&2; exit 1 ;;
    esac
done

extensions=(
    "npm:@jerryan/pi-pyvenv"
    "npm:@jerryan/pi-todo-lite"
    "npm:@thinkscape/pi-status"
    "npm:@jerryan/pi-hashline-edit"
    "npm:@jerryan/pi-subagent-lite"
    "npm:@jerryan/pi-bash-wrap"
)

if ! command -v pi &>/dev/null; then
    echo "Error: pi CLI not found on PATH. Install it first: https://pi.dev" >&2
    exit 1
fi

echo "Installing pi extensions..."
for ext in "${extensions[@]}"; do
    echo "  -> $ext"
    # shellcheck disable=SC2086
    pi install $LOCAL_FLAG "$ext" || echo "    WARNING: failed to install $ext"
done

echo ""
echo "Done! Installed extensions:"
pi list
