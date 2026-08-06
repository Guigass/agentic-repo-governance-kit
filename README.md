# Agentic Repository Governance Kit

> 🇧🇷 Versão em português brasileiro: [README.pt-BR.md](README.pt-BR.md)

A modular prompt kit for auditing software repositories, designing maintainable technical documentation, and creating portable agent governance (`AGENTS.md`, open Agent Skills) plus environment-specific adapters for Cursor, Claude Code, Codex, Copilot, Gemini CLI, and similar tools, with explicit safety gates.

The kit is bilingual. English is the canonical version in [`en/`](en/); Brazilian Portuguese is available in [`pt-BR/`](pt-BR/). Both versions are kept in parity, and agents may produce the final report in another language when requested by the user.

## What this kit does

The kit guides an AI agent through four controlled stages:

1. **Read-only discovery and diagnosis** — maps the repository, architecture, critical flows, documentation, dependencies, risks, and coverage limitations.
2. **Documentation architecture planning** — defines what should be preserved, improved, consolidated, or created.
3. **Agentic governance planning** — evaluates project-specific Rules, Skills, Agents, preflight workflows, change management, and routing.
4. **Approved implementation and validation** — changes only the explicitly approved files, reviews the diff, and reports validations and remaining uncertainties.

Planning is not treated as permission to write. The implementation phase requires explicit human approval.

## Files

| English (canonical) | Português (pt-BR) | Purpose | Writes files? |
| --- | --- | --- | --- |
| [`en/00-HOW-TO-USE.md`](en/00-HOW-TO-USE.md) | [`pt-BR/00-COMO-USAR.md`](pt-BR/00-COMO-USAR.md) | Usage guide, execution order, modes, and approval gates | No |
| [`en/01-DISCOVERY-AND-DIAGNOSIS.md`](en/01-DISCOVERY-AND-DIAGNOSIS.md) | [`pt-BR/01-DESCOBERTA-E-DIAGNOSTICO.md`](pt-BR/01-DESCOBERTA-E-DIAGNOSTICO.md) | Repository discovery and evidence-based diagnosis | No |
| [`en/02-DOCUMENTATION-ARCHITECTURE-AND-PLAN.md`](en/02-DOCUMENTATION-ARCHITECTURE-AND-PLAN.md) | [`pt-BR/02-ARQUITETURA-DOCUMENTAL-E-PLANO.md`](pt-BR/02-ARQUITETURA-DOCUMENTAL-E-PLANO.md) | Documentation architecture and exact file plan | No |
| [`en/03-AGENTIC-GOVERNANCE-AND-PLAN.md`](en/03-AGENTIC-GOVERNANCE-AND-PLAN.md) | [`pt-BR/03-GOVERNANCA-AGENTICA-E-PLANO.md`](pt-BR/03-GOVERNANCA-AGENTICA-E-PLANO.md) | Portable and environment-specific Rules, Skills, Agents, and Router planning | No |
| [`en/04-IMPLEMENTATION-VALIDATION-AND-REPORT.md`](en/04-IMPLEMENTATION-VALIDATION-AND-REPORT.md) | [`pt-BR/04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md`](pt-BR/04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md) | Approved implementation, validation, and final report | Only after explicit approval |

## Installable audit skill

When the agent can load Agent Skills, use [`repo-governance-audit`](.agents/skills/repo-governance-audit/SKILL.md) instead of pasting the bootstrap below. Canonical source: [`.agents/skills/repo-governance-audit/`](.agents/skills/repo-governance-audit/).

### Step 1 — Make the skill available (first time)

Clone or download this kit, then copy the folder `.agents/skills/repo-governance-audit/` into a location your IDE already loads:

| Environment | Copy the folder to |
| --- | --- |
| Cursor (personal, all projects) | `~/.cursor/skills/repo-governance-audit/` |
| Cursor (this project only) | `<target-repo>/.cursor/skills/repo-governance-audit/` |
| Claude Code | `<target-repo>/.claude/skills/repo-governance-audit/` |
| Codex / portable / generic | `<target-repo>/.agents/skills/repo-governance-audit/` |

Keep the directory name `repo-governance-audit` and keep `SKILL.md` plus the `references/` folder inside it. Restart or reload the agent session if skills are cached.

Example (from the kit root, Cursor personal install on Windows PowerShell):

```powershell
Copy-Item -Recurse -Force .agents\skills\repo-governance-audit $HOME\.cursor\skills\repo-governance-audit
```

