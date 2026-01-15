#!/bin/bash
set -euo pipefail

if [ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ] && command -v dbus-launch >/dev/null 2>&1; then
    eval "$(dbus-launch --sh-syntax)"
fi

if [ -z "${XDG_RUNTIME_DIR:-}" ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi

_kr=$(gnome-keyring-daemon --replace --components=secrets 2>/dev/null \
    | awk -F= '/^GNOME_KEYRING_CONTROL=/{print $2}' | tail -n1)
if [ -n "${_kr:-}" ]; then
    export GNOME_KEYRING_CONTROL="$_kr"
fi
unset _kr

keyring_dir="$HOME/.local/share/keyrings"
mkdir -p "$keyring_dir"
if [ ! -f "$keyring_dir/default" ]; then
    echo "login" > "$keyring_dir/default"
    chmod 600 "$keyring_dir/default"
fi

# headless fallback: loginが使えない場合はsessionをdefaultにする
if command -v gdbus >/dev/null 2>&1; then
    _locked=$(gdbus call --session --dest org.freedesktop.secrets \
        --object-path /org/freedesktop/secrets/collection/login \
        --method org.freedesktop.DBus.Properties.Get \
        org.freedesktop.Secret.Collection Locked 2>/dev/null || true)
    if [ -z "$_locked" ] || echo "$_locked" | grep -q "<true>"; then
        gdbus call --session --dest org.freedesktop.secrets \
            --object-path /org/freedesktop/secrets \
            --method org.freedesktop.Secret.Service.SetAlias \
            default /org/freedesktop/secrets/collection/session >/dev/null 2>&1 || true
    fi
    unset _locked
fi

printf 'export DBUS_SESSION_BUS_ADDRESS=%q\n' "${DBUS_SESSION_BUS_ADDRESS:-}"
printf 'export XDG_RUNTIME_DIR=%q\n' "${XDG_RUNTIME_DIR:-}"
if [ -n "${GNOME_KEYRING_CONTROL:-}" ]; then
    printf 'export GNOME_KEYRING_CONTROL=%q\n' "$GNOME_KEYRING_CONTROL"
fi
