#!/usr/bin/env bash
set -euo pipefail

CONFIG_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}"
SETTINGS_FILE="$CONFIG_ROOT/noctalia/settings.json"

if [[ ! -f "$SETTINGS_FILE" ]]; then
    echo "Noctalia has not created $SETTINGS_FILE yet; skipping its terminal setup."
    exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
    echo "jq is required to configure Noctalia." >&2
    exit 1
fi

if jq -e '
    .appLauncher.terminalCommand == "foot -e"
    and ((.appLauncher.pinnedApps // []) | index("foot") != null)
' "$SETTINGS_FILE" >/dev/null; then
    exit 0
fi

BACKUP_FILE="${SETTINGS_FILE}.pre-dotfiles-$(date +%Y%m%d%H%M%S)"
TEMP_FILE="$(mktemp "${SETTINGS_FILE}.tmp.XXXXXX")"
trap 'rm -f "$TEMP_FILE"' EXIT

cp -- "$SETTINGS_FILE" "$BACKUP_FILE"
jq '
    .appLauncher = (.appLauncher // {})
    | .appLauncher.terminalCommand = "foot -e"
    | .appLauncher.pinnedApps = (
        (.appLauncher.pinnedApps // [])
        | if index("foot") == null then . + ["foot"] else . end
    )
' "$SETTINGS_FILE" > "$TEMP_FILE"
mv -- "$TEMP_FILE" "$SETTINGS_FILE"
trap - EXIT
