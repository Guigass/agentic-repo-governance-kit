# Agentic Repository Governance Kit

> 🇺🇸 English version (canonical): [README.md](README.md)

Um kit modular de prompts para auditar repositórios de software, desenhar documentação técnica sustentável e criar Cursor Rules, Skills e Agents específicos do projeto, com gates de segurança explícitos.

O kit é bilíngue. O inglês é a versão canônica em [`en/`](en/); o português brasileiro está em [`pt-BR/`](pt-BR/). As duas versões são mantidas em paridade, e os agentes podem produzir o relatório final em outro idioma quando solicitado pelo usuário.

## O que este kit faz

O kit guia um agente de IA por quatro etapas controladas:

1. **Descoberta e diagnóstico somente leitura** — mapeia o repositório, arquitetura, fluxos críticos, documentação, dependências, riscos e limitações de cobertura.
2. **Planejamento da arquitetura documental** — define o que deve ser preservado, melhorado, consolidado ou criado.
3. **Planejamento da governança agêntica** — avalia Rules, Skills, Agents, fluxos de preflight, gestão de mudanças e roteamento específicos do projeto.
4. **Implementação aprovada e validação** — altera somente os arquivos explicitamente aprovados, revisa o diff e reporta validações e incertezas restantes.

Planejamento não é tratado como permissão para escrever. A fase de implementação exige aprovação humana explícita.

## Arquivos

| Português (pt-BR) | Inglês (canônico) | Finalidade | Escreve arquivos? |
| --- | --- | --- | --- |
| [`pt-BR/00-COMO-USAR.md`](pt-BR/00-COMO-USAR.md) | [`en/00-HOW-TO-USE.md`](en/00-HOW-TO-USE.md) | Guia de uso, ordem de execução, modos e gates de aprovação | Não |
| [`pt-BR/01-DESCOBERTA-E-DIAGNOSTICO.md`](pt-BR/01-DESCOBERTA-E-DIAGNOSTICO.md) | [`en/01-DISCOVERY-AND-DIAGNOSIS.md`](en/01-DISCOVERY-AND-DIAGNOSIS.md) | Descoberta do repositório e diagnóstico baseado em evidências | Não |
| [`pt-BR/02-ARQUITETURA-DOCUMENTAL-E-PLANO.md`](pt-BR/02-ARQUITETURA-DOCUMENTAL-E-PLANO.md) | [`en/02-DOCUMENTATION-ARCHITECTURE-AND-PLAN.md`](en/02-DOCUMENTATION-ARCHITECTURE-AND-PLAN.md) | Arquitetura documental e plano exato de arquivos | Não |
| [`pt-BR/03-GOVERNANCA-CURSOR-E-PLANO.md`](pt-BR/03-GOVERNANCA-CURSOR-E-PLANO.md) | [`en/03-CURSOR-GOVERNANCE-AND-PLAN.md`](en/03-CURSOR-GOVERNANCE-AND-PLAN.md) | Planejamento de Rules, Skills, Agents e Router | Não |
| [`pt-BR/04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md`](pt-BR/04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md) | [`en/04-IMPLEMENTATION-VALIDATION-AND-REPORT.md`](en/04-IMPLEMENTATION-VALIDATION-AND-REPORT.md) | Implementação aprovada, validação e relatório final | Somente após aprovação explícita |

## Início rápido com URL

Use este método com um agente capaz de abrir URLs públicas.

Copie e envie o prompt de bootstrap abaixo enquanto o agente estiver trabalhando no repositório que você quer auditar:

```text
Use o Agentic Repository Governance Kit disponível em:
https://github.com/Guigass/agentic-repo-governance-kit

O repositório aberto atualmente no seu workspace é o repositório ALVO. O repositório do kit é apenas uma fonte de instruções e não deve ser analisado como alvo.

Primeiro, leia estes arquivos na ordem:
1. https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/00-COMO-USAR.md
2. https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/01-DESCOBERTA-E-DIAGNOSTICO.md

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

## Continuar para as próximas etapas

Após revisar e corrigir o diagnóstico, use o próximo prompt explicitamente.

### Arquitetura documental

```text
Continue usando o Agentic Repository Governance Kit.

Leia e execute somente a Parte 2:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/02-ARQUITETURA-DOCUMENTAL-E-PLANO.md

Use o diagnóstico aprovado já presente nesta conversa. Produza a arquitetura documental e o plano exato de arquivos, mas não modifique nenhum arquivo. Pare após o plano.
```

### Governança do Cursor

```text
Continue usando o Agentic Repository Governance Kit.

Leia e execute somente a Parte 3:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/03-GOVERNANCA-CURSOR-E-PLANO.md

