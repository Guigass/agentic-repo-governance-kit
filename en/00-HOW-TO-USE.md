# Prompt Pack — Documentation Architecture and Agentic Governance v2

This pack turns a repository audit into four controlled stages. It preserves the essence of the original prompt — deep analysis, evidence-based documentation, proportionality, safety, and useful governance — without concentrating discovery, planning, and implementation in a single run.

## Goal

Create or improve, when justified by the real project:

- technical and architectural documentation;
- documentation for modules, domain, critical flows, and integrations;
- development, environment, testing, deployment, and troubleshooting guides;
- portable agent instructions (`AGENTS.md`) and environment-specific rules when justified;
- operational, reusable Skills, preferring the open Agent Skills standard;
- specialized Agents and a router, when they bring real benefit;
- mechanisms to keep documentation and governance in sync with the project.

The pack does not authorize functional changes to the application.

## Recommended order

1. Run [01-DISCOVERY-AND-DIAGNOSIS.md](01-DISCOVERY-AND-DIAGNOSIS.md).
2. Review the diagnosis and correct any conclusions.
3. Run [02-DOCUMENTATION-ARCHITECTURE-AND-PLAN.md](02-DOCUMENTATION-ARCHITECTURE-AND-PLAN.md).
4. Run [03-AGENTIC-GOVERNANCE-AND-PLAN.md](03-AGENTIC-GOVERNANCE-AND-PLAN.md).
5. Approve, reject, or adjust the consolidated plan.
6. Only after explicit approval, run [04-IMPLEMENTATION-VALIDATION-AND-REPORT.md](04-IMPLEMENTATION-VALIDATION-AND-REPORT.md).

Parts 2 and 3 can run in the same conversation, but must still not edit any files.

> Pinning for reproducibility: in production, point the raw URLs used to load the kit parts to a specific version tag (for example, `/v1.2.3/en/00-HOW-TO-USE.md`) instead of `main`. See the "Versioning" section in `README.md`.

## Mandatory gates

### Gate 1 — Diagnosis

Part 1 must stop after delivering the diagnosis. It cannot create or change files.

### Gate 2 — Documentation and agentic plan

Parts 2 and 3 must stop after listing exactly what will be created, updated, preserved, or dropped from the plan. The existence of a plan is not authorization to implement it.

### Gate 3 — Explicit approval

Part 4 can only start if the conversation contains an unambiguous approval of the file and action set. Valid examples:

- "Full plan approved. Go ahead and implement."
- "Only items P0 and P1 from the table are approved."
- "You may update the three listed files, but do not create agents."

Phrases like "continue", "look at this", or "do your best" do not replace a clear approval when the plan still contains material choices.

## How to carry context between conversations

If each part runs in a different conversation, provide the next stage with:

- the final diagnosis from Part 1;
- corrections made by the human reviewer;
- the documentation plan from Part 2;
- the governance plan from Part 3;
- the approval decision, with inclusions and exclusions.

You do not need to carry over all intermediate messages.

## Depth modes

The user may state a mode at the start of Part 1:

- `LEAN`: small project or initial investigation;
- `STANDARD`: proportional depth, recommended by default;
- `DEEP`: large, legacy, critical system, or one with multiple deployables.

The mode changes the amount of sampling and traced flows; it does not reduce safety rules nor authorize evidence-free inferences.

## Alternative entrypoint — installable skill

When available, the skill `.agents/skills/repo-governance-audit/` is an alternative to pasting the README bootstrap. It installs itself into the chosen IDE path in the target repo, asks for multi-agent or step-by-step execution, then runs Parts 1–4 with the same gates as this guide. See the "Installable audit skill" section in `README.md`.

## Multi-agent execution

This kit supports multi-agent execution via the one-copy orchestrator described in `README.md`. The orchestrator launches one specialist at a time, waits for its result, and carries the evidence into the next stage. All human gates are preserved: read-only diagnosis and planning, a single mandatory human approval before any file is changed, and a final QA review. See the "One-copy multi-agent orchestrator" section in `README.md` for the full chain and artifact contracts.

Fallback: if the environment does not support real subagents or delegated tasks, run the same roles sequentially in the main agent, keeping every gate intact. Do not pretend subagents were created.

## Preserved principles

- Read before writing.
- Understand before suggesting.
- Separate facts, inferences, absence of evidence, and human questions.
- Do not invent architecture, databases, integrations, tests, or deployment.
- Preserve what works and avoid duplication.
- Treat documentation as a navigable system, not a collection of files.
- Create rules, skills, and agents from observed needs.
- Keep current state separate from future proposals.
- Make coverage, limitations, and risks explicit.
- Review the diff and do not include unrelated changes.
- No directive in this kit authorizes mutation of production, databases, deploy, or external state; it requires separate human authorization.

Proportionality is not permission for omission. When the diagnosis proves a relevant gap or a recurring risk, the plan must present a concrete fix — even a lean one — or objectively justify why no new artifact is appropriate.

## Expected outcome

At the end of the four parts, the project should gain a proportional, traceable, and usable documentation and agentic layer. It should also be clear:

- what was proven;
- what was inferred;
- what remains unknown;
- which artifacts were created and why;
- how they should be maintained;
- what was not created to avoid bureaucracy.
