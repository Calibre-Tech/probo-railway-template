# Probo on Railway

A Railway-ready wrapper and template specification for self-hosting [Probo](https://github.com/getprobo/probo).

[Deploy Probo — Latest on Railway](https://railway.com/deploy/probo-fixed-and-pinned)

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

The Railway template creates Probo, PostgreSQL, Bucket, and headless Chrome services without asking for an OpenAI key. When no key is configured, the wrapper supplies a clearly non-secret placeholder solely because Probo v0.271.0 initializes its default agent during startup. The application and MCP remain available, while built-in AI features will fail until an operator adds a real provider key.

### EU-first deployment

Railway templates inherit the deployer's preferred region; Railway's template composer cannot force a region for every user. Before deploying, set **Account Settings → Preferred Region** to **EU West Metal (Amsterdam, Netherlands)**. Do this before the project is created because the Railway Bucket region is immutable.

After deployment, verify that Probo, PostgreSQL, and Chrome show EU West in their service settings and that the Bucket settings show EU West. The attached Probo and PostgreSQL volumes follow their services' region. Users can deliberately choose another Railway region by changing their preferred region before deployment.

After deployment:

1. Open the generated Probo domain and create the first account.
2. Connect Codex to `https://<public-domain>/api/mcp/v1` and allowlist its exact HTTPS client metadata URL.
3. Run the [Codex and Probo MCP onboarding interview](starter-kits/probo-iso27001/00-codex-mcp-onboarding.md). It asks about company context, existing compliance material and its location, appropriate Google Drive/GitHub/other connectors, and scoped Chrome access before proposing the company-context write.
4. Configure SMTP before relying on invitations, password resets, or notifications.
5. Back up PostgreSQL and Bucket data as one recovery point. The `/data` volume contains generated runtime material, including the OAuth2 signing key, but it is not a substitute for database and object-storage backups.
6. Add `PROBOD_OPENAI_API_KEY` only if you want Probo's built-in AI features; it is not needed for Codex-driven MCP workflows.

See [TEMPLATE.md](TEMPLATE.md) for the complete Railway composer configuration.

## ISO/IEC 27001 starter kit

The deployment includes the complete [Probo ISO/IEC 27001 starter kit](starter-kits/probo-iso27001/README.md). On first start, the wrapper copies it to `/data/starter-kits/probo-iso27001` and never overwrites that editable copy on later restarts or upgrades.

Start with the guided [Codex/MCP onboarding interview](starter-kits/probo-iso27001/00-codex-mcp-onboarding.md), then complete the organization discovery questionnaire and follow the [Probo MCP import map](starter-kits/probo-iso27001/11-probo-mcp-import-map.md). The interview inventories existing documents and evidence, asks for the relevant Codex connectors or scoped Chrome access, and prepares a sourced company-context draft for approval. The template does not auto-import records: the map requires a read-only inventory, a proposed manifest, and explicit approval before tenant writes. Draft templates are not evidence of control operation or conformity.

## Updating Probo

Probo only supports the latest release for security fixes. Update the pinned tag and digest in the Dockerfile, review the upstream `probod` changelog, run the tests, then deploy to a staging copy before updating the Railway template.

Do not replace the version with the old GHCR `latest` tag. Railway does not automatically refresh Docker-image templates when a mutable tag changes, and that alias has lagged the actual Probo releases.

## Testing

```sh
./tests/entrypoint_test.sh
docker build -t probo-railway-template:test .
./tests/image_test.sh probo-railway-template:test
```

The tests verify Railway's root-owned volume is handed to the non-root Probo user, the starter kit is seeded once without overwriting operator edits, and the OAuth key is valid, private (`0600`), persistent across restarts, and overridden by an operator-supplied key.

## Licenses

The Railway wrapper is MIT. The Comp AI-informed starter kit is distributed separately under the [GNU Affero General Public License v3.0](starter-kits/probo-iso27001/LICENSE); see its [provenance notes](starter-kits/probo-iso27001/PROVENANCE.md). Probo itself is distributed under its own MIT license.