Example (portable install into the target repo):

```bash
cp -R .agents/skills/repo-governance-audit /path/to/target-repo/.agents/skills/repo-governance-audit
```

### Step 2 — Open the repository you want to audit

Open the **target** repository in your IDE (not this kit, unless you explicitly want to audit the kit itself).

### Step 3 — Invoke the skill

In the agent chat, ask for example:

```text
Run the repo-governance-audit skill on this repository.
Respond in English.
```

### Step 4 — Answer the skill questions

The skill stops twice before auditing:

1. **Which IDE to install into?** Reply with one of: `cursor` | `claude` | `codex` | `generic`.  
   The skill then writes itself into the target repo at **one** path only:

   | Choice | Path written in the target repo |
   | --- | --- |
   | `cursor` | `.cursor/skills/repo-governance-audit/` |
   | `claude` | `.claude/skills/repo-governance-audit/` |
   | `codex` | `.agents/skills/repo-governance-audit/` |
   | `generic` | `.agents/skills/repo-governance-audit/` |

2. **Execution mode?** Reply with `multi-agent` or `step-by-step`.  
   - `multi-agent`: one-copy orchestrator with specialists (falls back to sequential roles if the IDE has no real subagents).  
   - `step-by-step`: Parts 1→2→3→4 in the main agent, stopping at each gate.

### Step 5 — Run the audit and respect the gates

After those answers, the skill runs the full kit (Parts 1–4):

1. Review the Part 1 diagnosis; correct facts if needed; continue when ready.
2. Review the documentation plan (Part 2) and governance plan (Part 3).
3. Approve an exact allowlist of files and actions (vague “continue” is not enough).
4. Only then Part 4 implements the approved scope and reports validation.

Until that explicit approval, the audit stays read-only (except the skill files written in Step 4).

## Quick start with a URL

Use this method with an agent that can open public web URLs.

Copy and send the following bootstrap prompt while the agent is working in the repository you want to audit:

```text
Use the Agentic Repository Governance Kit available at:
https://github.com/Guigass/agentic-repo-governance-kit

The repository currently open in your workspace is the TARGET repository. The kit repository is only an instruction source and must not be analyzed as the target.

First, read these files in order:
1. https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/00-HOW-TO-USE.md
2. https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/01-DISCOVERY-AND-DIAGNOSIS.md

Execute only Part 1 now, using READ_ONLY_AUDIT and STANDARD depth.

Requirements:
- Respect all higher-priority user, system, and repository instructions.
- Do not edit, create, move, or delete files.
- Do not install dependencies or access databases, cloud accounts, production, or private external services.
- Support important conclusions with repository paths, symbols, or other concrete evidence.
- Report analyzed, sampled, excluded, and unverified areas.
- Clearly separate observed facts, evidence-based inferences, items not identified in the searched scope, and matters requiring human validation.
- Stop after the diagnosis. Do not continue to planning or implementation until I explicitly request the next part.

Respond in English.
```

For the Portuguese version of this prompt and of the orchestrator, see [README.pt-BR.md](README.pt-BR.md).

## Continue to the next stages

After reviewing and correcting the diagnosis, use the next prompt explicitly.

### Documentation architecture

```text
Continue using the Agentic Repository Governance Kit.

Read and execute only Part 2:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/02-DOCUMENTATION-ARCHITECTURE-AND-PLAN.md

Use the approved diagnosis already present in this conversation. Produce the documentation architecture and exact file plan, but do not modify any files. Stop after the plan.
```

### Agentic governance

```text
Continue using the Agentic Repository Governance Kit.

Read and execute only Part 3:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/03-AGENTIC-GOVERNANCE-AND-PLAN.md

Use the approved diagnosis and documentation plan already present in this conversation. Produce the Rules, Skills, Agents, and Router plan for the approved target environments, but do not modify any files. Stop after the plan.
```

### Approved implementation

Part 4 must only be used after the human has approved an exact file and action list.

```text
The documentation and agentic governance plan has been reviewed.

Approved scope:
[paste the exact approved files and actions here]

Read and execute Part 4 of the Agentic Repository Governance Kit:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/04-IMPLEMENTATION-VALIDATION-AND-REPORT.md

Implement only the approved scope. Preserve unrelated and pre-existing changes. Do not change functional application code. Do not stage, commit, push, publish, or access external systems unless separately authorized.
```

## One-copy multi-agent orchestrator

