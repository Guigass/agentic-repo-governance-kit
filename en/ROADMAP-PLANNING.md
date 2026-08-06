# Roadmap Planning for a New Feature or System Part

This guide directs a read-only-to-approved workflow for building an evidence-based roadmap to deliver a new feature or a new part of the system. It analyzes the existing project (patterns, architecture, runtime, deployment, and documentation) and produces a wave-based roadmap under `docs/roadmap/<plan-name>/`.

This is a supplementary guide, not one of the numbered Parts. Use Parts 1–4 to audit or govern an existing repository; use `EVOLUTION-AND-MAINTENANCE.md` to evolve the kit itself.

The kit is the instruction source. The target repository is where the feature will live. The same staged safety model applies: analyze before planning, plan before writing, and write only after explicit human approval. This guide produces the roadmap only; it does not implement the feature.

## Goal

Produce a proportional, evidence-based roadmap that breaks a new feature or system part into incremental waves, each with a clear scope, dependencies, acceptance criteria, runtime/deploy footprint, and risks, recorded as files under `docs/roadmap/<plan-name>/`.

## When to use this

Use this when the user wants to plan a new feature or a new part of the system and needs a structured, wave-based roadmap grounded in the real project.

Do not use this for:
- auditing an existing repository (use Parts 1–4);
- evolving the kit itself (use `EVOLUTION-AND-MAINTENANCE.md`);
- implementing the feature (this guide stops at the roadmap).

## Preconditions

Before starting, confirm you have, or will collect:

- an approved `APPROVABLE_DIAGNOSIS` from Part 1, when one already exists in the conversation — reuse it as the primary evidence source and run only a minimal complementary read-only inspection scoped to the feature;
- when no prior diagnosis exists, run the project analysis in Stage 2 from scratch, scoped to the feature and its blast radius;
- any corrections or clarifications the user has already provided;
- additional user restrictions (deadline, stack, runtime, compliance).

Do not restart a full repository sweep when a usable diagnosis already exists. Cite the reused diagnosis where it grounds a roadmap decision.

## Preserved principles (non-negotiable)

- Evidence before conclusions: analyze the real project; do not invent patterns, architecture, runtime, or integrations.
- Diagnosis before planning: understand the current state before proposing waves.
- Explicit approval before writing: roadmap files are written only after the human approves the plan.
- Proportionality is not permission for omission: each wave must have concrete scope and acceptance criteria; an optional artifact is not a universal requirement.
- Current state separated from proposed waves.
- Follow existing project conventions; do not introduce new patterns without justification.
- Preserve what works; avoid duplication; reference canonical documentation instead of copying it.
- No mutation of production, databases, deploy, or external state.
- Bilingual parity of this guide: every change to `en/ROADMAP-PLANNING.md` is reflected in `pt-BR/PLANEJAMENTO-DE-ROADMAP.md`, and vice versa. Roadmap files produced in the target repository are written in the user's chosen delivery language; they are not required to be bilingual.

## Depth modes

The user may state a mode at the start. The mode governs the depth of analysis, the number of waves, and the file structure; it does not reduce safety rules nor authorize evidence-free inferences.

- `LEAN`: small feature or initial exploration. Typically 1–2 waves; minimal file structure.
- `STANDARD`: proportional depth, recommended by default. Typically 2–4 waves; full file structure.
- `DEEP`: large feature, cross-cutting system part, or one with material architectural decisions. 4+ waves when justified by distinct risk or team boundaries; full structure plus optional artifacts when justified.

If not specified, adopt `STANDARD`.

## Mandatory restrictions

- Do not edit, create, move, rename, or delete files until the human gate is passed.
- Do not change functional application code, configuration, databases, infrastructure, or external state.
- Do not install dependencies, run migrations, seeds, deploys, or destructive commands.
- Do not access databases, private APIs, cloud, production, or external services.
- Do not read real `.env` files, private keys, certificates, credentials, or tokens; in environment examples, record variable names only.
- Do not stage, commit, push, create PRs, or access external systems.
- Preserve pre-existing and unrelated changes in the working tree; do not attribute them to this task.
- Do not treat absence of results in a limited search as absolute proof of non-existence.

