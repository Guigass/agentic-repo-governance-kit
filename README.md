# Agentic Repository Governance Kit

A modular prompt kit for auditing software repositories, designing maintainable technical documentation, and creating project-specific Cursor Rules, Skills, and Agents with explicit safety gates.

The current prompt set is written in Brazilian Portuguese (`pt-BR`). Agents may produce the final report in another language when requested by the user.

## What this kit does

The kit guides an AI agent through four controlled stages:

1. **Read-only discovery and diagnosis** — maps the repository, architecture, critical flows, documentation, risks, and coverage limitations.
2. **Documentation architecture planning** — defines what should be preserved, improved, consolidated, or created.
3. **Agentic governance planning** — evaluates project-specific Rules, Skills, Agents, preflight workflows, change management, and routing.
4. **Approved implementation and validation** — changes only the explicitly approved files, reviews the diff, and reports validations and remaining uncertainties.

Planning is not treated as permission to write. The implementation phase requires explicit human approval.

## Files

| File | Purpose | Writes files? |
| --- | --- | --- |
| [`00-COMO-USAR.md`](00-COMO-USAR.md) | Usage guide, execution order, modes, and approval gates | No |
| [`01-DESCOBERTA-E-DIAGNOSTICO.md`](01-DESCOBERTA-E-DIAGNOSTICO.md) | Repository discovery and evidence-based diagnosis | No |
| [`02-ARQUITETURA-DOCUMENTAL-E-PLANO.md`](02-ARQUITETURA-DOCUMENTAL-E-PLANO.md) | Documentation architecture and exact file plan | No |
| [`03-GOVERNANCA-CURSOR-E-PLANO.md`](03-GOVERNANCA-CURSOR-E-PLANO.md) | Rules, Skills, Agents, and Router planning | No |
| [`04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md`](04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md) | Approved implementation, validation, and final report | Only after explicit approval |

## Quick start with a URL

Use this method with an agent that can open public web URLs.

Copy and send the following bootstrap prompt while the agent is working in the repository you want to audit:

```text
Use the Agentic Repository Governance Kit available at:
https://github.com/Guigass/agentic-repo-governance-kit

The repository currently open in your workspace is the TARGET repository. The kit repository is only an instruction source and must not be analyzed as the target.

First, read these files in order:
1. https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/00-COMO-USAR.md
2. https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/01-DESCOBERTA-E-DIAGNOSTICO.md

Execute only Part 1 now, using AUDITORIA_SOMENTE_LEITURA and PADRAO depth.

Requirements:
- Respect all higher-priority user, system, and repository instructions.
- Do not edit, create, move, or delete files.
- Do not install dependencies or access databases, cloud accounts, production, or private external services.
- Support important conclusions with repository paths, symbols, or other concrete evidence.
- Report analyzed, sampled, excluded, and unverified areas.
- Clearly separate observed facts, evidence-based inferences, items not identified in the searched scope, and matters requiring human validation.
- Stop after the diagnosis. Do not continue to planning or implementation until I explicitly request the next part.

Respond in [preferred language].
```

Replace `[preferred language]` with the desired language, such as `English` or `Brazilian Portuguese`.

### Prompt padrão em português

```text
Use o Agentic Repository Governance Kit disponível em:
https://github.com/Guigass/agentic-repo-governance-kit

O repositório aberto atualmente no seu workspace é o repositório ALVO. O repositório do kit é apenas uma fonte de instruções e não deve ser analisado como alvo.

Primeiro, leia estes arquivos na ordem:
1. https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/00-COMO-USAR.md
2. https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/01-DESCOBERTA-E-DIAGNOSTICO.md

Execute agora somente a Parte 1, no modo AUDITORIA_SOMENTE_LEITURA e com profundidade PADRAO.

Requisitos:
- Respeite todas as instruções de maior precedência fornecidas pelo usuário, sistema e repositório.
- Não edite, crie, mova ou remova arquivos.
- Não instale dependências nem acesse banco de dados, cloud, produção ou serviços externos privados.
- Sustente conclusões importantes com caminhos, símbolos ou outras evidências concretas do repositório.
- Informe áreas analisadas, amostradas, excluídas e não verificadas.
- Separe fatos observados, inferências baseadas em evidência, itens não identificados no escopo pesquisado e pontos que exigem validação humana.
- Pare após o diagnóstico. Não avance para planejamento ou implementação sem minha solicitação explícita.

Responda em português brasileiro.
```

## Continue to the next stages

After reviewing and correcting the diagnosis, use the next prompt explicitly.

### Documentation architecture

```text
Continue using the Agentic Repository Governance Kit.

Read and execute only Part 2:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/02-ARQUITETURA-DOCUMENTAL-E-PLANO.md

Use the approved diagnosis already present in this conversation. Produce the documentation architecture and exact file plan, but do not modify any files. Stop after the plan.
```

### Cursor governance

```text
Continue using the Agentic Repository Governance Kit.

Read and execute only Part 3:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/03-GOVERNANCA-CURSOR-E-PLANO.md

Use the approved diagnosis and documentation plan already present in this conversation. Produce the Rules, Skills, Agents, and Router plan, but do not modify any files. Stop after the plan.
```

### Approved implementation

Part 4 must only be used after the human has approved an exact file and action list.

```text
The documentation and agentic governance plan has been reviewed.

Approved scope:
[paste the exact approved files and actions here]

Read and execute Part 4 of the Agentic Repository Governance Kit:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md

Implement only the approved scope. Preserve unrelated and pre-existing changes. Do not change functional application code. Do not stage, commit, push, publish, or access external systems unless separately authorized.
```

## Agents without web access

Clone or download the kit and provide the local paths to the agent:

```bash
git clone --depth 1 https://github.com/Guigass/agentic-repo-governance-kit.git
```

Then ask the agent to read `00-COMO-USAR.md` and the specific stage file. Keep the kit outside the target repository unless you intentionally want to vendor it.

## Design principles

- Evidence before conclusions.
- Diagnosis before planning.
- Planning before changes.
- Explicit approval before implementation.
- Current architecture separated from future proposals.
- Proportional documentation instead of file proliferation.
- Rules, Skills, and Agents created from observed needs.
- Canonical documentation referenced rather than duplicated.
- Working tree and unrelated changes preserved.
- No production, database, deployment, or external-state mutations by default.

## Cursor compatibility

Cursor formats and capabilities can evolve. Before creating Rules, Skills, or Agents, the kit asks the agent to validate the currently supported directories, frontmatter, activation modes, scoping, tools, and read-only options against the installed version and current official documentation.

## Scope

The kit is designed for frontend, backend, full-stack, mobile, desktop, APIs, libraries, CLIs, monorepos, microservices, legacy systems, infrastructure, DevOps/IaC, workers, and experimental projects. It does not assume that a database, frontend, backend, tests, CI/CD, or documented deployment exists.

## Contributing

Contributions should preserve the staged safety model and avoid turning optional artifacts into universal requirements. Proposed changes should explain the failure mode or maintenance need they address.
