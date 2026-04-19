#!/bin/bash

set -euo pipefail

skills_source_dir="${1:-$HOME/dotfiles/agents/skills}"
skills_target_dir="${2:-$HOME/.claude/skills}"

mkdir -p "$skills_target_dir"

if [ ! -d "$skills_source_dir" ]; then
    echo "Skipping Claude skills linking ($skills_source_dir not found)"
    exit 0
fi

for skill_dir in "$skills_source_dir"/*; do
    [ -d "$skill_dir" ] || continue
    ln -sfn "$skill_dir" "$skills_target_dir/$(basename "$skill_dir")"
done

echo "Claude skills have been linked from $skills_source_dir to $skills_target_dir"
