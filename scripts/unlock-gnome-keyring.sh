#!/bin/bash
set -euo pipefail

if [ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ] || [ -z "${GNOME_KEYRING_CONTROL:-}" ]; then
    echo "DBus/Keyring環境が未初期化です。次を実行してから再実行してください:" >&2
    echo "  eval \"\$($HOME/.local/bin/start-gnome-keyring)\"" >&2
    exit 1
fi

printf "Keyring password: " >&2
IFS= read -r -s pass
printf "\n" >&2
printf '%s' "$pass" | gnome-keyring-daemon --unlock >/dev/null
unset pass
