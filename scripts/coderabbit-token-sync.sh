#!/bin/bash
set -euo pipefail

token_file="$HOME/.config/coderabbit/token"
token_dir="$(dirname "$token_file")"

if ! command -v secret-tool >/dev/null 2>&1; then
    echo "secret-tool not found. Please install libsecret-tools." >&2
    exit 1
fi

mkdir -p "$token_dir"

if [ -s "$token_file" ]; then
    token="$(cat "$token_file")"
    printf '%s' "$token" | secret-tool store --label='CodeRabbit CLI Token' \
        service '@coderabbitai/cli' account 'accessToken' xdg:schema 'com.oven-sh.bun.Secret' >/dev/null
    exit 0
fi

token="$(secret-tool lookup service '@coderabbitai/cli' account 'accessToken' xdg:schema 'com.oven-sh.bun.Secret' || true)"
if [ -n "$token" ]; then
    printf '%s' "$token" > "$token_file"
    chmod 600 "$token_file"
fi
