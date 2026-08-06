# Parte 3 — Governança Agêntica e Plano de Rules, Skills e Agents

Você é um especialista em governança agêntica multiambiente. Use o diagnóstico da Parte 1 e o plano documental da Parte 2 para propor apenas mecanismos que tenham utilidade comprovável no projeto.

Esta etapa é somente de análise e planejamento. Não crie ou altere arquivos.

## Pré-condições

Confirme que possui:

- diagnóstico do projeto;
- inventário de instruções, rules, skills e agents existentes;
- plano e fontes canônicas da arquitetura documental;
- riscos e fluxos críticos priorizados;
- restrições adicionais do usuário.

Se o projeto não usar nenhum IDE ou CLI com suporte a agentes, ou se um ambiente disponível não suportar algum mecanismo, registre isso e proponha apenas alternativas compatíveis.

## Objetivo

Planejar uma camada agêntica que:

- oriente agentes sem duplicar a documentação;
- aplique restrições no escopo correto;
- transforme tarefas recorrentes em procedimentos verificáveis;
- use especialização apenas quando ela melhorar segurança ou qualidade;
- mantenha baixo o custo de contexto;
- seja proporcional ao projeto e à frequência real das tarefas;
- prefira padrões portáteis e adicione adaptadores específicos de ambiente só quando necessário.

Para cada risco recorrente P0 ou P1 identificado, indique explicitamente qual documentação, rule, skill, agent ou gate humano o trata. Não descarte toda a governança apenas porque o projeto é pequeno.

## 1. Detectar ambientes-alvo

Antes de propor arquivos, identifique quais ambientes de agente o projeto e a equipe realmente usam.

Procure sinais no repositório:

- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`;
- `.cursor/` (rules, skills, agents);
- `.claude/` (settings, skills, agents);
- `.codex/`;
- `.gemini/`;
- `.agents/skills/`;
- `.github/copilot-instructions.md`, `.github/instructions/`, `.github/agents/`.

Quando os sinais estiverem ausentes ou ambíguos, pergunte ao usuário quais ambientes a equipe usa. Registre cada ambiente não usado como "não aplicável". Não invente adaptadores para ambientes que ninguém usa.

## 1.1 Validar capacidade e formato atuais

Para cada ambiente-alvo aprovado, verifique a documentação oficial atual e, quando possível, a versão instalada. Não invente campos, diretórios ou modos de ativação.

Referências oficiais (valide contra a documentação vigente; não trate esta tabela como congelada):

| Camada / ambiente | Caminhos típicos | Docs oficiais a validar |
| --- | --- | --- |
| Portável — AGENTS.md | `AGENTS.md` (raiz e aninhado quando suportado) | <https://agents.md/> |
| Portável — Agent Skills | `.agents/skills/<skill-name>/SKILL.md` | <https://agentskills.io/home> |
| Cursor | `.cursor/rules/`, `.cursor/skills/`, `.cursor/agents/` | Rules <https://cursor.com/docs/rules>; Skills <https://cursor.com/docs/skills>; Subagents <https://cursor.com/docs/subagents> |
| Claude Code | `CLAUDE.md` (importe conteúdo portável com `@AGENTS.md`), `.claude/skills/`, `.claude/agents/` | Docs do Claude Code para CLAUDE.md, skills e subagents |
| Codex | `AGENTS.md` (raiz/aninhado; também pode ler `~/.codex/AGENTS.md`), `.agents/skills/` | Docs do Codex para AGENTS.md e Agent Skills; respeite limites de tamanho documentados |
| GitHub Copilot | `.github/copilot-instructions.md`, `.github/instructions/`, `.github/agents/*.agent.md` | Docs do Copilot coding agent e custom agents |
| Gemini CLI | `AGENTS.md` e/ou `GEMINI.md` via `.gemini/settings.json` | Docs de contexto/settings do Gemini CLI |

Confirme por ambiente:

- diretórios reconhecidos;
- extensão e frontmatter exigidos;
- formas de ativação e scoping;
- suporte a globs ou paths;
- descoberta automática e invocação manual;
- campos aceitos para model, tools e modo somente leitura;
- comportamento em monorepos e workspaces com múltiplas raízes;
- limites de tamanho ou contexto (por exemplo, limites do AGENTS.md no Codex).

Se um campo não puder ser confirmado, não o invente. Marque-o para validação.

## 2. Separar os papéis

Use estas definições:

### Documentação

Conhecimento canônico e durável sobre o projeto.

### Rule

Uma restrição, contexto ou convenção curta que deve ser aplicada de forma recorrente em um escopo identificável.

### Skill

Um procedimento reutilizável, com entradas, passos, segurança, saída e validação.

### Agent

Uma responsabilidade especializada que justifica contexto, ferramentas, modelo ou modo de trabalho próprios.

### Router

Um mapa de escolha entre agents e skills quando a seleção não é óbvia.

Não copie a mesma explicação para todos esses lugares. Use referências à fonte canônica.

## 2.1 Governança portável como camada canônica

Prefira padrões portáteis primeiro. Arquivos específicos de ambiente são adaptadores, não fontes paralelas de verdade.

### AGENTS.md

Trate um `AGENTS.md` na raiz como a camada portável padrão de instruções quando pelo menos uma das condições abaixo for verdadeira:

- o projeto usa mais de um ambiente de agente; ou
- há regras que não são específicas de um único ambiente e se beneficiariam de uma única fonte portável; ou
- a equipe quer um único ponto de entrada mesmo em um ambiente único que já lê AGENTS.md nativamente (Codex, Cursor, Copilot, Gemini CLI e outros).

Teste de admissão para arquivos de instrução específicos de ambiente:

- crie ou mantenha `CLAUDE.md`, `.github/copilot-instructions.md`, `GEMINI.md`, rules do Cursor ou equivalentes apenas para conteúdo que não é portável (hooks, wiring exclusivo do ambiente, frontmatter específico do formato, ativação exclusiva do ambiente);
- esses arquivos devem referenciar `AGENTS.md` (ou a documentação canônica) em vez de duplicar regras compartilhadas;
- no Claude Code, a ponte usual é um `CLAUDE.md` que começa com `@AGENTS.md` e depois adiciona apenas notas específicas do Claude.

Em projetos de um único ambiente em que um arquivo portável não agrega valor além de um arquivo de ambiente já existente, registre a decisão e evite duplicação.

### Agent Skills (padrão aberto)

Prefira o formato aberto Agent Skills — um diretório com `SKILL.md` (frontmatter YAML com pelo menos `name` e `description`, mais instruções em Markdown) e opcionalmente `scripts/`, `references/` e `assets/` — sob `.agents/skills/` quando os ambientes aprovados o suportarem.

Teste de admissão para cópias de skill específicas de ambiente:

- não crie duas cópias da mesma skill em diretórios diferentes;
- coloque uma skill sob `.cursor/skills/`, `.claude/skills/` ou outro caminho de ambiente somente quando esse ambiente não puder consumir `.agents/skills/` ou quando uma extensão específica do ambiente for necessária e aprovada;
- wrappers de skill específicos de ambiente devem referenciar a skill portável ou a documentação canônica em vez de duplicar o procedimento.

## 3. Teste de admissão de Rules

Crie ou atualize uma rule somente quando:

- houver comportamento recorrente a orientar;
- o comportamento for específico do projeto ou do escopo;
- houver um risco concreto reduzido pela rule;
- for possível definir quando ela se aplica;
- as instruções forem curtas, acionáveis e testáveis;
- não houver rule equivalente já em vigor.

Uma rule ou skill específica de testes deve ser condicionada a risco recorrente comprovado (por exemplo, um fluxo crítico frágil com regressões repetidas). Não transforme governança de testes em exigência universal.

Cada rule planejada deve declarar:

- propósito;
- camada: `portable` ou um ambiente específico;
- caminho(s) por ambiente aprovado;
- mecanismo de ativação;
- globs, paths ou escopo;
- fonte documental canônica;
- ações obrigatórias;
- proibições;
- exemplos reais, somente quando úteis;
- método de validação;
- custo ou risco de aplicação excessiva.

Evite rules vagas como "escreva código limpo" ou "use boas práticas".

Use rules always-on com parcimônia. Em monorepos, prefira escopo próximo da aplicação ou da tecnologia quando o formato atual do ambiente suportar rules aninhadas.

Considere o seguinte como catálogo, não como checklist obrigatório:

- contexto essencial do projeto;
- limites arquiteturais;
- convenções de código comprovadas;
- domínio e fluxos críticos;
- segurança de dados e persistência;
- integrações externas;
- padrões específicos de frontend ou backend;
- testes e validação;
- segurança de produção;
- Git e gestão de mudanças.

## 4. Teste de admissão de Skills

Crie ou atualize uma skill somente quando:

- a tarefa ocorre, ou pode ocorrer, de forma repetida;
- o procedimento tem mais de um passo relevante;
- entradas e saídas são claras;
- há validação objetiva;
- não é apenas uma cópia da documentação;
- não pode ser resolvida adequadamente por uma rule curta.

Uma skill específica de testes deve ser condicionada a risco recorrente comprovado, não a uma expectativa genérica de boas práticas. Não torne a governança de testes uma exigência universal.

Cada skill planejada deve conter:

- nome e descrição que permitam a seleção correta;
- camada: `portable` ou um ambiente específico;
- caminho(s) por ambiente aprovado;
- quando usar e quando não usar;
- entradas esperadas;
- instruções e arquivos a consultar;
- passos ordenados;
- limites de autorização;
- checklist de segurança;
- saída esperada;
- validações;
- sinais de alerta e escalonamento humano;
- scripts, referências ou assets somente se necessários.

Prefira `.agents/skills/<skill-name>/SKILL.md` quando suportado. Decida conscientemente entre uma localização portável e uma localização específica do ambiente suportada pela versão atual. Não crie duas cópias da mesma skill em diretórios diferentes.

Para skills raras ou caras em contexto, avalie invocação manual ou um mecanismo equivalente suportado pela versão atual. Não adicione campos de frontmatter sem confirmação oficial.

Considere o seguinte como catálogo de procedimentos possíveis:

- descoberta do projeto;
- análise de impacto;
- desenvolvimento de feature seguindo o padrão observado;
- correção segura de bugs;
- refatoração que preserve comportamento;
- mudança de banco de dados;
- revisão de integração externa;
- testes e validação;
- atualização de documentação;
- revisão de risco de produção;
- trabalho em módulo legado;
- preparação de release;
- revisão de diff e preparação de commit;
- planejamento de roadmap para uma nova feature ou parte do sistema.

Inclua apenas procedimentos suportados por tarefas recorrentes ou riscos reais do repositório.

## 5. Avaliar Task Preflight

Não assuma que `task-preflight` precisa ser uma skill.

Escolha entre:

- uma instrução curta em um arquivo central, para projetos simples;
- uma rule, quando deve orientar a maioria das tarefas;
- uma skill, quando há um procedimento relevante e reutilizável;
- nenhum artefato novo, quando instruções existentes já cobrem a necessidade.

O preflight deve ser proporcional e não deve criar recursão do tipo "execute a skill antes de conseguir descobrir a própria skill".

## 6. Avaliar Git e gestão de mudanças

Descubra o padrão real do projeto antes de propor governança.

Verifique:

- CONTRIBUTING e documentação de PR;
- histórico relevante de commits;
- commitlint, hooks, Husky, lint-staged ou equivalentes;
- convenções de branch, release e changelog;
- restrições de CI.

Uma skill `git-commit` só deve ser criada se houver um procedimento específico ou benefício recorrente. Caso contrário, prefira uma orientação curta no guia de contribuição ou uma rule com escopo definido.

Qualquer mecanismo proposto deve reforçar:

- preservar mudanças pré-existentes e não relacionadas;
- revisar status e diff;
- não usar `git add .` cegamente;
- separar mudanças por intenção;
- não incluir segredos, logs, arquivos `.env` reais ou artefatos;
- não criar commits, push ou PRs sem autorização explícita;
- registrar validações e pendências.

## 7. Avaliar Planejamento de Roadmap

Não assuma que todo repositório precisa de uma skill `roadmap-planning`.

Crie ou atualize uma skill `roadmap-planning` quando pelo menos uma condição for verdadeira:

- o projeto tem entrega ativa de features ou partes do sistema e vai planejar trabalho em ondas mais de uma vez;
- humanos ou agents já inventam planos ad hoc sem fundamentar no repositório real;
- uma estrutura de skills está sendo criada ou atualizada e o projeto não é um experimento descartável.

Prefira uma skill a duplicar um ensaio longo de planejamento em rules always-on. Se a necessidade for rara e pontual, prefira um ponteiro curto no guia de contribuição ou no workflow agêntico, ou nenhum artefato novo.

Quando a skill for proposta, ela deve codificar um procedimento somente-leitura-até-aprovação, por ondas, que:

- reutilize um diagnóstico existente do projeto quando houver, e caso contrário execute uma análise somente leitura escopada;
- separe o estado atual das ondas propostas;
- proponha arquivos sob `docs/roadmap/<nome-do-plano>/` (visão geral, contexto e um arquivo por onda; artefatos opcionais mais profundos só quando justificados);
- pare para aprovação humana explícita antes de escrever qualquer arquivo;
- produza apenas o roadmap — não deve implementar a feature, alterar código funcional nem mutar produção, bancos, deploy ou estado externo;
- registre classes de evidência (fato observado, inferência, não identificado, precisa de validação humana) quando forem materiais.

Prefira `.agents/skills/roadmap-planning/SKILL.md` quando suportado. Use um caminho de skills específico do ambiente somente quando aprovado e necessário; não duplique a mesma skill em múltiplas raízes.

## 8. Teste de admissão de Agents

Crie um agent especializado somente quando pelo menos uma condição for verdadeira:

- o papel exige contexto dedicado significativo;
- precisa de ferramentas ou permissões diferentes;
- se beneficia do modo somente leitura;
- representa revisão independente de alto risco;
- atende tarefas recorrentes claramente delimitadas;
- reduz a carga do agent principal.

Não crie agents só porque existem frontend, backend e banco de dados.

Planeje missão, gatilhos, responsabilidades, entradas, ferramentas, permissões, limites de mudança, escalonamento, formato de entrega, critérios de qualidade e condições de parada em termos neutros de ambiente primeiro. Em seguida, mapeie cada agent aprovado para o formato de subagent ou custom agent de cada ambiente aprovado. Subagents são o mecanismo menos portável; não invente um formato compartilhado entre ambientes.

Cada agent planejado deve definir:

- missão;
- camada: `portable` (definição da missão) e caminho(s) específico(s) do ambiente;
- gatilhos de uso;
- responsabilidades;
- entradas;
- áreas que deve analisar;
- ferramentas e permissões mínimas;
- o que pode alterar;
- o que exige revisão humana;
- documentação e skills relacionadas;
- formato de entrega;
- critérios de qualidade;
- limites de escopo e condições de parada.

Reviewers, auditores de segurança e agents de produção devem operar em modo somente leitura por padrão, quando o ambiente atual permitir.

Considere o seguinte como catálogo de especializações possíveis:

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

Um nome de papel conhecido não é justificativa para criá-lo. Cada agent deve passar no teste de admissão e ter limites diferentes dos demais.

## 9. Avaliar Agent Router

Crie um router somente quando:

- houver pelo menos dois agents úteis;
- houver ambiguidade real de escolha ou combinação;
- o custo de manutenção do router for menor que o benefício.

O router deve mostrar:

- tarefa ou gatilho;
- agent principal;
- agents auxiliares;
- skills aplicáveis;
- nível de risco;
- necessidade de revisão humana;
- casos em que a delegação não deve ocorrer.

Custo-benefício: roteie tarefas mecânicas, de baixo risco ou somente leitura (formatação, renomeação, buscas) para um modelo leve. Reserve um modelo forte para inferência complexa, arquitetura, segurança e decisões críticas. O gate humano para produção é preservado independentemente do roteamento. Este critério só se aplica quando o ambiente suporta múltiplos modelos ou agents; em ambiente de modelo único, registre "não aplicável".

Com zero ou um agent, não crie um router.

## 10. Evitar sobreposição e custo de contexto

Para cada artefato, verifique:

- se outro já cobre a mesma responsabilidade;
- se conteúdo portável está duplicado em um adaptador de ambiente;
- se a descrição é específica o bastante para ativação correta;
- se uma rule always-on é realmente necessária;
- se uma skill deve ser manual;
- se um agent agrega valor além de um prompt ou skill;
- se referências substituem a duplicação de conteúdo;
- se o conjunto é compreensível por um novo mantenedor.

Prefira poucos artefatos claros a uma biblioteca extensa que raramente será usada.

## 11. Segurança e escalonamento

A governança de áreas sensíveis deve exigir aprovação humana antes de ações envolvendo:

- produção;
- dados pessoais ou sensíveis, incluindo PII (dados pessoais e privacidade);
- pagamentos e assuntos fiscais;
- migrações e mudanças destrutivas de dados;
- autenticação e autorização;
- segredos e credenciais;
- deploy, CI/CD e infraestrutura;
- remoção de arquivos;
- comunicação externa, commits, push ou PRs;
- mudança funcional além do pedido original.

Uma rule ou skill não concede autorização que o usuário não forneceu.

Esta seção é uma aplicação do princípio canônico em `00-COMO-USAR.md` (veja Princípios preservados): nenhuma diretriz deste kit autoriza mutação de produção, bancos de dados, deploy ou estado externo; exige autorização humana separada.

## Formato obrigatório do plano

# Plano de Governança Agêntica

## 1. Ambientes-alvo e matriz de capacidades

Ambientes aprovados, sinais observados, limitações de versão ou formato e campos que precisam de confirmação. Marque ambientes não usados como "não aplicável".

## 2. Governança existente

O que será preservado, atualizado, consolidado ou considerado obsoleto, sem fazer alterações. Inclua arquivos portáteis e adaptadores específicos de ambiente.

## 3. Matriz de necessidades

Relacione riscos e tarefas recorrentes ao tipo de solução mais simples: documentação, instrução portável, rule, skill, agent ou nenhuma mudança.

## 4. Rules propostas

Para cada uma:

- camada: `portable` ou `<ambiente>`;
- caminho(s);
- ação;
- gatilho e escopo;
- motivo e evidência;
- fonte canônica;
- resumo das instruções;
- prioridade;
- risco de conflito;
- validação.

## 5. Skills propostas

Para cada uma:

- camada: `portable` ou `<ambiente>`;
- caminho(s);
- ação;
- gatilho;
- procedimento resolvido;
- entradas e saída;
- limites de autorização;
- dependências;
- prioridade;
- validação;
- modo de invocação recomendado.

## 6. Agents propostos

Para cada um:

- camada e caminho(s) específico(s) do ambiente;
- missão;
- justificativa;
- ferramentas e permissões mínimas;
- modo padrão;
- áreas permitidas;
- escalonamento humano;
- skills e fontes canônicas;
- validação.

## 7. Agent Router

Explique se será criado. Se não, registre o motivo. Quando o router for criado e o ambiente suportar múltiplos modelos ou agents, inclua uma justificativa por tarefa do modelo escolhido (leve para tarefas mecânicas ou de baixo risco; forte para inferência complexa, arquitetura, segurança e decisões críticas). Em ambiente de modelo único, registre "não aplicável".

## 8. Task Preflight

Escolha rule, skill, instrução central ou nenhuma criação, com justificativa.

## 9. Git e gestão de mudanças

Escolha skill, rule, documentação ou nenhuma criação, com justificativa.

## 10. Planejamento de roadmap

Escolha skill, ponteiro em documentação ou nenhuma criação, com justificativa. Se uma skill for proposta, declare caminho, gatilho, saídas por ondas sob `docs/roadmap/<nome-do-plano>/` e o gate humano antes de escrever.

## 11. Itens descartados

Liste rules, skills e agents considerados mas não recomendados.

## 12. Ordem de implementação

Agrupe em P0, P1, P2 e P3 e identifique dependências do plano documental.

## 13. Validação humana

Decisões que mudariam materialmente o conjunto proposto.

## Encerramento obrigatório

Finalize declarando:

"Plano de governança concluído. Nenhum arquivo foi alterado. A implementação depende de aprovação explícita do plano consolidado de documentação, rules, skills e agents."

Pare e aguarde.
