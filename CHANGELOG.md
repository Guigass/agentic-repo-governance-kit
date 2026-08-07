# Changelog

All notable changes to this kit are documented here. The canonical version is English; per-release bilingual entries are optional.

This project adheres to [Semantic Versioning](https://semver.org/), and this changelog follows [Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

## [v1.4.1] - 2026-08-07
### Added
- Copy-paste install prompt in both READMEs (Option A under Step 1): the agent fetches the pinned skill and writes it into the target repo at the chosen IDE path.

### Changed
- Bootstrap, orchestrator, skill, and install-prompt pinned raw URLs to `/v1.4.1/`.

### Migration
- Pinned executions against `v1.4.0` remain valid on that tag.
- New executions should point raw URLs at `/v1.4.1/`.

## [v1.4.0] - 2026-08-07
### Added
- Mode selection in the installable audit skill: `full-audit` (Parts 1–4), `update` (incremental refresh of existing docs, rules, skills, and agents via the kit's `RE_AUDIT` drift delta; new `references/update-mode.md`), and `install-only` (install/refresh the skill without auditing). The skill scans the target first, recommends a default mode, and skips questions already answered in the invocation.
- Smart install in the skill: detects an existing install under any known root, skips it when current, and refreshes it when outdated; the IDE question is asked only when needed.

### Changed
- `update` mode always runs step-by-step in the main agent (bounded delta scope); the multi-agent question applies to `full-audit` only.
- READMEs and Part 0 describe the new skill modes and question flow.
- Bootstrap, orchestrator, and skill pinned raw URLs to `/v1.4.0/`.

### Migration
- Pinned executions against `v1.3.0` remain valid on that tag.
- New executions should point raw URLs at `/v1.4.0/`.

## [v1.3.0] - 2026-08-06
### Added
- Governance cleanup pass in the installable audit skill (`references/governance-cleanup.md`): when the target already has docs, rules, skills, or agents, Parts 1–3 must plan unify/refactor/remove actions; Part 4 executes only approved path+action items.

### Changed
- Parts 1–4 (en and pt-BR) make cleanup of existing documentation and agentic governance explicit (verdicts, plan actions, allowlist, and final report sections for removals/unifications).
- Bootstrap, orchestrator, and skill pinned raw URLs to `/v1.3.0/`.

### Migration
- Pinned executions against `v1.2.0` remain valid on that tag.
- New executions should point raw URLs at `/v1.3.0/`.

## [v1.2.0] - 2026-08-06
### Added
- Installable audit skill `repo-governance-audit` under `.agents/skills/repo-governance-audit/`: asks for IDE install target (Cursor, Claude Code, Codex, or portable/generic), asks multi-agent vs step-by-step, then runs the full Parts 1–4 kit flow with human gates.
- Step-by-step install and run guide for the skill in both READMEs; alternative entrypoint note in Part 0 (`en/00-HOW-TO-USE.md`, `pt-BR/00-COMO-USAR.md`).

### Changed
- Bootstrap, orchestrator, and skill pinned raw URLs to `/v1.2.0/`.

### Migration
- Pinned executions against `v1.1.0` remain valid on that tag.
- New executions should point raw URLs at `/v1.2.0/`.

## [v1.1.0] - 2026-08-06
### Added
- Part 3 evaluation for a `roadmap-planning` skill: catalog entry, admission criteria, required wave-based procedure (read-only until approval, outputs under `docs/roadmap/<plan-name>/`), and a dedicated item in the governance plan format (`en/03-AGENTIC-GOVERNANCE-AND-PLAN.md`, `pt-BR/03-GOVERNANCA-AGENTICA-E-PLANO.md`).

### Changed
- Bootstrap and orchestrator prompts pinned to `/v1.1.0/`.

### Migration
- Pinned executions against `v1.0.0` remain valid on that tag.
- New executions should point raw URLs at `/v1.1.0/`.

## [v1.0.0] - 2026-08-06
### Added
- Multi-environment capability matrix in Part 3 covering portable layers (`AGENTS.md`, open Agent Skills under `.agents/skills/`) and first-class adapters for Cursor, Claude Code, Codex, GitHub Copilot, and Gemini CLI.
- Environment detection step before proposing governance artifacts.
- Expanded governance inventory in Part 1 (Claude/Codex/Gemini/Copilot paths and `.agents/skills/`).

### Changed
- Renamed Part 3 to `en/03-AGENTIC-GOVERNANCE-AND-PLAN.md` and `pt-BR/03-GOVERNANCA-AGENTICA-E-PLANO.md` (breaking for pinned URLs that pointed at the old filenames).
- Promoted `AGENTS.md` and open Agent Skills from complementary notes to the default portable canonical layer; environment-specific files are adapters that must not duplicate portable content.
- Orchestrator stage renamed from `cursor-governance-architect` to `agent-governance-architect`.
- READMEs, Part 0, Part 4, and evolution guide generalized from Cursor-only wording to multi-environment governance.
- Bootstrap and orchestrator prompts pinned to `/v1.0.0/`.

### Migration
- Pinned executions against `v0.1.0` / `v0.2.0` remain valid on those tags.
- New executions should point raw URLs at `/v1.0.0/` and the renamed Part 3 filenames.
- Existing Cursor-only plans remain valid; Part 3 now asks which environments the team uses and marks unused ones as not applicable.

## [v0.2.0] - 2026-08-06
### Added
- Roadmap planning guide for a new feature or system part (`en/ROADMAP-PLANNING.md`, `pt-BR/PLANEJAMENTO-DE-ROADMAP.md`): a read-only-to-approved workflow that analyzes the existing project (patterns, architecture, runtime, deployment, docs) and produces a wave-based roadmap under `docs/roadmap/<plan-name>/` (overview, context, and one file per wave). Reuses the Part 1 diagnosis when one already exists.
- "Roadmap planning" reference sections in both READMEs.

## [v0.1.0] - 2026-08-06
### Added
- Bilingual structure: canonical `en/` and parity `pt-BR/` (Parts 00–04).
- One-copy multi-agent orchestrator with human gates.
- Security as a permanent concern across Parts 1, 3 and 4.
- Unit testing as a default practice when code is generated.
- `EMPTY_REPO_AUDIT` mode for empty or near-empty repositories.
- `RE_AUDIT` mode for incremental re-audit and drift detection.
- Context interview before the documentation plan (Part 2).
- Cost-effective agent/model routing criteria (Part 3 §8).
- Portable governance with `AGENTS.md` (Part 3 §2.1).
- Measurable baseline in the diagnosis (Part 1 §3.2, §10, §11).
- Personal data / privacy (LGPD/GDPR) mapping (Part 1 §9, Part 3 §10).
- Canonical principle: no production/DB/deploy mutation without human authorization (00).
- `CHANGELOG.md` and tag-pinned URLs for reproducibility.
- `scripts/check-parity.sh` and `scripts/check-parity.ps1` to validate bilingual parity.
