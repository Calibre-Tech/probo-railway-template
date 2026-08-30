#!/bin/sh

set -eu

key_path="${PROBOD_OAUTH2_SERVER_SIGNING_KEY_PATH:-/data/oauth2-server-signing-key.pem}"
original_entrypoint="${PROBO_ORIGINAL_ENTRYPOINT:-/usr/local/bin/entrypoint.sh}"
starter_kit_source="${PROBO_ISO27001_STARTER_KIT_SOURCE:-/opt/probo-starter-kits/probo-iso27001}"
starter_kit_path="${PROBO_ISO27001_STARTER_KIT_PATH:-/data/starter-kits/probo-iso27001}"

if [ -d "$starter_kit_source" ] && [ ! -e "$starter_kit_path" ] && [ ! -L "$starter_kit_path" ]; then
    starter_kit_parent=$(dirname "$starter_kit_path")
    starter_kit_tmp="${starter_kit_path}.tmp.$$"
    mkdir -p "$starter_kit_parent" "$starter_kit_tmp"
    trap 'rm -rf "$starter_kit_tmp"' EXIT HUP INT TERM
    cp -R "$starter_kit_source"/. "$starter_kit_tmp"/
    mv "$starter_kit_tmp" "$starter_kit_path"
    trap - EXIT HUP INT TERM
    echo "Seeded the ISO/IEC 27001 starter kit at $starter_kit_path."
fi

if [ -z "${PROBOD_OAUTH2_SERVER_SIGNING_KEY:-}" ]; then
    key_dir=$(dirname "$key_path")
    mkdir -p "$key_dir"

    if [ ! -s "$key_path" ]; then
        tmp_key="${key_path}.tmp.$$"
        trap 'rm -f "$tmp_key"' EXIT HUP INT TERM
        umask 077
        openssl genpkey \
            -algorithm RSA \
            -pkeyopt rsa_keygen_bits:2048 \
            -out "$tmp_key" \
            >/dev/null 2>&1
        mv "$tmp_key" "$key_path"
        trap - EXIT HUP INT TERM
        echo "Generated persistent OAuth2 signing key."
    fi

    PROBOD_OAUTH2_SERVER_SIGNING_KEY=$(cat "$key_path")
    export PROBOD_OAUTH2_SERVER_SIGNING_KEY
fi

exec "$original_entrypoint" "$@"
