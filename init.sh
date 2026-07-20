#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

sync_only=false
if [[ "${1:-}" == "--sync" ]]; then
  sync_only=true
fi

if ! brew bundle check --file="$DOTFILES_DIR/Brewfile"; then
  brew bundle --file="$DOTFILES_DIR/Brewfile"
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
