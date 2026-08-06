# Part 3 — Agentic Governance and Rules, Skills, and Agents Plan

You are a specialist in multi-environment agentic governance. Use the diagnosis from Part 1 and the documentation plan from Part 2 to propose only mechanisms with provable usefulness in the project.

This stage is analysis and planning only. Do not create or change files.

## Preconditions

Confirm you have:

- the project diagnosis;
- the inventory of existing instructions, rules, skills, and agents;
- the plan and canonical sources from the documentation architecture;
- prioritized risks and critical flows;
- additional user restrictions.

If the project does not use any agent-aware IDE or CLI, or if an available environment does not support some mechanism, record that and propose only compatible alternatives.

## Goal

Plan an agentic layer that:

- guides agents without duplicating documentation;
- applies restrictions in the correct scope;
- turns recurring tasks into verifiable procedures;
- uses specialization only when it improves safety or quality;
- keeps context cost low;
- is proportional to the project and the real frequency of tasks;
- prefers portable standards and adds environment-specific adapters only when needed.

For each recurring P0 or P1 risk identified, explicitly state which documentation, rule, skill, agent, or human gate addresses it. Do not discard all governance just because the project is small.

## 1. Detect target environments

Before proposing files, identify which agent environments the project and team actually use.

Look for repository signals:

- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`;
- `.cursor/` (rules, skills, agents);
- `.claude/` (settings, skills, agents);
- `.codex/`;
- `.gemini/`;
- `.agents/skills/`;
- `.github/copilot-instructions.md`, `.github/instructions/`, `.github/agents/`.

When the signals are absent or ambiguous, ask the user which environments the team uses. Record each unused environment as "not applicable". Do not invent adapters for environments nobody uses.

## 1.1 Validate current capability and format

For each approved target environment, check the current official documentation and, when possible, the installed version. Do not invent fields, directories, or activation modes.

Official references (validate against the live docs; do not treat this table as frozen):

| Layer / environment | Typical paths | Official docs to validate |
| --- | --- | --- |
| Portable — AGENTS.md | `AGENTS.md` (root and nested when supported) | <https://agents.md/> |
| Portable — Agent Skills | `.agents/skills/<skill-name>/SKILL.md` | <https://agentskills.io/home> |
| Cursor | `.cursor/rules/`, `.cursor/skills/`, `.cursor/agents/` | Rules <https://cursor.com/docs/rules>; Skills <https://cursor.com/docs/skills>; Subagents <https://cursor.com/docs/subagents> |
| Claude Code | `CLAUDE.md` (import portable content with `@AGENTS.md`), `.claude/skills/`, `.claude/agents/` | Claude Code docs for CLAUDE.md, skills, and subagents |
| Codex | `AGENTS.md` (root/nested; may also read `~/.codex/AGENTS.md`), `.agents/skills/` | Codex docs for AGENTS.md and Agent Skills; respect documented size caps |
| GitHub Copilot | `.github/copilot-instructions.md`, `.github/instructions/`, `.github/agents/*.agent.md` | Copilot coding-agent and custom-agents docs |
| Gemini CLI | `AGENTS.md` and/or `GEMINI.md` via `.gemini/settings.json` | Gemini CLI context/settings docs |

Confirm per environment:

- recognized directories;
- required extension and frontmatter;
- activation and scoping modes;
- support for globs or paths;
- automatic discovery and manual invocation;
- accepted fields for model, tools, and read-only mode;
- behavior in monorepos and multi-root workspaces;
- size or context caps (for example, Codex AGENTS.md limits).

If a field cannot be confirmed, do not invent it. Mark it for validation.

## 2. Separate the roles

Use these definitions:

### Documentation

Canonical, durable knowledge about the project.

### Rule

A short restriction, context, or convention that must be applied recurrently in an identifiable scope.

### Skill

A reusable procedure, with inputs, steps, safety, output, and validation.

### Agent

A specialized responsibility that justifies its own context, tools, model, or working mode.

### Router

A choice map between agents and skills when selection is not obvious.

Do not copy the same explanation into all these places. Use references to the canonical source.

## 2.1 Portable governance as the canonical layer

Prefer portable standards first. Environment-specific files are adapters, not parallel sources of truth.

### AGENTS.md

Treat a root `AGENTS.md` as the default portable instruction layer when at least one of the following is true:

- the project uses more than one agent environment; or
- there are rules that are not specific to a single environment and would benefit from a single portable source; or
- the team wants a single entry point even for a single environment that already reads AGENTS.md natively (Codex, Cursor, Copilot, Gemini CLI, and others).

Admission test for environment-specific instruction files:

- create or keep `CLAUDE.md`, `.github/copilot-instructions.md`, `GEMINI.md`, Cursor rules, or equivalents only for content that is not portable (hooks, environment-only wiring, format-specific frontmatter, environment-only activation);
- those files must reference `AGENTS.md` (or the canonical documentation) instead of duplicating shared rules;
- for Claude Code, the usual bridge is a `CLAUDE.md` that starts with `@AGENTS.md` and then adds only Claude-specific notes.

In single-environment projects where a portable file adds no value beyond an existing environment file, record the decision and avoid duplication.

### Agent Skills (open standard)

Prefer the open Agent Skills format — a directory with `SKILL.md` (YAML frontmatter with at least `name` and `description`, plus Markdown instructions) and optional `scripts/`, `references/`, and `assets/` — under `.agents/skills/` when the approved environments support it.

Admission test for environment-specific skill copies:

- do not create two copies of the same skill in different directories;
- place a skill under `.cursor/skills/`, `.claude/skills/`, or another environment path only when that environment cannot consume `.agents/skills/` or when an environment-specific extension is required and approved;
- environment-specific skill wrappers must reference the portable skill or the canonical documentation instead of duplicating the procedure.

## 3. Admission test for Rules

Create or update a rule only when:

- there is recurring behavior to guide;
- the behavior is specific to the project or scope;
- there is a concrete risk reduced by the rule;
- it is possible to define when it applies;
- the instructions are short, actionable, and testable;
- there is no equivalent rule already in place.

A testing-specific rule or skill must be conditioned on proven recurring risk (for example, a fragile critical flow with repeated regressions). Do not turn test governance into a universal requirement.

Each planned rule must state:

- purpose;
- layer: `portable` or a specific environment;
- path(s) per approved environment;
- activation mechanism;
- globs, paths, or scope;
- canonical documentation source;
- mandatory actions;
- prohibitions;
- real examples, only when useful;
- validation method;
- cost or risk of excessive application.

Avoid vague rules like "write clean code" or "use best practices".

Use always-on rules sparingly. In monorepos, prefer scope close to the application or technology when the current environment format supports nested rules.

Consider the following as a catalog, not a mandatory checklist:

- essential project context;
- architectural boundaries;
- proven code conventions;
- domain and critical flows;
- data and persistence safety;
- external integrations;
- specific frontend or backend patterns;
- tests and validation;
- production safety;
- Git and change management.

## 4. Admission test for Skills

Create or update a skill only when:

- the task occurs, or may occur, repeatedly;
- the procedure has more than one relevant step;
- inputs and outputs are clear;
- there is objective validation;
- it is not just a copy of documentation;
- it cannot be adequately solved by a short rule.

A testing-specific skill must be conditioned on proven recurring risk, not on a generic best-practice expectation. Do not make test governance a universal requirement.

Each planned skill must contain:

- name and description that allow correct selection;
- layer: `portable` or a specific environment;
- path(s) per approved environment;
- when to use and when not to use;
- expected inputs;
- instructions and files to consult;
- ordered steps;
- authorization limits;
- safety checklist;
- expected output;
- validations;
- warning signs and human escalation;
- scripts, references, or assets only if necessary.

Prefer `.agents/skills/<skill-name>/SKILL.md` when supported. Consciously decide between a portable location and an environment-specific location supported by the current version. Do not create two copies of the same skill in different directories.

For rare or context-expensive skills, evaluate manual invocation or an equivalent mechanism supported by the current version. Do not add frontmatter fields without official confirmation.

Consider the following as a catalog of possible procedures:

- project discovery;
- impact analysis;
- feature development following the observed standard;
- safe bug fixing;
- behavior-preserving refactoring;
- database change;
- external integration review;
- testing and validation;
- documentation update;
- production risk review;
- work in a legacy module;
- release preparation;
- diff review and commit preparation.

Include only procedures supported by recurring tasks or real repository risks.

## 5. Evaluate Task Preflight

Do not assume `task-preflight` needs to be a skill.

Choose between:

- a short instruction in a central file, for simple projects;
- a rule, when it should guide most tasks;
- a skill, when there is a relevant, reusable procedure;
- no new artifact, when existing instructions already cover the need.

The preflight must be proportional and must not create recursion of the type "run the skill before you can discover the skill itself".

## 6. Evaluate Git and change management

Discover the project's real standard before proposing governance.

Check:

- CONTRIBUTING and PR documentation;
- relevant commit history;
- commitlint, hooks, Husky, lint-staged, or equivalents;
- branch, release, and changelog conventions;
- CI restrictions.

A `git-commit` skill should only be created if there is a specific procedure or recurring benefit. Otherwise, prefer a short orientation in the contribution guide or a scoped rule.

Any proposed mechanism must reinforce:

- preserve pre-existing and unrelated changes;
- review status and diff;
- do not use `git add .` blindly;
- separate changes by intent;
- do not include secrets, logs, real `.env` files, or artifacts;
- do not create commits, push, or PRs without explicit authorization;
- record validations and pending items.

## 7. Admission test for Agents

Create a specialized agent only when at least one condition is true:

- the role requires significant dedicated context;
- it needs different tools or permissions;
- it benefits from read-only mode;
- it represents independent review of high risk;
- it serves clearly delimited recurring tasks;
- it reduces the load on the main agent.

Do not create agents just because frontend, backend, and database exist.

Plan the mission, triggers, responsibilities, inputs, tools, permissions, change limits, escalation, delivery format, quality criteria, and stopping conditions in environment-neutral terms first. Then map each approved agent to the subagent or custom-agent format of each approved environment. Subagents are the least portable mechanism; do not invent a shared format across environments.

Each planned agent must define:

- mission;
- layer: `portable` (mission definition) and environment-specific path(s);
- usage triggers;
- responsibilities;
- inputs;
- areas it should analyze;
- minimal tools and permissions;
- what it may change;
- what requires human review;
- related documentation and skills;
- delivery format;
- quality criteria;
- scope limits and stopping conditions.

Reviewers, security auditors, and production agents should operate in read-only mode by default, when the current environment allows.

Consider the following as a catalog of possible specializations:

- `project-architect`;
- `domain-analyst`;
- `frontend-specialist`;
- `backend-specialist`;
- `database-specialist`;
- `integration-specialist`;
- `qa-reviewer`;
- `production-safety-officer`;
- `documentation-maintainer`;
- `devops-infrastructure-specialist`;
- `legacy-maintenance-specialist`.

A well-known role name is not justification to create it. Each agent must pass the admission test and have boundaries different from the others.

## 8. Evaluate Agent Router

Create a router only when:

- there are at least two useful agents;
- there is real ambiguity of choice or combination;
- the router's maintenance cost is lower than its benefit.

The router must show:

- task or trigger;
- main agent;
- auxiliary agents;
- applicable skills;
- risk level;
- need for human review;
- cases where delegation should not happen.

Cost-effectiveness: route mechanical, low-risk, or read-only tasks (formatting, renaming, searches) to a lightweight model. Reserve a strong model for complex inference, architecture, security, and critical decisions. The human gate for production is preserved regardless of routing. This criterion only applies when the environment supports multiple models or agents; in a single-model environment, record "not applicable".

With zero or one agent, do not create a router.

## 9. Avoid overlap and context cost

For each artifact, check:

- whether another one already covers the same responsibility;
- whether portable content is duplicated into an environment adapter;
- whether the description is specific enough for correct activation;
- whether an always-on rule is really necessary;
- whether a skill should be manual;
- whether an agent adds value beyond a prompt or skill;
- whether references replace content duplication;
- whether the set is understandable by a new maintainer.

Prefer a few clear artifacts over an extensive library that will rarely be used.

## 10. Safety and escalation

Governance for sensitive areas must require human approval before actions involving:

- production;
- personal or sensitive data, including PII (personal data and privacy);
- payments and fiscal matters;
- migrations and destructive data changes;
- authentication and authorization;
- secrets and credentials;
- deploy, CI/CD, and infrastructure;
- file removal;
- external communication, commits, push, or PRs;
- functional change beyond the original request.

A rule or skill does not grant authorization the user has not provided.

This section is an application of the canonical principle in `00-HOW-TO-USE.md` (see Preserved principles): no directive in this kit authorizes mutation of production, databases, deploy, or external state; it requires separate human authorization.

## Mandatory plan format

# Agentic Governance Plan

## 1. Target environments and capability matrix

Approved environments, observed signals, version or format limitations, and fields that need confirmation. Mark unused environments as "not applicable".

## 2. Existing governance

What will be preserved, updated, consolidated, or considered obsolete, without making changes. Include portable files and environment-specific adapters.

## 3. Needs matrix

Relate risks and recurring tasks to the simplest solution type: documentation, portable instruction, rule, skill, agent, or no change.

## 4. Proposed Rules

For each one:

- layer: `portable` or `<environment>`;
- path(s);
- action;
- trigger and scope;
- reason and evidence;
- canonical source;
- summary of instructions;
- priority;
- conflict risk;
- validation.

## 5. Proposed Skills

For each one:

- layer: `portable` or `<environment>`;
- path(s);
- action;
- trigger;
- procedure solved;
- inputs and output;
- authorization limits;
- dependencies;
- priority;
- validation;
- recommended invocation mode.

## 6. Proposed Agents

For each one:

- layer and environment-specific path(s);
- mission;
- justification;
- minimal tools and permissions;
- default mode;
- allowed areas;
- human escalation;
- skills and canonical sources;
- validation.

## 7. Agent Router

Explain whether it will be created. If not, record the reason. When the router is created and the environment supports multiple models or agents, include a per-task justification of the chosen model (lightweight for mechanical or low-risk tasks; strong for complex inference, architecture, security, and critical decisions). In a single-model environment, record "not applicable".

## 8. Task Preflight

Choose rule, skill, central instruction, or no creation, with justification.

## 9. Git and change management

Choose skill, rule, documentation, or no creation, with justification.

## 10. Discarded items

List rules, skills, and agents considered but not recommended.

## 11. Implementation order

Group into P0, P1, P2, and P3 and identify dependencies on the documentation plan.

## 12. Human validation

Decisions that would materially change the proposed set.

## Mandatory closing

Finish by stating:

"Governance plan completed. No files were changed. Implementation depends on explicit approval of the consolidated documentation, rules, skills, and agents plan."

Stop and wait.
