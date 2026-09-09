#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 0 ]; then
  echo "Usage: $0"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTBOT_DIR="dotbot"
DOTBOT_BIN="bin/dotbot"

cd "$BASE_DIR"
git -C "$DOTBOT_DIR" submodule sync --quiet --recursive
git submodule update --init --recursive "$DOTBOT_DIR"

"$BASE_DIR/$DOTBOT_DIR/$DOTBOT_BIN" -d "$BASE_DIR" -c install.cachyos.conf.yaml
