#!/bin/sh

set -eu

repo_dir=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
test_dir=$(mktemp -d)
trap 'rm -rf "$test_dir"' EXIT HUP INT TERM

fake_entrypoint="$test_dir/fake-entrypoint.sh"
cat >"$fake_entrypoint" <<'EOF'
#!/bin/sh
printf '%s' "$PROBOD_OAUTH2_SERVER_SIGNING_KEY" >"$CAPTURE_PATH"
printf '%s\n' "$*" >"$ARGS_PATH"
EOF
chmod 0755 "$fake_entrypoint"

key_path="$test_dir/oauth.pem"
capture_path="$test_dir/captured.pem"
args_path="$test_dir/args.txt"
starter_kit_source="$test_dir/starter-kit-source"
starter_kit_path="$test_dir/data/starter-kits/probo-iso27001"

mkdir -p "$starter_kit_source"
printf '%s\n' '# Starter kit' >"$starter_kit_source/README.md"
printf '%s\n' '# Import map' >"$starter_kit_source/11-probo-mcp-import-map.md"

PROBOD_OAUTH2_SERVER_SIGNING_KEY_PATH="$key_path" \
PROBO_ORIGINAL_ENTRYPOINT="$fake_entrypoint" \
PROBO_ISO27001_STARTER_KIT_SOURCE="$starter_kit_source" \
PROBO_ISO27001_STARTER_KIT_PATH="$starter_kit_path" \
CAPTURE_PATH="$capture_path" \
ARGS_PATH="$args_path" \
    "$repo_dir/railway-entrypoint.sh" alpha beta

openssl rsa -in "$key_path" -check -noout >/dev/null 2>&1
openssl rsa -in "$capture_path" -check -noout >/dev/null 2>&1
[ "$(openssl rsa -in "$key_path" -pubout 2>/dev/null | openssl dgst -sha256)" = \
    "$(openssl rsa -in "$capture_path" -pubout 2>/dev/null | openssl dgst -sha256)" ]
[ "$(cat "$args_path")" = "alpha beta" ]
[ "$(stat -c '%a' "$key_path" 2>/dev/null || stat -f '%Lp' "$key_path")" = "600" ]
cmp "$starter_kit_source/README.md" "$starter_kit_path/README.md"
cmp "$starter_kit_source/11-probo-mcp-import-map.md" "$starter_kit_path/11-probo-mcp-import-map.md"

first_hash=$(openssl dgst -sha256 "$key_path")
printf '%s\n' '# Operator customization' >"$starter_kit_path/README.md"

PROBOD_OAUTH2_SERVER_SIGNING_KEY_PATH="$key_path" \
PROBO_ORIGINAL_ENTRYPOINT="$fake_entrypoint" \
PROBO_ISO27001_STARTER_KIT_SOURCE="$starter_kit_source" \
PROBO_ISO27001_STARTER_KIT_PATH="$starter_kit_path" \
CAPTURE_PATH="$capture_path" \
ARGS_PATH="$args_path" \
    "$repo_dir/railway-entrypoint.sh"

[ "$first_hash" = "$(openssl dgst -sha256 "$key_path")" ]
[ "$(cat "$starter_kit_path/README.md")" = "# Operator customization" ]

provided_key="provided-test-key"
rm "$key_path"
PROBOD_OAUTH2_SERVER_SIGNING_KEY="$provided_key" \
PROBOD_OAUTH2_SERVER_SIGNING_KEY_PATH="$key_path" \
PROBO_ORIGINAL_ENTRYPOINT="$fake_entrypoint" \
PROBO_ISO27001_STARTER_KIT_SOURCE="$starter_kit_source" \
PROBO_ISO27001_STARTER_KIT_PATH="$starter_kit_path" \
CAPTURE_PATH="$capture_path" \
ARGS_PATH="$args_path" \
    "$repo_dir/railway-entrypoint.sh"

[ "$(cat "$capture_path")" = "$provided_key" ]
[ ! -e "$key_path" ]

echo "entrypoint tests passed"