These restrictions are an application of the canonical principle in `00-HOW-TO-USE.md` (see Preserved principles): no directive in this kit authorizes mutation of production, databases, deploy, or external state; it requires separate human authorization.

## Task Preflight

Before deep analysis, present a short block:

```text
# Task Preflight

## Understood goal
One sentence describing the feature to be roadmapped.

## Initial scope
Root, projects, or areas included and the adopted depth mode.

## Reused evidence
Whether a prior APPROVABLE_DIAGNOSIS is being reused, or analysis will run from scratch.

## Restrictions
Confirm the stage is read-only and cite any additional user restrictions.

## Initial risks
Risks already visible or "no critical risks identified so far".

## Next safe action
Explain the first read-only inspection.
```

The preflight may use minimal inspection to locate the root, instructions, and repository state. It must not pretend to know the architecture before discovery.

## Process

Run the stages in order. Each stage is read-only until the human gate.

### Stage 1 — Context interview (read-only)

Ask the user the minimum questions to define the feature. Proportionality: in `LEAN`, a single short round; in `DEEP`, multiple rounds per area when material gaps remain.

- What is the feature or system part to be built?
- What is the goal and the intended user?
- What is in scope and explicitly out of scope?
- What are the constraints (deadline, stack, runtime, compliance)?
- What does "done" look like (acceptance criteria)?

Record the answers as `FEATURE_BRIEF`. If the user cannot answer yet, propose a minimal draft and ask for confirmation. Do not edit any file.

### Stage 2 — Project analysis (read-only)

Analyze the existing project to ground the roadmap in reality. Reuse the `APPROVABLE_DIAGNOSIS` from Part 1 when it exists; otherwise run this analysis scoped to the feature and its blast radius.

- Architecture and layers: how the code is organized, where the new feature fits.
- Patterns and conventions: naming, structure, error handling, state management, and testing patterns already in use.
- Runtime and deployment: where the project runs — platform, runtime, services, environments, CI/CD, IaC, manifests, and the runbooks/ADRs that document it. Pull patterns and docs from where the project actually runs; do not invent runtime.
- Existing documentation: architecture docs, ADRs, runbooks, and any prior roadmap that informs the plan.
- Dependencies and integrations: libraries, services, and APIs the feature will touch.
- Tests and validation: the test framework present and the coverage baseline.
- Risks and constraints: security, data, production, and compliance boundaries.

Classify every finding with the evidence model:
- **Observed fact** — found directly in the repository; cite path and, when useful, line or symbol.
- **Evidence-based inference** — supported by concrete signals but not explicit; cite evidence and confidence.
- **Not identified in the searched scope** — describe where and how it was searched; avoid the absolute claim "it does not exist".
- **Requires human validation** — a question, ambiguity, or external information that cannot be proven from the repository.

Prioritize findings `P0`–`P3`. Produce an artifact named `PROJECT_ANALYSIS`. When it is a derivative of an existing `APPROVABLE_DIAGNOSIS`, state that explicitly and record only the delta and the feature-specific evidence. Do not edit any file.

### Stage 3 — Roadmap plan (read-only)

Design the wave-based roadmap.

- Decide the plan name: a kebab-case slug used as the folder name under `docs/roadmap/`. Keep it stable; do not rename after creation without approval.
- Break the feature into incremental waves. Each wave must deliver usable, independently verifiable value — not just setup — unless the feature itself is documentation.
- Wave 1 should establish the smallest usable vertical slice or the foundational constraint (for example, the runtime/deploy skeleton) that de-risks later waves.
- For each wave: scope, dependencies on prior waves, acceptance criteria, affected areas, runtime/deploy footprint (services, envs, infra, new runtime requirements), risks, and validation.
- Dependencies must form a directed acyclic graph; no circular dependencies; each wave explicitly lists the prior waves it depends on.
- Reuse existing patterns; flag where a new pattern is needed and justify it.
- Number of waves is proportional to feature size and risk, governed by the depth mode (see Depth modes).

