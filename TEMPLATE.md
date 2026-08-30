# Railway template specification

This is the source of truth for the Railway template composer.

Published template: <https://railway.com/deploy/probo-fixed-and-pinned>

## Services

### Probo

- Source: this repository
- Dockerfile: `Dockerfile`
- Public networking target port: `8080`
- Healthcheck path: `/`
- Volume mount: `/data`
- First boot seeds the ISO/IEC 27001 starter kit at `/data/starter-kits/probo-iso27001`; later boots preserve operator edits.
- Restart policy: on failure, 10 retries

Variables:

| Name | Value |
| --- | --- |
| `PROBOD_API_ADDR` | `0.0.0.0:8080` |
| `PROBOD_BASE_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` |
| `PROBOD_API_CORS_ALLOWED_ORIGINS` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` |
| `PROBOD_ENCRYPTION_KEY` | `${{secret(43, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/")}}=` |
| `PROBOD_AUTH_COOKIE_SECRET` | `${{secret(43, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/")}}=` |
| `PROBOD_AUTH_PASSWORD_PEPPER` | `${{secret(43, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/")}}=` |
| `PROBOD_TRUST_AUTH_TOKEN_SECRET` | `${{secret(43, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/")}}=` |
| `PROBOD_PG_ADDR` | `${{Postgres.PGHOST}}:${{Postgres.PGPORT}}` |
| `PROBOD_PG_USERNAME` | `${{Postgres.PGUSER}}` |
| `PROBOD_PG_PASSWORD` | `${{Postgres.PGPASSWORD}}` |
| `PROBOD_PG_DATABASE` | `${{Postgres.PGDATABASE}}` |
| `PROBOD_PG_POOL_SIZE` | `100` |
| `PROBOD_AWS_BUCKET` | `${{Bucket.BUCKET}}` |
| `PROBOD_AWS_REGION` | `${{Bucket.REGION}}` |
| `PROBOD_AWS_ENDPOINT` | `${{Bucket.ENDPOINT}}` |
| `PROBOD_AWS_ACCESS_KEY_ID` | `${{Bucket.ACCESS_KEY_ID}}` |
| `PROBOD_AWS_SECRET_ACCESS_KEY` | `${{Bucket.SECRET_ACCESS_KEY}}` |
| `PROBOD_AWS_USE_PATH_STYLE` | `false` |
| `PROBOD_CHROME_DP_ADDR` | `${{Chrome.RAILWAY_PRIVATE_DOMAIN}}:9222` |
| `PROBOD_OAUTH2_SERVER_CIMD_ALLOWED_CLIENT_IDS` | Optional comma-separated HTTPS client metadata URLs |

Do not add `PROBOD_OAUTH2_SERVER_SIGNING_KEY`. The wrapper generates a 2048-bit RSA key on first boot and persists it on `/data`. An operator-supplied value still takes precedence.

### Postgres

- Source: Railway PostgreSQL 18 template (`ghcr.io/railwayapp-templates/postgres-ssl:18`)
- Volume mount: `/var/lib/postgresql/data`
- Keep the database template's generated password and standard `PG*` variables.

### Bucket

- Source: Railway Bucket
- Region: selected by the deployer

New Railway buckets use virtual-hosted addressing, so `PROBOD_AWS_USE_PATH_STYLE` is `false`. Operators migrating an older bucket should use the addressing mode shown on that bucket's Credentials page.

### Chrome

- Source: `chromedp/headless-shell@sha256:b24482ae166e2c67135f5a8ba9575c257efdd8e2fd6b2e931f9d88ede3d72f3b`
- No public networking
- Probo connects over Railway private networking on port `9222`.

## Optional mail variables

- `PROBOD_SMTP_ADDR`
- `PROBOD_SMTP_USER`
- `PROBOD_SMTP_PASSWORD`
- `PROBOD_SMTP_TLS_REQUIRED`
- `PROBOD_MAILER_SENDER_NAME`
- `PROBOD_MAILER_SENDER_EMAIL`

Leave these unset unless the deployer supplies a real mail provider.

## Optional AI variable

- `PROBOD_OPENAI_API_KEY`

Leave this unset for MCP-first operation through Codex. The wrapper injects a non-secret placeholder to satisfy Probo v0.271.0 startup wiring; built-in AI features remain unavailable until a real key is configured.

## MCP

The MCP endpoint is `https://<public-domain>/api/mcp/v1`.

For CIMD clients such as Codex, add each exact HTTPS client metadata document URL to `PROBOD_OAUTH2_SERVER_CIMD_ALLOWED_CLIENT_IDS`. Do not ship a global wildcard.

After connecting Codex, start with `starter-kits/probo-iso27001/00-codex-mcp-onboarding.md`. The guided interview inventories company context and existing compliance material, requests the appropriate Codex connectors or scoped Chrome access, and requires review of the sourced company-context draft before it is written and re-read through the Probo MCP.

## Known upstream behavior

Probo currently defaults its tracing exporter to `localhost:4318`. A missing collector may produce non-fatal OpenTelemetry export errors. This template does not add a paid fourth service only to discard traces.
