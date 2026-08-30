#!/bin/sh

set -eu

key_path="${PROBOD_OAUTH2_SERVER_SIGNING_KEY_PATH:-/data/oauth2-server-signing-key.pem}"
original_entrypoint="${PROBO_ORIGINAL_ENTRYPOINT:-/usr/local/bin/entrypoint.sh}"

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
