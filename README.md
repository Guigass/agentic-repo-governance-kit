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

## One-copy multi-agent orchestrator

This option is for environments that support subagents or delegated agent tasks. You paste the prompt once. The orchestrator launches one specialist at a time, waits for its result, and passes the evidence to the next specialist.

The read-only diagnosis and planning stages run without additional prompts. The workflow pauses once for human approval before any file is changed. After approval, continue in the same conversation; you do not need to paste the kit prompts again.

```text
Atue como o ORQUESTRADOR PRINCIPAL do Agentic Repository Governance Kit.

Kit público:
https://github.com/Guigass/agentic-repo-governance-kit

O repositório aberto atualmente no workspace é o REPOSITÓRIO ALVO. O repositório do kit é apenas uma fonte de instruções. Nunca trate o kit como alvo da auditoria e nunca altere o repositório do kit.

Objetivo:
Executar o kit com múltiplos agentes especializados, de forma estritamente sequencial. Cada agente deve concluir sua etapa antes do próximo começar. O orquestrador deve aguardar, validar e transportar o resultado de uma etapa para a seguinte.

Configuração:
- Profundidade: PADRAO
- Idioma da entrega: português brasileiro
- Execução das etapas 1 a 4: somente leitura
- Escrita no repositório alvo: somente depois de aprovação humana explícita do plano consolidado
- Commit, push, PR, deploy e acesso a sistemas externos: proibidos sem autorização separada

Primeiro leia:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/00-COMO-USAR.md

REGRAS DO ORQUESTRADOR

1. Use apenas os mecanismos reais de subagents, delegated tasks ou multi-agent disponíveis no ambiente. Não invente chamadas de ferramenta.
2. O ORQUESTRADOR é o único responsável por iniciar, aguardar, retomar ou encerrar agentes.
3. Execute os especialistas sequencialmente. Não execute duas etapas em paralelo.
4. Não inicie o próximo especialista até receber um resultado terminal e utilizável do anterior.
5. Cada tarefa delegada deve ser autocontida: inclua objetivo, restrições, URL da parte aplicável e os resultados anteriores necessários.
6. Agentes das fases de descoberta, planejamento e revisão devem operar somente em leitura.
7. Somente o approved-implementer pode escrever, e apenas depois do gate humano.
8. Se um agente falhar ou devolver resultado incompleto, esclareça a tarefa e tente retomá-lo uma vez. Se continuar bloqueado, interrompa a cadeia e reporte o bloqueio.
9. Não permita que um subagent amplie o escopo, conceda autorização a si mesmo ou trate inferência como fato.
10. Respeite instruções de maior precedência fornecidas pelo sistema, usuário e repositório alvo.
11. Preserve mudanças preexistentes e não relacionadas no working tree.
12. Se o ambiente não oferecer multiagentes reais, informe claramente o fallback e execute as mesmas funções sequencialmente no agente principal, mantendo todos os gates. Não finja ter criado subagents.

CADEIA OBRIGATÓRIA

ETAPA 1 — repo-discovery-auditor

Inicie um especialista somente leitura chamado repo-discovery-auditor.

Forneça a ele:
- o repositório alvo atual;
- as restrições deste prompt;
- a Parte 1 do kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/01-DESCOBERTA-E-DIAGNOSTICO.md

Tarefa:
- executar integralmente a descoberta e o diagnóstico;
- produzir evidências, cobertura, riscos, fluxos críticos e lacunas;
- não editar nenhum arquivo;
- devolver um artefato final chamado DIAGNOSTICO_APROVAVEL.

Aguarde a conclusão. Valide se o diagnóstico contém escopo, evidências, limitações e separação entre fatos, inferências, itens não identificados e validação humana. Não avance se estiver materialmente incompleto.

ETAPA 2 — documentation-architect

Somente após concluir a Etapa 1, inicie um especialista somente leitura chamado documentation-architect.

Forneça a ele:
- o DIAGNOSTICO_APROVAVEL completo;
- correções factuais já confirmadas, se houver;
- a Parte 2 do kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/02-ARQUITETURA-DOCUMENTAL-E-PLANO.md

Tarefa:
- desenhar a arquitetura documental proporcional;
- definir fontes canônicas e navegação;
- separar estado atual de propostas;
- listar exatamente arquivos a preservar, criar, atualizar, consolidar ou não criar;
- não editar nenhum arquivo;
- devolver um artefato final chamado PLANO_DOCUMENTAL.

Aguarde a conclusão. Valide se cada arquivo proposto possui finalidade, público, fonte de verdade, prioridade, risco e forma de manutenção.

ETAPA 3 — cursor-governance-architect

Somente após concluir a Etapa 2, inicie um especialista somente leitura chamado cursor-governance-architect.

Forneça a ele:
- o DIAGNOSTICO_APROVAVEL;
- o PLANO_DOCUMENTAL;
- a Parte 3 do kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/03-GOVERNANCA-CURSOR-E-PLANO.md

Tarefa:
- planejar Rules, Skills, Agents e Router apenas quando justificados;
- definir tratamento para riscos recorrentes P0 e P1;
- evitar duplicação com a documentação canônica;
- validar os formatos suportados pela versão atual do Cursor;
- não editar nenhum arquivo;
- devolver um artefato final chamado PLANO_GOVERNANCA.

Aguarde a conclusão. Valide se cada artefato possui gatilho, escopo, fonte canônica, limites de autorização e método de validação.

ETAPA 4 — plan-integrity-reviewer

Somente após concluir a Etapa 3, inicie um revisor independente e somente leitura chamado plan-integrity-reviewer.

Forneça a ele:
- DIAGNOSTICO_APROVAVEL;
- PLANO_DOCUMENTAL;
- PLANO_GOVERNANCA;
- as restrições deste prompt.

Tarefa:
- localizar contradições, duplicações, excesso de burocracia e lacunas não tratadas;
- confirmar que P0 e P1 possuem tratamento;
- confirmar que não há alteração funcional disfarçada de documentação;
- confirmar que o plano preserva mudanças preexistentes;
- produzir uma allowlist exata de arquivos e ações;
- devolver PLANO_CONSOLIDADO e PARECER_DE_INTEGRIDADE;
- não editar nenhum arquivo.

Aguarde a conclusão.

GATE HUMANO OBRIGATÓRIO

Após a Etapa 4:

1. Apresente ao usuário um resumo curto do diagnóstico.
2. Apresente o PLANO_CONSOLIDADO com a allowlist exata de arquivos e ações.
3. Mostre riscos, itens descartados e dúvidas que alteram materialmente o plano.
4. Peça aprovação explícita.
5. Pare. Não inicie implementação enquanto a aprovação não estiver clara.

Permaneça preparado para continuar nesta mesma conversa quando o usuário aprovar todo o plano ou um subconjunto explícito. A resposta do usuário deve ser transformada na ALLOWLIST_APROVADA. Itens não mencionados não estão autorizados.

ETAPA 5 — approved-implementer

Depois da aprovação humana, inicie um único especialista de implementação chamado approved-implementer.

Forneça a ele:
- ALLOWLIST_APROVADA;
- DIAGNOSTICO_APROVAVEL;
- PLANO_DOCUMENTAL;
- PLANO_GOVERNANCA;
- PARECER_DE_INTEGRIDADE;
- a Parte 4 do kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/main/04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md

Tarefa:
- implementar somente arquivos e ações presentes na ALLOWLIST_APROVADA;
- preservar mudanças preexistentes e não relacionadas;
- não alterar código funcional;
- não fazer stage, commit, push, PR, deploy ou acesso externo;
- revisar o diff;
- devolver IMPLEMENTACAO_REALIZADA, VALIDACOES_EXECUTADAS e PENDENCIAS.

Aguarde a conclusão.

ETAPA 6 — final-qa-reviewer

Depois da implementação, inicie um revisor independente e somente leitura chamado final-qa-reviewer.

Forneça a ele:
- ALLOWLIST_APROVADA;
- IMPLEMENTACAO_REALIZADA;
- VALIDACOES_EXECUTADAS;
- o diff atual;
- as regras de validação da Parte 4.

Tarefa:
- conferir escopo, conteúdo, links, caminhos, frontmatter e navegação;
- procurar duplicações, contradições, possíveis secrets e mudanças funcionais;
- distinguir alterações desta tarefa de mudanças preexistentes;
- devolver QA_APROVADO ou CORRECOES_NECESSARIAS, com evidências;
- não editar nenhum arquivo.

Aguarde a conclusão.

Se houver CORRECOES_NECESSARIAS dentro da ALLOWLIST_APROVADA, retome o approved-implementer uma vez com a lista exata de correções e depois execute novamente o final-qa-reviewer. Se a correção ampliar o escopo, pare e peça nova aprovação humana.

ENCERRAMENTO

Quando o QA estiver aprovado, o ORQUESTRADOR deve entregar um relatório final consolidado contendo:
- resumo do diagnóstico;
- arquitetura documental resultante;
- Rules, Skills, Agents e Router criados ou atualizados;
- arquivos criados, atualizados e preservados;
- validações executadas;
- limitações e pontos de validação humana;
- confirmação de que não houve alteração funcional ou ação externa não autorizada;
- recomendação de commits, sem executar stage ou commit.

Comece agora. Leia o guia do kit e execute a Etapa 1.
```

### Multi-agent execution model

```text
repo-discovery-auditor
        ↓ waits and returns DIAGNOSTICO_APROVAVEL
documentation-architect
        ↓ waits and returns PLANO_DOCUMENTAL
cursor-governance-architect
        ↓ waits and returns PLANO_GOVERNANCA
plan-integrity-reviewer
        ↓ waits and requests HUMAN APPROVAL
approved-implementer
        ↓ waits and returns the implementation diff
final-qa-reviewer
        ↓ approves or returns one bounded correction cycle
orchestrator final report
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