This option is for environments that support subagents or delegated agent tasks. You paste the prompt once. The orchestrator launches one specialist at a time, waits for its result, and passes the evidence to the next specialist.

The read-only diagnosis and planning stages run without additional prompts. The workflow pauses once for human approval before any file is changed. After approval, continue in the same conversation; you do not need to paste the kit prompts again.

```text
Act as the MAIN ORCHESTRATOR of the Agentic Repository Governance Kit.

Public kit:
https://github.com/Guigass/agentic-repo-governance-kit

The repository currently open in the workspace is the TARGET repository. The kit repository is only an instruction source. Never treat the kit as the audit target and never change the kit repository.

Goal:
Run the kit with multiple specialized agents, in a strictly sequential fashion. Each agent must finish its stage before the next one starts. The orchestrator must wait, validate, and carry the result of one stage into the next.

Configuration:
- Depth: STANDARD
- Delivery language: English
- Stages 1 to 4 execution: read-only
- Writing to the target repository: only after explicit human approval of the consolidated plan
- Commit, push, PR, deploy, and access to external systems: forbidden without separate authorization

Read first:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/00-HOW-TO-USE.md

ORCHESTRATOR RULES

1. Use only the real subagent, delegated task, or multi-agent mechanisms available in the environment. Do not invent tool calls.
2. The ORCHESTRATOR is the sole responsible for starting, waiting for, resuming, or terminating agents.
3. Run specialists sequentially. Do not run two stages in parallel.
4. Do not start the next specialist until you receive a terminal, usable result from the previous one.
5. Each delegated task must be self-contained: include goal, restrictions, the URL of the applicable part, and the necessary previous results.
6. Discovery, planning, and review agents must operate read-only.
7. Only the approved-implementer may write, and only after the human gate.
8. If an agent fails or returns an incomplete result, clarify the task and try to resume it once. If still blocked, stop the chain and report the blockage.
9. Do not let a subagent widen the scope, grant authorization to itself, or treat inference as fact.
10. Respect higher-priority instructions provided by the system, the user, and the target repository.
11. Preserve pre-existing, unrelated changes in the working tree.
12. If the environment does not offer real multi-agent support, clearly state the fallback and run the same roles sequentially in the main agent, keeping all gates. Do not pretend you created subagents.

ARTIFACT CONTRACTS

Validate each delivery against these minimum fields. If any is missing, resume the specialist once before stopping the chain.

- APPROVABLE_DIAGNOSIS: scope and coverage (with sampling ratio per area); repository map; evidence-backed architecture; traced critical flows; documentation and governance inventory; dependency and supply-chain inventory; P0–P3 prioritized findings; explicit separation of facts, inferences, items not identified, and human validation; limitations.
- DOCUMENTATION_PLAN: per-file action table with purpose, audience, source of truth, priority, risk, dependencies, update trigger, and validation; coverage matrix; separation of current state and proposals; items not created with reasons; P0–P3 order.
- GOVERNANCE_PLAN: needs matrix; rules, skills, and agents with trigger, scope, canonical source, authorization limits, and validation; explicit treatment for each recurring P0/P1 risk; discarded items; P0–P3 order.
- CONSOLIDATED_PLAN: exact file and action allowlist; integrity assessment with contradictions, duplications, and excess bureaucracy resolved; confirmation that P0/P1 are treated; confirmation that pre-existing changes are preserved.
- IMPLEMENTATION_COMPLETED: files created/updated within the allowlist; executed validations with commands and results; pending items; confirmation that no functional change was made.

MANDATORY CHAIN

STAGE 1 — repo-discovery-auditor

Start a read-only specialist named repo-discovery-auditor.

Provide it with:
- the current target repository;
- the restrictions in this prompt;
- Part 1 of the kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/01-DISCOVERY-AND-DIAGNOSIS.md

Task:
- fully execute discovery and diagnosis;
- produce evidence, coverage, risks, critical flows, and gaps;
- do not edit any file;
- return a final artifact named APPROVABLE_DIAGNOSIS.

Wait for completion. Validate the diagnosis against the artifact contract. Do not advance if it is materially incomplete.

STAGE 2 — documentation-architect

Only after Stage 1 completes, start a read-only specialist named documentation-architect.

Provide it with:
- the complete APPROVABLE_DIAGNOSIS;
- confirmed factual corrections, if any;
- Part 2 of the kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/02-DOCUMENTATION-ARCHITECTURE-AND-PLAN.md

Task:
- design the proportional documentation architecture;
- define canonical sources and navigation;
- separate current state from proposals;
- list exactly the files to preserve, create, update, consolidate, or not create;
- do not edit any file;
- return a final artifact named DOCUMENTATION_PLAN.

Wait for completion. Validate the plan against the artifact contract.

STAGE 3 — agent-governance-architect

Only after Stage 2 completes, start a read-only specialist named agent-governance-architect.

Provide it with:
- the APPROVABLE_DIAGNOSIS;
- the DOCUMENTATION_PLAN;
- Part 3 of the kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/03-AGENTIC-GOVERNANCE-AND-PLAN.md

Task:
- detect approved target environments and validate their current formats;
- plan portable AGENTS.md and Agent Skills first, then environment-specific adapters only when justified;
- plan Rules, Skills, Agents, and Router only when justified;
- define treatment for recurring P0 and P1 risks;
- avoid duplication with canonical documentation and across environments;
- validate the formats supported by each approved environment;
- do not edit any file;
- return a final artifact named GOVERNANCE_PLAN.

Wait for completion. Validate the plan against the artifact contract.

STAGE 4 — plan-integrity-reviewer

Only after Stage 3 completes, start an independent, read-only reviewer named plan-integrity-reviewer.

Provide it with:
- APPROVABLE_DIAGNOSIS;
- DOCUMENTATION_PLAN;
- GOVERNANCE_PLAN;
- the restrictions in this prompt.

Task:
- find contradictions, duplications, excess bureaucracy, and untreated gaps;
- confirm P0 and P1 have treatment;
- confirm there is no functional change disguised as documentation;
- confirm the plan preserves pre-existing changes;
- produce an exact file and action allowlist;
- return CONSOLIDATED_PLAN and INTEGRITY_ASSESSMENT;
- do not edit any file.

Wait for completion.

MANDATORY HUMAN GATE

After Stage 4:

1. Present the user with a short summary of the diagnosis.
2. Present the CONSOLIDATED_PLAN with the exact file and action allowlist.
3. Show risks, discarded items, and doubts that materially change the plan.
4. Ask for explicit approval.
5. Stop. Do not start implementation while approval is not clear.

Remain ready to continue in this same conversation when the user approves the whole plan or an explicit subset. The user's answer must be turned into the APPROVED_ALLOWLIST. Items not mentioned are not authorized.

STAGE 5 — approved-implementer

After human approval, start a single implementation specialist named approved-implementer.

Provide it with:
- APPROVED_ALLOWLIST;
- APPROVABLE_DIAGNOSIS;
- DOCUMENTATION_PLAN;
- GOVERNANCE_PLAN;
- INTEGRITY_ASSESSMENT;
- Part 4 of the kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v1.2.0/en/04-IMPLEMENTATION-VALIDATION-AND-REPORT.md

Task:
- implement only files and actions present in the APPROVED_ALLOWLIST;
- preserve pre-existing and unrelated changes;
- do not change functional code;
- do not stage, commit, push, create PRs, deploy, or access external systems;
- review the diff;
- return IMPLEMENTATION_COMPLETED, VALIDATIONS_EXECUTED, and PENDING_ITEMS.

Wait for completion.

STAGE 6 — final-qa-reviewer

After implementation, start an independent, read-only reviewer named final-qa-reviewer.

Provide it with:
- APPROVED_ALLOWLIST;
- IMPLEMENTATION_COMPLETED;
- VALIDATIONS_EXECUTED;
- the current diff;
- the validation rules from Part 4.

Task:
- check scope, content, links, paths, frontmatter, and navigation;
- look for duplications, contradictions, possible secrets, and functional changes;
- distinguish this task's changes from pre-existing changes;
- return QA_APPROVED or REQUIRED_CORRECTIONS, with evidence;
- do not edit any file.

Wait for completion.

If there are REQUIRED_CORRECTIONS within the APPROVED_ALLOWLIST, resume the approved-implementer once with the exact correction list and then run the final-qa-reviewer again. If the correction widens the scope, stop and ask for new human approval.

CLOSING

When QA is approved, the ORCHESTRATOR must deliver a consolidated final report containing:
- diagnosis summary;
- resulting documentation architecture;
- created or updated Rules, Skills, Agents, and Router;
- created, updated, and preserved files;
- executed validations;
- limitations and human validation points;
- confirmation that no functional change or unauthorized external action occurred;
- commit recommendations, without staging or committing.

Start now. Read the kit guide and execute Stage 1.
```

