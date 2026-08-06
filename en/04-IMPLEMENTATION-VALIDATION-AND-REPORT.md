# Part 4 — Approved Implementation, Validation, and Report

You are responsible for implementing only the documentation and agentic governance plan explicitly approved by the user.

This stage does not authorize functional changes to the application.

## Authorization gate

Before editing any file:

1. Locate the user's explicit approval.
2. Extract from it the exact set of authorized files and actions.
3. Compare the approval with the plans from Parts 2 and 3.
4. Identify rejected, deferred, or conditional items.
5. If the approval is not clear, do not implement. Present the divergence and ask for a decision.

A plan presented by the agent is not approval.

## Implementation Task Preflight

Present a short block:

# Implementation Task Preflight

## Located approval

Briefly cite what was approved.

## File allowlist

List the files that may be created or updated.

## Out-of-scope items

List files, areas, and change types that are forbidden.

## Working tree state

Record pre-existing changes and possible overlaps.

## Risks

Report risks and items that still require care.

## Planned validations

List checks proportional to the change.

Do not edit if there is an unsafe overlap with pre-existing changes that cannot be preserved.

## Implementation rules

- Change only authorized files.
- Do not modify functional source code.
- Do not change dependencies, databases, CI/CD, deployment, or infrastructure to accommodate documentation.
- Do not remove files without specific approval of the path and action.
- Preserve valid existing information.
- Prefer incremental changes over full rewrites.
- Do not erase useful historical context.
- Do not turn inference into fact while writing.
- Do not copy the same knowledge source into docs, rules, skills, and agents.
- Use links or references to the canonical source.
- Do not record secrets, tokens, `.env` values, sensitive private endpoints, or personal data.
- Do not run commands with external effects.
- Do not stage, commit, push, create PRs, releases, or publish without an additional explicit request.

These rules are an application of the canonical principle in `00-HOW-TO-USE.md` (see Preserved principles): no directive in this kit authorizes mutation of production, databases, deploy, or external state; it requires separate human authorization.

## 1. Revalidate before writing

Run a targeted check of the evidence used by the file to be changed:

- confirm that paths and symbols still exist;
- confirm the working tree has not materially changed since the diagnosis;
- confirm the chosen canonical documentation is still appropriate;
- confirm the current syntax of rules, skills, and agents before creating them;
- record any drift that invalidates the plan. In `RE_AUDIT` mode, also record drift between audits — the delta between the current code state and the existing documentation or governance produced by the previous audit.

If the drift materially changes the plan, stop and request new approval.

## 2. Implement the documentation architecture

When creating or updating documents:

- write for the audience defined in the plan;
- preserve navigation and canonical sources;
- cite real paths;
- mark facts, inferences, and questions when the distinction is relevant;
- separate current state from proposals;
- mark unverified commands;
- use diagrams only when approved and evidence-backed;
- include metadata only when it serves a maintenance function;
- avoid empty documents or documents filled with "not identified" without operational usefulness.

## 3. Implement Rules

For each approved rule:

- use the directory, extension, and frontmatter supported by the current version;
- configure activation and scope explicitly;
- keep the content short and actionable;
- reference canonical documentation;
- avoid always-on when a specific scope is sufficient;
- confirm it does not conflict with existing rules;
- do not include unauthorized permissions or actions.

## 4. Implement Skills

For each approved skill:

- use the current structure and frontmatter;
- make the description specific for correct selection;
- define inputs, steps, limits, output, and validation;
- differentiate inspection, recommendation, and execution;
- include human gates for sensitive actions;
- use scripts or assets only if approved and necessary;
- do not duplicate the same skill across multiple roots;
- configure automatic or manual invocation according to the plan and current support.

A skill must never expand the authorization received in the task that invokes it.

## 5. Implement Agents and Router

For each approved agent:

- use the current format and frontmatter;
- define a bounded mission;
- grant minimal tools and permissions;
- use read-only mode by default for analysis and review, when supported;
- make explicit what can and cannot be changed;
- indicate canonical sources and related skills;
- define stopping conditions and human review;
- avoid unexplained overlap.

Create or update the router only if approved. Confirm that all referenced agents and skills actually exist in the implemented plan.

## 6. Validate the implementation

Run only local, safe, and proportional checks.

### Documentation integrity

- cited paths exist or are explicitly marked as external or planned;
- relative links resolve;
- the index reaches the main documents;
- there are no two conflicting canonical sources;
- titles and navigation are consistent;
- current state and proposals are separated;
- commands are proven or marked as unverified;
- uncertainties remain visible.

### Agentic governance

- file and directory names are recognized by the current version;
- frontmatter is valid;
- rules have coherent activation and scope;
- skills have clear triggers and complete procedures;
- agents have clear responsibility and limits;
- the router does not reference nonexistent artifacts;
- there is no relevant duplication between docs, rules, skills, and agents;
- automatic artifacts do not add excessive context without justification.

### Safety

- no secret, token, password, or real environment value was introduced;
- no personal or sensitive data, including PII, was reproduced;
- no destructive command was documented without context, warning, and a human gate;
- no instruction grants autonomy over production or external systems;
- no functional change entered the diff;
- authentication, authorization, payment, and production paths were not weakened or bypassed by the written documentation or governance;
- sensitive data exposure in logs, generated documentation, or reports was checked and flagged.

### Working tree and diff

- review `git status`, when Git is present;
- review the diff of changed files;
- use `git diff --check` or a safe equivalent;
- distinguish this task's changes from pre-existing changes;
- do not revert, format, or include unrelated files.

Do not mark a validation as completed if it was not executed. Explain limitations.

## 7. Commit review, without creating a commit

If Git is present, prepare only a recommendation:

- files belonging to the change;
- suggested split into one or more commits;
- commit message aligned with the observed standard;
- executed validations;
- risks and pending items.

Use Conventional Commits only if the project has no other standard and if it makes sense.

Do not stage or commit without explicit authorization.

## Final report format

# Final Report

## 1. Outcome

Summary of what was implemented and the expected benefit.

## 2. Approved scope

What was authorized and any restrictions.

## 3. Created files

Path and purpose.

## 4. Updated files

Path and change summary.

## 5. Preserved files

List only those relevant to plan decisions, not every inspected file.

## 6. Resulting documentation architecture

Explain navigation, canonical sources, and the separation between current state and proposals.

## 7. Resulting Rules, Skills, and Agents

List only those implemented and their triggers.

## 8. Approved items not implemented

Explain blockers, drift, or limitations.

## 9. Items not created

Record the relevant exclusions that avoided duplication or bureaucracy.

## 10. Executed validations

Commands and summarized results.

## 11. Limitations and human validation

What remains uncertain or depends on external context.

## 12. Maintenance

Events that should trigger updates to each documentation or agentic area.

## 13. Commit recommendation

Files, split, suggested message, and whether it is ready for human review.

## 14. Safety confirmation

Explicitly declare:

- whether there was any functional change;
- whether there was any external access;
- whether there was any removal;
- whether there was any staging or commit;
- whether possible secrets were found;
- whether pre-existing changes were preserved.

## Completion criterion

The task is only complete when:

- all implemented files belong to the approved scope;
- the documentation reflects current evidence;
- rules, skills, and agents have clear usefulness and scope;
- navigation and references were verified;
- risks and limitations are explicit;
- the diff was reviewed;
- no unauthorized functional or external change was made.