Use o diagnóstico aprovado e o plano documental já presentes nesta conversa. Produza o plano de Rules, Skills, Agents e Router, mas não modifique nenhum arquivo. Pare após o plano.
```

### Implementação aprovada

A Parte 4 só deve ser usada depois que o humano aprovar uma lista exata de arquivos e ações.

```text
O plano de documentação e governança agêntica foi revisado.

Escopo aprovado:
[cole aqui os arquivos e ações exatos aprovados]

Leia e execute a Parte 4 do Agentic Repository Governance Kit:
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md

Implemente somente o escopo aprovado. Preserve mudanças preexistentes e não relacionadas. Não altere código funcional da aplicação. Não faça stage, commit, push, publicação ou acesso a sistemas externos sem autorização separada.
```

## Orquestrador multi-agente de cópia única

Esta opção é para ambientes que suportam subagents ou tarefas delegadas. Você cola o prompt uma única vez. O orquestrador inicia um especialista por vez, aguarda o resultado e passa as evidências para o próximo especialista.

As etapas de diagnóstico e planejamento, somente leitura, rodam sem prompts adicionais. O fluxo pausa uma vez para aprovação humana antes de qualquer arquivo ser alterado. Após a aprovação, continue na mesma conversa; não é preciso colar os prompts do kit novamente.

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
https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/00-COMO-USAR.md

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

CONTRATOS DE ARTEFATO

Valide cada entrega contra estes campos mínimos. Se faltar algum, retome o especialista uma vez antes de interromper a cadeia.

- DIAGNOSTICO_APROVAVEL: escopo e cobertura (com razão de amostragem por área); mapa do repositório; arquitetura com evidências; fluxos críticos rastreados; inventário de documentação e governança; inventário de dependências e supply chain; achados priorizados P0–P3; separação explícita entre fatos, inferências, itens não identificados e validação humana; limitações.
- PLANO_DOCUMENTAL: tabela de ação por arquivo com propósito, público, fonte de verdade, prioridade, risco, dependências, gatilho de atualização e validação; matriz de cobertura; separação entre estado atual e propostas; itens não criados com motivo; ordem P0–P3.
- PLANO_GOVERNANCA: matriz de necessidades; rules, skills e agents com gatilho, escopo, fonte canônica, limites de autorização e validação; tratamento explícito de cada risco P0/P1 recorrente; itens descartados; ordem P0–P3.
- PLANO_CONSOLIDADO: allowlist exata de arquivos e ações; parecer de integridade com contradições, duplicações e excesso de burocracia resolvidos; confirmação de tratamento de P0/P1; confirmação de preservação de mudanças preexistentes.
- IMPLEMENTACAO_REALIZADA: arquivos criados/atualizados dentro da allowlist; validações executadas com comandos e resultados; pendências; confirmação de ausência de alteração funcional.

CADEIA OBRIGATÓRIA

ETAPA 1 — repo-discovery-auditor

Inicie um especialista somente leitura chamado repo-discovery-auditor.

Forneça a ele:
- o repositório alvo atual;
- as restrições deste prompt;
- a Parte 1 do kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/01-DESCOBERTA-E-DIAGNOSTICO.md

Tarefa:
- executar integralmente a descoberta e o diagnóstico;
- produzir evidências, cobertura, riscos, fluxos críticos e lacunas;
- não editar nenhum arquivo;
- devolver um artefato final chamado DIAGNOSTICO_APROVAVEL.

Aguarde a conclusão. Valide o diagnóstico contra o contrato de artefato. Não avance se estiver materialmente incompleto.

ETAPA 2 — documentation-architect

Somente após concluir a Etapa 1, inicie um especialista somente leitura chamado documentation-architect.

Forneça a ele:
- o DIAGNOSTICO_APROVAVEL completo;
- correções factuais já confirmadas, se houver;
- a Parte 2 do kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/02-ARQUITETURA-DOCUMENTAL-E-PLANO.md

Tarefa:
- desenhar a arquitetura documental proporcional;
- definir fontes canônicas e navegação;
- separar estado atual de propostas;
- listar exatamente arquivos a preservar, criar, atualizar, consolidar ou não criar;
- não editar nenhum arquivo;
- devolver um artefato final chamado PLANO_DOCUMENTAL.

Aguarde a conclusão. Valide o plano contra o contrato de artefato.

ETAPA 3 — cursor-governance-architect

Somente após concluir a Etapa 2, inicie um especialista somente leitura chamado cursor-governance-architect.

Forneça a ele:
- o DIAGNOSTICO_APROVAVEL;
- o PLANO_DOCUMENTAL;
- a Parte 3 do kit:
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/03-GOVERNANCA-CURSOR-E-PLANO.md

Tarefa:
- planejar Rules, Skills, Agents e Router apenas quando justificados;
- definir tratamento para riscos recorrentes P0 e P1;
- evitar duplicação com a documentação canônica;
- validar os formatos suportados pela versão atual do Cursor;
- não editar nenhum arquivo;
- devolver um artefato final chamado PLANO_GOVERNANCA.

Aguarde a conclusão. Valide o plano contra o contrato de artefato.

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
  https://raw.githubusercontent.com/Guigass/agentic-repo-governance-kit/v0.1.0/pt-BR/04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md

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

### Modelo de execução multi-agente

```text
repo-discovery-auditor
        ↓ aguarda e devolve DIAGNOSTICO_APROVAVEL
