# Risk methodology, treatment plan and Statement of Applicability

Template status: draft structure for ISO/IEC 27001 Clauses 6.1.2 and 6.1.3.

## 1. Purpose and scope

Describe the repeatable method used to identify, analyse, evaluate, treat and reassess information-security risks within the approved ISMS scope. State whether the approach is asset-, scenario-, process- or objective-based and how supplier risks are included.

## 2. Risk-statement format

Use a consistent statement such as:

> Because `[threat/event]` may exploit `[vulnerability/condition]`, `[information/service/objective]` could suffer `[confidentiality, integrity, availability, legal, operational or reputational consequence]`.

## 3. Likelihood scale

| Score | Label | Organization-specific definition | Evidence/examples |
| --- | --- | --- | --- |
| 1 | Rare | | |
| 2 | Unlikely | | |
| 3 | Possible | | |
| 4 | Likely | | |
| 5 | Almost certain | | |

## 4. Impact scale

| Score | Label | Organization-specific definition across operational, customer, legal, financial and reputational impact |
| --- | --- | --- |
| 1 | Insignificant | |
| 2 | Minor | |
| 3 | Moderate | |
| 4 | Major | |
| 5 | Severe | |

## 5. Calculation and risk bands

Calculation: `[for example, likelihood × impact]`.

| Score/band | Rating | Treatment expectation | Acceptance authority | Review cadence |
| --- | --- | --- | --- | --- |
| | Low | | | |
| | Medium | | | |
| | High | | | |
| | Critical | | | |

The documented calculation must match the way Probo risk scores are actually entered and interpreted.

## 6. Treatment options

| Option | Meaning | Required record |
| --- | --- | --- |
| Mitigate/modify | Reduce likelihood or impact through controls | Measure, owner, target date, expected residual score and evidence gate |
| Avoid | Stop or redesign the activity | Decision, scope/process change and verification |
| Transfer/share | Allocate part of the consequence to another party | Contract, insurance or service arrangement plus retained residual risk |
| Accept/retain | Knowingly retain the current residual risk | Dated acceptance by authorized management, rationale and review/expiry |

## 7. Risk register and treatment plan

| Risk ID | Risk statement | Category | Owner | Inherent L/I/score | Treatment | Controls/measures | Due date | Current residual L/I/score | Target residual L/I/score | Acceptance state | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| | | | | | | | | | | | |

Keep `current residual` and `target residual` separate. A target does not become current merely because the treatment is selected.

## 8. Statement of Applicability

| Annex A control | Applicable? | Inclusion/exclusion justification | Related risks/obligations | Implementation measure | Current state | Evidence | Owner | Review date |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| | | | | | | | | |

Use Probo's dedicated Statement of Applicability entity for final applicability decisions. The Markdown table is a working/approval view, not a substitute for linked control records.

## 9. Review and change triggers

- Planned periodic review: `[cadence]`.
- New or changed service, architecture, data flow, supplier, location or workforce model.
- New obligation or significant interested-party requirement.
- Incident, outage, control failure, vulnerability, audit finding or risk acceptance expiry.
- Material change in threat intelligence or business objectives.

## 10. Approval

| Approval | Name/role | Decision | Date | Reference |
| --- | --- | --- | --- | --- |
| Methodology | | | | |
| Risk register/treatment plan | | | | |
| SoA | | | | |
| Residual-risk acceptance | | | | |
