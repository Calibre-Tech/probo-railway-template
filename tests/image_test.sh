#!/bin/sh

set -eu

image="${1:-probo-railway-template:test}"
volume="probo-railway-template-test-$$"
trap 'docker volume rm -f "$volume" >/dev/null 2>&1 || true' EXIT HUP INT TERM

docker volume create "$volume" >/dev/null

docker run --rm \
    --mount "type=volume,source=$volume,target=/data,volume-nocopy" \
    -e PROBO_ORIGINAL_ENTRYPOINT=/bin/sh \
    "$image" \
    -c '
        test "$(id -u)" = "1001"
        test -w /data
        test "$PROBOD_OPENAI_API_KEY" = "mcp-only-not-a-real-openai-key"
        test -f /data/starter-kits/probo-iso27001/README.md
        test -f /data/starter-kits/probo-iso27001/11-probo-mcp-import-map.md
        openssl rsa -in /data/oauth2-server-signing-key.pem -check -noout >/dev/null 2>&1
        test "$(stat -c %a /data/oauth2-server-signing-key.pem)" = "600"
        printf "%s\n" "# Operator customization" > /data/starter-kits/probo-iso27001/README.md
    '

docker run --rm \
    --mount "type=volume,source=$volume,target=/data,volume-nocopy" \
    -e PROBO_ORIGINAL_ENTRYPOINT=/bin/sh \
    "$image" \
    -c 'test "$(cat /data/starter-kits/probo-iso27001/README.md)" = "# Operator customization"'

echo "image tests passed"
