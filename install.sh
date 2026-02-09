#!/usr/bin/env bash
set -euo pipefail

if [ $# -eq 0 ]; then
  echo "Usage: $0 [cachyos|fedora]"
  exit 1
fi

ENV_NAME="$1"
case "$ENV_NAME" in
  cachyos|fedora) ;;
  *)
    echo "Usage: $0 [cachyos|fedora]"
    exit 1
    ;;
esac

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTBOT_DIR="dotbot"
DOTBOT_BIN="bin/dotbot"

cd "$BASE_DIR"
git -C "$DOTBOT_DIR" submodule sync --quiet --recursive
git submodule update --init --recursive "$DOTBOT_DIR"

configs=("install.conf.yaml")
if [ "$ENV_NAME" = "cachyos" ]; then
  configs+=("install.cachyos.conf.yaml")
else
  configs+=("install.fedora.conf.yaml")
fi

for config in "${configs[@]}"; do
  "$BASE_DIR/$DOTBOT_DIR/$DOTBOT_BIN" -d "$BASE_DIR" -c "$config"
done
