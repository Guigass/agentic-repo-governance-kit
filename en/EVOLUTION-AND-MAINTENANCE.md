# Evolving and Maintaining the Kit

This guide directs a read-only-to-approved workflow for reviewing the whole kit and producing an improved new version. Run it when something in the ecosystem changes enough to justify a new release: a new AI model generation, new agent/IDE capabilities, new portable standards, new recurring directives, or accumulated maintenance needs.

The kit is the target here. The same staged safety model the kit applies to other repositories applies to itself: diagnose before planning, plan before changing, and change only after explicit human approval.

## Goal

Produce a next version of the kit that is more accurate, safer, and more proportional than the current one, without breaking the staged safety model or turning optional artifacts into universal requirements.

## When to run this

Trigger this workflow when one or more of the following are true:

- A new AI model generation changes how agents read, sample, or follow prompts.
- New agent/IDE capabilities appear (new Rules/Skills/Agents formats across Cursor, Claude Code, Codex, Copilot, Gemini CLI, or other environments; new portable standards; new subagent mechanisms; new scoping or read-only options).
- A new portable standard emerges or changes (for example, `AGENTS.md` support across Claude Code, Codex, Copilot).
- A new recurring directive is needed (security, testing, privacy, cost-effectiveness, or another concern proven by real usage).
- Feedback from real executions shows a failure mode, ambiguity, or excess bureaucracy.
- The kit's own parity, links, or examples drift from the current repository state.

Do not run this workflow for cosmetic edits; use a normal change instead.

## Preserved principles (non-negotiable while evolving)

- Evidence before conclusions; diagnosis before planning; explicit approval before implementation.
- Current state separated from proposals.
- Proportionality is not permission for omission; an optional artifact is not a universal requirement.
- Do not invent capabilities, formats, or fields the environment does not support; validate against current official docs.
- Preserve what works; avoid duplication; documentation as a navigable system.
- Rules, skills, and agents from observed needs.
- No mutation of production, databases, deploy, or external state.
- Bilingual parity: every change to `en/` is reflected in `pt-BR/`, and vice versa.

## Process

Run the stages in order. Each stage is read-only until the human gate.

### Stage 1 — Kit self-diagnosis (read-only)

Audit the current kit as the target:

- Map every file and its purpose (00–04, READMEs, CHANGELOG, scripts).
- Record the current version tag and the state of pinned URLs.
- Identify what changed in the ecosystem since the last release: new models, new agent/IDE capabilities, new portable standards, new recurring risks.
- Identify kit-level gaps: ambiguities, duplications, excess bureaucracy, broken links, parity drift, examples that no longer match the repo.
- Classify every finding with the evidence model: observed fact, evidence-based inference, not identified in searched scope, requires human validation.
- Prioritize findings P0–P3.
- Produce an artifact named KIT_DIAGNOSIS.
- Do not edit any file.

### Stage 2 — Evolution plan (read-only)

Design the next version:

- For each material finding, propose a concrete change: expand an existing section, add a new section, add a new mode, add a new file, or remove bureaucracy.
- Prefer deepening existing sections over creating parallel ones.
- Condition every new directive on the target context (opt-in, proportional to LEAN/STANDARD/DEEP); never turn an optional artifact into a universal requirement.
- Decide the version bump (see Versioning policy).
- List the exact files and sections affected in `en/` and the matching `pt-BR/` counterparts.
- Produce an artifact named EVOLUTION_PLAN.
- Do not edit any file.

### Mandatory human gate

Present the KIT_DIAGNOSIS and EVOLUTION_PLAN to the human. Show the exact file and action allowlist, the version bump, and the points that still need a decision. Stop. Do not implement until the human explicitly approves the allowlist or an explicit subset. The existence of a plan is not authorization.

### Stage 3 — Implementation

After explicit approval:

1. Implement the approved scope in `en/` and `README.md` first (canonical).
2. Replicate the same changes in `pt-BR/` and `README.pt-BR.md`, keeping exact content and structural parity. Translate mode names consistently with the existing `pt-BR/` convention.
3. Do not change functional behavior of the kit beyond the approved scope.
4. Do not stage, commit, push, or access external systems.

### Stage 4 — Validation

Run the final checks before release:

- Run `scripts/check-parity.sh` (or `scripts/check-parity.ps1` on Windows). It must exit 0.
- Confirm every new section in `en/` has a counterpart in `pt-BR/` at the same insertion point.
- Confirm pinned URLs still resolve to the intended tag (or update them as part of the release).
- Confirm style and tone match the existing files.
- Confirm no change outside the approved scope.
- Produce QA_APPROVED or REQUIRED_CORRECTIONS.

If REQUIRED_CORRECTIONS appear within the approved scope, fix and re-validate once. If a correction widens the scope, stop and ask for new human approval.

### Stage 5 — Release

After QA approval:

1. Update `CHANGELOG.md` under `[Unreleased]` (or a new version section) with the changes, following Keep a Changelog.
2. Decide the new version tag (see Versioning policy).
3. Move `[Unreleased]` entries into the new version section and open a fresh empty `[Unreleased]`.
4. If the release changes prompts that users copy, update the pinned URLs in the READMEs to the new tag.
5. Recommend the commit and tag to the human; do not create them without separate authorization.

## Versioning policy

This kit follows Semantic Versioning:

- **Patch** (`v0.1.0` → `v0.1.1`): fixes, clarifications, link corrections, parity repairs. No new behavior for kit consumers.
- **Minor** (`v0.1.0` → `v0.2.0`): new optional directives, new modes, new sections, new portable standards support. Backward-compatible for existing pinned URLs.
- **Major** (`v0.1.0` → `v1.0.0`): changes that break existing pinned executions (renamed files, renumbered sections, removed stages, changed gate semantics). Requires migrating pinned URLs.

When in doubt, prefer minor over major and patch over minor. A new AI model generation usually warrants minor; a restructured stage model warrants major.

## Release checklist

- [ ] KIT_DIAGNOSIS produced and validated.
- [ ] EVOLUTION_PLAN approved by the human; APPROVED_ALLOWLIST recorded.
- [ ] `en/` and `README.md` updated within the allowlist.
- [ ] `pt-BR/` and `README.pt-BR.md` updated in parity.
- [ ] `scripts/check-parity.sh` and `.ps1` exit 0.
- [ ] Pinned URLs in READMEs point to the intended tag.
- [ ] `CHANGELOG.md` updated; `[Unreleased]` rotated.
- [ ] Version bump decided and consistent with the policy.
- [ ] No commit, push, tag, or external action performed without separate authorization.

## Mandatory closing

After Stage 5, stop. Present the human with the release summary: version bump, CHANGELOG excerpt, files changed, parity confirmation, and the recommended commit and tag commands. Do not execute them without separate authorization.
