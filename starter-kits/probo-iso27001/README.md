# ISO/IEC 27001 starter kit for Probo

This kit translates the strongest structural ideas from Comp AI into reusable Markdown designed for a Probo implementation. It is a starting point, not a declaration of conformity and not operating evidence.

This starter kit is distributed under the [GNU Affero General Public License v3.0](LICENSE). See [provenance and adaptation notes](PROVENANCE.md).

## Core rules

- Replace every placeholder with verified organization facts.
- Keep drafts, plans, targets and completed records visibly separate.
- Never mark a control, measure, task, risk treatment or audit complete without attributable objective evidence.
- Do not publish documents or request approvals until management has reviewed the exact content.
- Record non-applicability with a reason grounded in scope, risk, law or contract.
- Preserve dates, owners, source links, approvals, changes and superseded decisions.

## Recommended order

1. Complete [the organization discovery questionnaire](00-organization-discovery-questionnaire.md).
2. Draft the Clause 4 and 5 documents (`01` to `04`).
3. Define the risk method, populate risks and prepare the SoA (`05`).
4. Approve measurable objectives and monitoring (`06` and `07`).
5. Configure the internal-audit and management-review cycle (`08` and `09`).
6. Populate the operational evidence registers (`10`).
7. Use [the Probo MCP import map](11-probo-mcp-import-map.md) to create and link Probo entities.
8. Obtain approval, publish controlled versions, operate the controls and retain results.

## Files

| File | Primary ISO/IEC 27001 area | Intended Probo use |
| --- | --- | --- |
| [Organization discovery questionnaire](00-organization-discovery-questionnaire.md) | Clauses 4–10 and Annex A | Source questionnaire; keep local until reviewed |
| [Context of organization](01-context-of-organization.md) | 4.1 | `GOVERNANCE` document |
| [Interested parties and requirements](02-interested-parties-and-requirements.md) | 4.2 | `REGISTER` document plus Probo obligations |
| [ISMS scope](03-isms-scope.md) | 4.3 | `GOVERNANCE` document |
| [Leadership, roles and authorities](04-leadership-roles-and-authorities.md) | 5.1 and 5.3 | `GOVERNANCE` document plus Probo profiles |
| [Risk methodology, treatment and SoA](05-risk-methodology-treatment-and-soa.md) | 6.1.2 and 6.1.3 | `GOVERNANCE` document, risks, treatments and SoA |
| [Information-security objectives](06-information-security-objectives.md) | 6.2 | `PLAN` document plus measures |
| [Monitoring, measurement and analysis](07-monitoring-measurement-analysis.md) | 9.1 | `PROCEDURE` document plus measures/tasks |
| [Internal-audit programme and report](08-internal-audit-programme-and-report.md) | 9.2 | `PROCEDURE` template, audit record and findings |
| [Management-review procedure and minutes](09-management-review-procedure-and-minutes.md) | 9.3 | `PROCEDURE` or `RECORD` document |
| [Operational evidence registers](10-operational-evidence-registers.md) | Risk-based Annex A evidence | Registers, measures, tasks and evidence attachments |
| [Probo MCP import map](11-probo-mcp-import-map.md) | Probo implementation | MCP workflow and entity-linking map |

## Probo structure

Use the relationship below rather than treating document creation as completion:

```text
Framework requirement/control
  -> approved document defining intent
  -> measure defining how the control operates
  -> task assigning implementation or recurring work
  -> objective evidence showing the work happened
  -> finding/corrective action where the result failed
  -> internal audit and management review evaluating effectiveness
```

## Suggested document control header

Add this table to every controlled document before importing it:

| Field | Value |
| --- | --- |
| Legal entity | `[legal entity]` |
| ISMS scope | `[scope reference]` |
| Owner | `[name and role]` |
| Approver | `[name and role]` |
| Classification | `[INTERNAL / CONFIDENTIAL / other]` |
| Version | `0.1 DRAFT` |
| Effective date | `[only after approval]` |
| Review frequency | `[frequency and event triggers]` |
| Next review | `[date]` |
| Related risks | `[Probo risk IDs after import]` |
| Related controls | `[Probo control IDs after import]` |

## What this kit deliberately excludes

- Generic QMS or ISO 9001 language.
- CCPA, GPC, children, payment-card, health-data or other regime-specific content without an applicability decision.
- Claims that a provider feature is configured merely because the provider offers it.
- Universal requirements for background checks, external penetration tests or employee performance reviews.
- Boilerplate stating there were no incidents, findings or exceptions without a dated review record.

See [provenance and adaptation notes](PROVENANCE.md).