### Multi-agent execution model

```text
repo-discovery-auditor
        ↓ waits and returns APPROVABLE_DIAGNOSIS
documentation-architect
        ↓ waits and returns DOCUMENTATION_PLAN
agent-governance-architect
        ↓ waits and returns GOVERNANCE_PLAN
plan-integrity-reviewer
        ↓ waits and requests HUMAN APPROVAL
approved-implementer
        ↓ waits and returns the implementation diff
final-qa-reviewer
        ↓ approves or returns one bounded correction cycle
orchestrator final report
```

## Agents without web access

Clone or download the kit and provide the local paths to the agent:

```bash
git clone --depth 1 https://github.com/Guigass/agentic-repo-governance-kit.git
```

Then ask the agent to read `en/00-HOW-TO-USE.md` (or `pt-BR/00-COMO-USAR.md`) and the specific stage file. Keep the kit outside the target repository unless you intentionally want to vendor it.

## Versioning

This kit follows [Semantic Versioning](https://semver.org/). `CHANGELOG.md` at the repository root is the canonical source of changes.

For reproducibility in production, point the raw URLs used to load the kit parts to a specific version tag instead of `main`. For example, use `/v1.2.3/en/00-HOW-TO-USE.md` instead of `/main/en/00-HOW-TO-USE.md`. The bootstrap prompts and orchestrator in this README are already pinned to a tagged release.

## Evolving this kit

When the ecosystem changes enough to justify a new release (a new AI model generation, new agent/IDE capabilities, new portable standards, new recurring directives, or accumulated maintenance needs), follow [`en/EVOLUTION-AND-MAINTENANCE.md`](en/EVOLUTION-AND-MAINTENANCE.md). It applies the same staged safety model to the kit itself: a read-only self-diagnosis, an evolution plan, a mandatory human gate, implementation in `en/` then parity in `pt-BR/`, validation via the parity scripts, and a release recorded in `CHANGELOG.md` with a new version tag.

## Roadmap planning for a new feature

When the user wants to plan a new feature or a new part of the system and needs a structured, wave-based roadmap grounded in the real project (patterns, architecture, runtime, deployment, and docs), follow [`en/ROADMAP-PLANNING.md`](en/ROADMAP-PLANNING.md). It runs a read-only context interview and project analysis, proposes a wave breakdown under `docs/roadmap/<plan-name>/`, stops at a mandatory human gate, and only then writes the approved roadmap files (overview, context, and one file per wave). This guide produces the roadmap only; it does not implement the feature. When Parts 1–4 govern a target repository, Part 3 also evaluates installing that same procedure as a project skill (`roadmap-planning`) under `.agents/skills/` when recurring wave-based planning is justified.

## Design principles

- Evidence before conclusions.
- Diagnosis before planning.
- Planning before changes.
- Explicit approval before implementation.
- Current architecture separated from future proposals.
- Proportional documentation instead of file proliferation.
- Rules, Skills, and Agents created from observed needs, preferring portable standards.
- Canonical documentation referenced rather than duplicated.
- Working tree and unrelated changes preserved.
- No production, database, deployment, or external-state mutations by default.

## Agent environment compatibility

Agent environments and portable standards evolve. Before creating Rules, Skills, Agents, or instruction files, the kit asks the agent to detect the approved target environments and validate the currently supported directories, frontmatter, activation modes, scoping, tools, and read-only options against each environment's official documentation. Prefer portable layers (`AGENTS.md`, `.agents/skills/`) and add environment-specific adapters only when needed.

## Scope

The kit is designed for frontend, backend, full-stack, mobile, desktop, APIs, libraries, CLIs, monorepos, microservices, legacy systems, infrastructure, DevOps/IaC, workers, and experimental projects. It does not assume that a database, frontend, backend, tests, CI/CD, or documented deployment exists.

## Contributing

Contributions should preserve the staged safety model and avoid turning optional artifacts into universal requirements. Proposed changes should explain the failure mode or maintenance need they address. Keep the English (`en/`) and Portuguese (`pt-BR/`) versions in parity: every change to one must be reflected in the other.

Before submitting a change that touches `en/` or `pt-BR/`, run the parity check to validate structural parity between the two versions:

- Linux/macOS: `scripts/check-parity.sh`
- Windows (PowerShell): `scripts/check-parity.ps1`

The script exits with code `0` when parity holds and `1` when it finds divergences, printing the differences. Wiring this check into CI is optional but recommended.
