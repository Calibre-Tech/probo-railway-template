# Codex and Probo MCP onboarding interview

Status: discovery and setup guide only. Do not treat answers, connected sources, or imported drafts as evidence of conformity or control operation.

Use this interview before drafting or importing the ISO/IEC 27001 starter kit. Codex should ask the questions in short groups, record the source of every answer, and distinguish verified facts from assumptions and open questions.

## 1. Confirm the destination

Ask:

1. What is the public URL of the Probo deployment?
2. Which Probo organization should be used? If more than one is visible, show the choices and ask the user to select one.
3. Is this a new implementation, a migration, or an improvement of an existing ISMS?
4. Which standard, edition, certification objective, and target dates apply?

Use the connected Probo MCP read-only to confirm the selected organization and inventory its current context, frameworks, documents, controls, measures, risks, suppliers, obligations, tasks, SoA, audits, profiles, and evidence. Paginate and deduplicate by entity ID.

## 2. Ask for company context

| Question | Answer | Source | Confidence/open question |
| --- | --- | --- | --- |
| Legal entity name, registration number, and trading names | | | |
| Plain-language description of the company | | | |
| Products and services | | | |
| Customers, markets, and countries served | | | |
| Offices, remote-work locations, and hosting regions | | | |
| Approximate employee and contractor population | | | |
| In-scope product, teams, systems, data, and locations | | | |
| Proposed exclusions and dependencies | | | |
| Key cloud, identity, source-control, HR, support, and security services | | | |
| Top management, ISMS owner, policy approver, and technical owner | | | |
| Legal, regulatory, and material contractual requirements | | | |
| Certification target and proposed scope wording | | | |

Do not write this context to Probo immediately. First show the user a concise normalized draft containing verified facts, source links, conflicts, assumptions, and missing answers.

## 3. Inventory existing compliance material

Ask: “What compliance, security, privacy, operational, or audit material already exists, and where is each item kept?”

Cover at least:

- policies, procedures, standards, registers, plans, templates, and approved records;
- risk assessments, treatment plans, SoA, objectives, and control mappings;
- audit reports, findings, corrective actions, management reviews, and certification records;
- training, access reviews, device inventories, vulnerability results, backup/restore tests, incident exercises, supplier reviews, change samples, and monitoring results;
- customer questionnaires, contractual security requirements, DPAs, and legal registers.

Record:

| Material | Status/version | Owner/approver | Location and link/path | Date range | Existing evidence or blank template | Access available |
| --- | --- | --- | --- | --- | --- | --- |
| | | | | | | |

Never infer that a file exists merely because a folder, provider feature, or template name suggests it should.

## 4. Ask for source access

For each location named by the user, ask which access route they want Codex to use:

| Source | Preferred access | Questions to ask |
| --- | --- | --- |
| Google Drive, Docs, Sheets, or Slides | Google Drive connector | Which shared drive/folder or exact links? Is read-only discovery sufficient? |
| GitHub | GitHub repository access already available to Codex, or exact public repository links | Which organizations, repositories, branches, and paths are in scope? Include private repositories only when the user has connected and authorized them. |
| Notion, SharePoint, Slack, or another SaaS | Corresponding Codex connector when available | Which workspace, space, channel, folder, or page is in scope? |
| Local files | Exact files or folders supplied by the user | Which paths are authoritative, and may Codex read them? |
| Web applications without a connector | Chrome access | Which site and signed-in session may Codex inspect? Is access read-only? |

Ask the user to connect or authorize the relevant Codex connector through the product UI. Never ask them to paste passwords, session cookies, OAuth tokens, API keys, or recovery codes into the chat or into a document.

Start with read-only access. Before any upload, edit, message, permission change, invitation, publication, approval, signature, provider configuration, or other consequential action, show the proposed action and obtain the required confirmation.

## 5. Ask for Chrome access

Ask: “May I use your existing Chrome session to inspect the named compliance sources and verify the Probo setup where a connector is unavailable?”

If approved:

- name the specific sites and scope before opening them;
- use the existing signed-in session only for the requested work;
- do not save or expose credentials;
- keep discovery read-only unless the user approves a specific write;
- ask at action time before transmitting sensitive data or performing confirmation-gated browser actions;
- use Chrome to verify the Probo UI after MCP writes, not as a substitute for MCP verification.

If Chrome access is declined, continue with available connectors, supplied files, and the Probo MCP, and list the resulting evidence gaps.

## 6. Prepare the Probo company context

Create a proposed context record with these sections:

1. Organization and products.
2. ISMS purpose and certification objective.
3. Scope, boundaries, exclusions, interfaces, and dependencies.
4. Internal and external issues.
5. Interested parties and material requirements.
6. People, roles, and governance.
7. Technology, data, locations, and key suppliers.
8. Existing compliance programme and document sources.
9. Assumptions, conflicts, unknowns, and decisions required.

For every factual statement, retain a source link or identify the person who supplied it. Mark unverified statements explicitly.

Show the proposed context to the user and ask for approval of the exact draft. After approval:

1. Inspect the connected Probo MCP schema for the current organization-context operation.
2. Update only the selected organization.
3. Re-read the organization context and compare it with the approved draft.
4. Report the organization ID, the fields changed, verification result, and any fields the current MCP cannot represent.
5. Do not create frameworks, documents, controls, risks, suppliers, obligations, tasks, evidence, or SoA decisions until a separate import manifest is reviewed and approved.

## 7. Onboarding output

Finish discovery with:

- selected Probo organization and URL;
- approved company-context draft and source map;
- connected and missing connectors;
- Chrome access decision and permitted sites;
- existing-material inventory, including evidence-versus-template classification;
- conflicts, unknowns, and access gaps;
- proposed read-only review plan;
- proposed Probo import manifest, with writes clearly separated for later approval.

## Copy-paste Codex brief

```text
Onboard this company into the connected Probo instance for an MCP-first ISO/IEC 27001 implementation. Do not ask for an OpenAI API key.

Interview me in short groups. First confirm the Probo URL and organization, then ask for company context, current compliance documents and evidence, their owners and status, and where they are stored. Ask which Codex connectors I can authorize for Google Drive, GitHub, Notion, SharePoint, Slack, local files, or other named sources. Never ask me to paste credentials or tokens. Ask whether you may use my existing Chrome session for specific sources that lack a connector and for Probo UI verification.

Work read-only first. Inventory and ID-deduplicate the selected Probo tenant, inspect only the sources I approve, distinguish operating evidence from templates, and cite the source of every company-context statement. Show me a normalized company-context draft, conflicts, assumptions, gaps, and a proposed import manifest before making writes.

After I approve the exact company-context draft, update only that context through the current Probo MCP schema, re-read it, and report the verification result. Treat document imports, publications, approvals, invitations, control maturity, risk acceptance, completed tasks, evidence uploads, and provider or access changes as separate actions requiring explicit approval.
```
