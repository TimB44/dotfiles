#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

brew bundle --file="$DOTFILES_DIR/Brewfile"

sync_only=false
if [[ "${1:-}" == "--sync" ]]; then
  sync_only=true
fi

for dir in */; do
  dir="${dir%/}"
  [[ "$dir" == .* ]] && continue

  echo "Stowing: $dir"
  stow "$dir"
done

if [[ "$sync_only" == false ]]; then
  "$DOTFILES_DIR/install-cron.sh"
fi
