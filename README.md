# Probo on Railway

A Railway-ready wrapper and template specification for self-hosting [Probo](https://github.com/getprobo/probo).

[Deploy Probo — Fixed & Pinned on Railway](https://railway.com/deploy/probo-fixed-and-pinned)

The public community template currently points at a stale GHCR `latest` image and omits configuration that current Probo requires. This repository keeps the application on Probo's supported registry, pins a tested release, and generates the required OAuth2 RSA signing key safely on first boot.

## What this fixes

- Uses the immutable digest for `artifact.probo.inc/probo/probo:v0.271.0`, not the stale `ghcr.io/getprobo/probo:latest` alias.
- Uses full `https://` origins for `PROBOD_BASE_URL` and CORS.
- Binds Probo to `0.0.0.0:8080` and targets Railway networking at port `8080`.
- Uses current `PROBOD_*` variable names throughout.
- Generates a unique 2048-bit RSA OAuth2 signing key and persists it on the Probo volume.
- Connects headless Chrome on its upstream port, `9222`.
- Uses Railway variable references for PostgreSQL and Bucket credentials.
- Leaves MCP client allowlisting explicit instead of weakening OAuth registration.
- Ships a Probo-native ISO/IEC 27001 starter kit and seeds an editable copy onto the persistent Probo volume.

## Deploying

The Railway template should create Probo, PostgreSQL, Bucket, and headless Chrome services. It asks only for a real `PROBOD_OPENAI_API_KEY`; current Probo initializes its default agent during startup, so a fake automatic value would make the installation misleadingly partial.

After deployment:

1. Open the generated Probo domain and create the first account.
2. Configure SMTP before relying on invitations, password resets, or notifications.
3. Back up PostgreSQL and Bucket data as one recovery point. The `/data` volume contains generated runtime material, including the OAuth2 signing key, but it is not a substitute for database and object-storage backups.
4. To connect an MCP client, use `https://<public-domain>/api/mcp/v1` and allowlist its exact HTTPS client metadata URL.

See [TEMPLATE.md](TEMPLATE.md) for the complete Railway composer configuration.

## ISO/IEC 27001 starter kit

The deployment includes the complete [Probo ISO/IEC 27001 starter kit](starter-kits/probo-iso27001/README.md). On first start, the wrapper copies it to `/data/starter-kits/probo-iso27001` and never overwrites that editable copy on later restarts or upgrades.

Start with the organization discovery questionnaire, review every placeholder against verified facts, then follow the [Probo MCP import map](starter-kits/probo-iso27001/11-probo-mcp-import-map.md). The template does not auto-import records: the map requires a read-only inventory, a proposed manifest, and explicit approval before tenant writes. Draft templates are not evidence of control operation or conformity.

## Updating Probo

Probo only supports the latest release for security fixes. Update the pinned tag and digest in the Dockerfile, review the upstream `probod` changelog, run the tests, then deploy to a staging copy before updating the Railway template.

Do not replace the version with the old GHCR `latest` tag. Railway does not automatically refresh Docker-image templates when a mutable tag changes, and that alias has lagged the actual Probo releases.

## Testing

```sh
./tests/entrypoint_test.sh
docker build .
```

The test verifies that the starter kit is seeded once without overwriting operator edits, and that the OAuth key is valid, private (`0600`), persistent across restarts, and overridden by an operator-supplied key.

## Licenses

The Railway wrapper is MIT. The Comp AI-informed starter kit is distributed separately under the [GNU Affero General Public License v3.0](starter-kits/probo-iso27001/LICENSE); see its [provenance notes](starter-kits/probo-iso27001/PROVENANCE.md). Probo itself is distributed under its own MIT license.
