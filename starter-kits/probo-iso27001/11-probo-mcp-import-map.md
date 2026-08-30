# Probo MCP import and linking map

This is an operator guide, not an executable script. Confirm the connected Probo organization and current tool schemas before any write.

## 1. Safe workflow

1. Run [the Codex and Probo MCP onboarding interview](00-codex-mcp-onboarding.md), including existing-material, connector, Chrome-access, and company-context discovery.
2. List organizations and select the intended tenant.
3. Read the organization context and existing frameworks, controls, profiles, documents, measures, risks, suppliers, obligations, tasks, SoA and audits.
4. Paginate every list and deduplicate by entity ID.
5. Inspect only user-approved connected sources, retaining source links and separating evidence from templates.
6. Show the normalized company-context draft and obtain approval before updating the selected organization; re-read it after the write.
7. Compare remaining records by stable meaning and title before creating anything.
8. Prepare a proposed import manifest showing creates, updates, links, owners and rollback.
9. Obtain approval for the proposed writes.
10. Create drafts and planning entities only; do not publish, accept risk, close findings or raise control maturity.
11. Link documents, measures, risks and obligations to relevant controls.
12. Verify the returned IDs and re-list every affected collection.
13. Publish or request approval only after management reviews the exact draft.

## 2. Document import map

| Template | Probo `document_type` | Typical classification | Additional Probo entities |
| --- | --- | --- | --- |
| Context of organization | `GOVERNANCE` | `INTERNAL` | Related risks and obligations |
| Interested parties/requirements | `REGISTER` | `INTERNAL` | `addObligation` for legal/contractual requirements |
| ISMS scope | `GOVERNANCE` | `INTERNAL` | Scope-related tasks/risks |
| Leadership/roles | `GOVERNANCE` | `INTERNAL` | Profiles, owners and role tasks |
| Risk methodology | `GOVERNANCE` | `INTERNAL` | Risks, measures and treatment plan |
| Objectives | `PLAN` | `INTERNAL` | Measures and recurring measurement tasks |
| Monitoring/evaluation | `PROCEDURE` | `INTERNAL` | Measures, tasks and findings |
| Internal audit | `PROCEDURE` initially; `REPORT` for completed result | `CONFIDENTIAL` | Audit and findings |
| Management review | `PROCEDURE` initially; `RECORD` for signed minutes | `CONFIDENTIAL` | Tasks/findings/actions |
| Evidence registers | `REGISTER` or `TEMPLATE` | `CONFIDENTIAL` | Assets, tasks, measures and evidence |

## 3. Core MCP operations

Tool prefixes vary by configured server (`probo`, `probo-eu` or `probo-us`). Relevant operation names include:

- `listOrganizations`, `listFrameworks`, `listControls`, `listDocuments`, `listMeasures`, `listRisks`, `listProfiles`, `listTasks`, `listThirdParties`, `listObligations`, `listAudits` and SoA list/read operations.
- `addDocument` and `updateDocument` for Markdown drafts.
- `addMeasure` for the operational mechanism behind one or more controls.
- `addTask` for assigned implementation or recurring work.
- `addRisk` for current risk state and proposed treatment.
- `addObligation` for applicable legal or contractual requirements.
- `addStatementOfApplicability` and `addApplicabilityStatement` for Annex A decisions.
- `addAudit` for internal/certification audit records.
- `addFinding` for nonconformities, observations and exceptions.
- `linkControl`, `linkMeasure` and `linkRisk` for relationships.
- `publishDocument` only after explicit approval of the exact version and approver configuration.

Where the MCP does not expose an evidence upload operation, attach the file through the Probo UI and use `listMeasureEvidences` to verify the retained result.

## 4. Entity-linking pattern

For each ISO area:

```text
control_id
  <- linkControl(document_id)
  <- linkControl(measure_id)

measure_id
  <- linkMeasure(risk_id)
  <- linkMeasure(document_id)
  <- addTask(measure_id, owner, due date)

risk_id
  <- linkRisk(document_id)
  <- linkRisk(measure_id)
  <- linkRisk(obligation_id) when supported by the current schema
```

Verify every relationship with the corresponding list operation. Do not infer linking success from a write call alone.

## 5. State rules

| Item | Initial truthful state |
| --- | --- |
| New document | Draft, unpublished |
| New measure | `NOT_STARTED` or the server default until implementation begins |
| Task | `TODO` until work starts; `DONE` only after result verification |
| Control maturity | Remains initial until design and operating evidence justify change |
| Risk treatment | Represents selected strategy, not proof the target residual score is achieved |
| SoA | Draft applicability decisions pending management approval |
| Internal audit | Not complete until workpapers, findings, conclusion and sign-off exist |
| Finding | Open until corrective action and effectiveness verification are retained |

## 6. Import manifest

| Local file/entity | Existing Probo ID | Action | New type/state | Owner/approver | Controls to link | Rollback/dependency | Verification result |
| --- | --- | --- | --- | --- | --- | --- | --- |
| | | | | | | | |

## 7. Copy-paste agent brief

```text
Use the connected Probo MCP to prepare an ISO/IEC 27001 implementation from the Markdown starter kit.

Begin with `00-codex-mcp-onboarding.md`: interview me about company context, existing compliance documents and evidence, where they are stored, and which Codex connectors or specific Chrome access I can authorize. Never ask for passwords, tokens, API keys or session data.

First work read-only: confirm the organization, paginate and ID-deduplicate every relevant Probo inventory, inspect only approved sources, compare existing content, and distinguish operating evidence from templates. Show me a sourced company-context draft and proposed import manifest. Do not create, update, publish, approve, sign, accept risk, change control maturity, complete tasks, close findings, launch campaigns, invite people or alter provider settings without my explicit approval.

After I approve the exact company-context draft, update only that context using the current MCP schema, re-read it, and report the verification result. Treat all remaining writes as a separate approval step.

When approved, create only truthful draft/planning entities. Map each framework control to an approved-intent document, an operating measure, assigned tasks, objective evidence, and findings/corrective actions where results fail. Re-list and verify every affected entity and provide IDs plus rollback dependencies. Never treat a template, target, provider claim or selected risk treatment as operating evidence.
```
