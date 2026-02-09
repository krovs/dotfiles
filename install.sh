#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="${1:-cachyos}"
case "$ENV_NAME" in
  cachyos|fedora) ;;
  *)
    echo "Usage: $0 [cachyos|fedora]"
    exit 1
    ;;
esac

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTBOT_DIR="$BASE_DIR/dotbot"
DOTBOT_BIN="$DOTBOT_DIR/bin/dotbot"

if [ ! -x "$DOTBOT_BIN" ]; then
  echo "Dotbot not found. Bootstrapping..."
  if [ -d "$DOTBOT_DIR/.git" ]; then
    git -C "$DOTBOT_DIR" pull --ff-only
  else
    git clone https://github.com/anishathalye/dotbot.git "$DOTBOT_DIR"
  fi
fi

configs=("install.conf.yaml")
if [ "$ENV_NAME" = "cachyos" ]; then
  configs+=("install.cachyos.conf.yaml")
else
  configs+=("install.fedora.conf.yaml")
fi

for config in "${configs[@]}"; do
  "$DOTBOT_BIN" -d "$BASE_DIR" -c "$config"
done
