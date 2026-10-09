#!/usr/bin/env bash
set -euo pipefail

missing=()
for tool in curl fzf fd bat zoxide direnv kubectx kubens aws aws_completer kubectl; do
  command -v "$tool" >/dev/null || missing+=("$tool")
done

# list-profiles and SSO require AWS CLI v2; an existing v1 binary is insufficient.
if command -v aws >/dev/null && [[ "$(aws --version 2>&1)" != aws-cli/2.* ]]; then
  missing+=(aws)
fi

if ((${#missing[@]})); then
  if ! command -v pacman >/dev/null; then
    printf 'Install these Fish dependencies first: %s\n' "${missing[*]}" >&2
    exit 1
  fi
  packages=()
  for tool in "${missing[@]}"; do
    case "$tool" in
      kubens) package=kubectx ;;
      aws|aws_completer) package=aws-cli-v2 ;;
      *) package="$tool" ;;
    esac
    if [[ " ${packages[*]} " != *" $package "* ]]; then
      packages+=("$package")
    fi
  done
  # Refresh package metadata together with a full upgrade to avoid stale URLs
  # and unsupported partial upgrades on Arch/CachyOS.
  sudo pacman -Syu --needed "${packages[@]}"
fi