documentation-architect
        ↓ aguarda e devolve PLANO_DOCUMENTAL
cursor-governance-architect
        ↓ aguarda e devolve PLANO_GOVERNANCA
plan-integrity-reviewer
        ↓ aguarda e solicita APROVAÇÃO HUMANA
approved-implementer
        ↓ aguarda e devolve o diff da implementação
final-qa-reviewer
        ↓ aprova ou devolve um ciclo limitado de correções
relatório final do orquestrador
```

## Agentes sem acesso à web

Clone ou baixe o kit e forneça os caminhos locais ao agente:

```bash
git clone --depth 1 https://github.com/Guigass/agentic-repo-governance-kit.git
```

Depois peça ao agente para ler `pt-BR/00-COMO-USAR.md` (ou `en/00-HOW-TO-USE.md`) e o arquivo da etapa específica. Mantenha o kit fora do repositório alvo, a menos que você queira intencionalmente vendorizá-lo.

## Versionamento

Este kit segue [Versionamento Semântico](https://semver.org/). O `CHANGELOG.md` na raiz do repositório é a fonte canônica de mudanças.

Para reprodutibilidade em produção, aponte as URLs raw usadas para carregar as partes do kit para uma tag de versão específica em vez de `main`. Por exemplo, use `/v0.1.0/pt-BR/00-COMO-USAR.md` em vez de `/main/pt-BR/00-COMO-USAR.md`. Os prompts de bootstrap e o orquestrador neste README já estão pinados em uma release com tag.

## Evoluindo este kit

Quando o ecossistema mudar o suficiente para justificar um novo release (uma nova geração de modelos de IA, novas capacidades de agentes/IDEs, novos padrões portáteis, novas diretivas recorrentes, ou necessidades de manutenção acumuladas), siga [`pt-BR/EVOLUCAO-E-MANUTENCAO.md`](pt-BR/EVOLUCAO-E-MANUTENCAO.md). Ele aplica ao próprio kit o mesmo modelo de segurança em estágios: um autodiagnóstico somente leitura, um plano de evolução, um gate humano obrigatório, implementação em `en/` e depois paridade em `pt-BR/`, validação via os scripts de paridade, e um release registrado no `CHANGELOG.md` com uma nova tag de versão.

## Princípios de design

- Evidência antes de conclusões.
- Diagnóstico antes de planejamento.
- Planejamento antes de mudanças.
- Aprovação explícita antes de implementação.
- Arquitetura atual separada de propostas futuras.
- Documentação proporcional em vez de proliferação de arquivos.
- Rules, Skills e Agents criados a partir de necessidades observadas.
- Documentação canônica referenciada em vez de duplicada.
- Working tree e mudanças não relacionadas preservadas.
- Sem mutações em produção, banco, deploy ou estado externo por padrão.

## Compatibilidade com o Cursor

Os formatos e capacidades do Cursor podem evoluir. Antes de criar Rules, Skills ou Agents, o kit pede ao agente que valide os diretórios, frontmatter, modos de ativação, escopo, ferramentas e opções de somente leitura suportados pela versão instalada e pela documentação oficial atual.

## Escopo

O kit é desenhado para frontend, backend, full-stack, mobile, desktop, APIs, bibliotecas, CLIs, monorepos, microsserviços, sistemas legados, infraestrutura, DevOps/IaC, workers e projetos experimentais. Ele não assume a existência de banco de dados, frontend, backend, testes, CI/CD ou deploy documentado.

## Contribuindo

Contribuições devem preservar o modelo de segurança em etapas e evitar transformar artefatos opcionais em requisitos universais. Mudanças propostas devem explicar o modo de falha ou a necessidade de manutenção que endereçam. Mantenha as versões em inglês (`en/`) e português (`pt-BR/`) em paridade: toda mudança em uma deve ser refletida na outra.

Antes de submeter uma mudança que toque `en/` ou `pt-BR/`, rode a verificação de paridade para validar a paridade estrutural entre as duas versões:

- Linux/macOS: `scripts/check-parity.sh`
- Windows (PowerShell): `scripts/check-parity.ps1`

O script encerra com código `0` quando a paridade é válida e `1` quando encontra divergências, imprimindo as diferenças. Integrar essa verificação no CI é opcional, mas recomendado.
