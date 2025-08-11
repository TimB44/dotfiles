for dir in */; do
  dir="${dir%/}"
  [[ "$dir" == .* ]] && continue

  echo "Stowing: $dir"
  stow "$dir"
done