Propose the exact file structure under `docs/roadmap/<plan-name>/`, proportional to the mode:

- `README.md`: overview, goal, scope, wave-status table (planned / in-progress / done / blocked), wave list, and entry points. Required in every mode.
- `context.md`: project analysis summary, patterns, runtime, constraints. Folded into `README.md` in `LEAN`.
- `wave-1.md`, `wave-2.md`, ...: one file per wave with scope, dependencies, acceptance criteria, runtime/deploy footprint, risks, validation.
- Optional, only when justified (do not create empty files):
  - `decisions.md`: lightweight ADR log for roadmap-level decisions (build vs buy, sync vs async, etc.). `DEEP` only, when there are material architectural choices.
  - `risks.md`: when the risk surface is large enough that a dedicated register aids maintenance.
  - `glossary.md`: when the feature introduces domain terms that recur across waves.

Apply the artifact admission test before adding any optional file: state the question it answers, who uses it, its source of truth, and why folding it into `README.md` or a wave file is not enough. If the answer is weak, do not create it.

Produce an artifact named `ROADMAP_PLAN` listing the exact files and a one-line summary of each, plus the wave breakdown and the points that still need a decision. Do not edit any file.

### Mandatory human gate

Present the `FEATURE_BRIEF`, `PROJECT_ANALYSIS`, and `ROADMAP_PLAN` to the human. Show:
- the exact file list under `docs/roadmap/<plan-name>/`;
- the wave breakdown with dependencies and acceptance criteria;
- the runtime/deploy footprint per wave;
- risks, discarded items, and the points that still need a decision.

Stop. Do not write any file until the human explicitly approves the plan or an explicit subset. The user's approval becomes the `APPROVED_ALLOWLIST`; items not mentioned are not authorized. The existence of a plan is not authorization.

### Stage 4 — Roadmap generation

After explicit approval:

1. Create the files under `docs/roadmap/<plan-name>/` exactly as approved, using the approved structure.
2. Write each file following the approved content; do not add waves, files, or scope beyond the `APPROVED_ALLOWLIST`.
3. Cite real paths and evidence from `PROJECT_ANALYSIS`; mark inferences and unverified commands.
4. Keep current state (in `context.md`) separate from proposed waves.
5. Do not change functional application code, production config, or external state.
6. Do not stage, commit, push, or access external systems.
7. Preserve pre-existing and unrelated changes.

### Stage 5 — Validation

Run the final checks:

- Confirm every approved file exists under `docs/roadmap/<plan-name>/` with the approved content.
- Confirm waves are incremental, dependencies form a directed acyclic graph, and each wave delivers usable value.
- Confirm each wave records its runtime/deploy footprint.
- Confirm the file structure is proportional to the mode (no empty optional files, no missing required files).
- Confirm the plan reuses existing patterns and flags new patterns with justification.
- Confirm no functional code, production state, or external system was changed.
- Confirm pre-existing changes were preserved.
- Produce `QA_APPROVED` or `REQUIRED_CORRECTIONS` with evidence.

If `REQUIRED_CORRECTIONS` appear within the `APPROVED_ALLOWLIST`, fix and re-validate once. If a correction widens the scope, stop and ask for new human approval.

## Mandatory closing

After Stage 5, stop. Present the human with the roadmap summary: plan name, file tree under `docs/roadmap/<plan-name>/`, wave list with status, and the recommended next step (for example, starting wave 1). Do not start implementing the feature; this guide produces the roadmap only.

Finish by stating:

"Roadmap planning completed in read-only-to-approved mode. Only the approved files under `docs/roadmap/<plan-name>/` were created. No functional code or external state was changed. The next stage is implementation of wave 1, under separate authorization."

Stop and wait.
