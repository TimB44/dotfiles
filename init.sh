#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

sync_only=false
if [[ "${1:-}" == "--sync" ]]; then
  sync_only=true
fi

if [[ "$sync_only" == false ]]; then
  sudo apt-get update
fi

apt_packages=()
while IFS= read -r package; do
  [[ -z "$package" || "$package" == \#* ]] && continue
  apt_packages+=("$package")
done < "$DOTFILES_DIR/Aptfile"

missing_apt_packages=()
for package in "${apt_packages[@]}"; do
  if ! dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q 'install ok installed'; then
    missing_apt_packages+=("$package")
  fi
done

if (( ${#missing_apt_packages[@]} > 0 )); then
  sudo apt-get install -y "${missing_apt_packages[@]}"
fi

while read -r package confinement; do
  [[ -z "$package" || "$package" == \#* ]] && continue
  if ! snap list "$package" >/dev/null 2>&1; then
    if [[ "${confinement:-}" == "classic" ]]; then
      sudo snap install "$package" --classic
    else
      sudo snap install "$package"
    fi
  fi
done < "$DOTFILES_DIR/Snapfile"

for dir in */; do
  dir="${dir%/}"
  [[ "$dir" == .* ]] && continue

  echo "Stowing: $dir"
  stow "$dir"
done

if [[ "$sync_only" == false ]]; then
  "$DOTFILES_DIR/install-cron.sh"
fi
