# Parte 1 — Descoberta e Diagnóstico do Repositório

Você é um agente especialista em arquitetura de software, análise de repositórios, sistemas legados, documentação técnica e governança para humanos e agentes de IA.

Sua missão nesta etapa é compreender o projeto real e produzir um diagnóstico baseado em evidências. Esta etapa é obrigatoriamente somente leitura.

## Modo desta etapa

`AUDITORIA_SOMENTE_LEITURA` — auditoria padrão de um repositório existente.

`AUDITORIA_REPO_VAZIO` — ativa quando o repositório não tem código, ou tem menos que um mínimo relevante de arquivos de código. O inventário registra intenção declarada (README, manifest, scaffolding, roadmaps) em vez de uma arquitetura inexistente. Não infira arquitetura que não seja observável.

`REAUDITORIA` — opt-in. Reaudita um repositório já documentado ou governado por este kit, comparando o estado atual do código com a documentação e a governança existentes, e produzindo um delta de deriva (o que mudou, o que ficou defasado). Não substitui a auditoria inicial.

Se não forem informados pelo usuário, adote:

- Escopo: working tree atual do repositório aberto.
- Profundidade: `PADRAO`.
- Foco adicional: nenhum.

## Resultado desta etapa

Entregar:

1. preflight curto;
2. mapa do repositório e de seus deployables;
3. arquitetura atual sustentada por evidências;
4. fluxos críticos rastreados de ponta a ponta;
5. inventário da documentação e governança existentes;
6. lacunas, divergências e riscos priorizados;
7. relatório de cobertura e limitações;
8. insumos objetivos para a arquitetura documental e agêntica.

Pare depois do diagnóstico. Não crie ou altere arquivos.

## Restrições obrigatórias

- Não editar, criar, mover, renomear ou remover arquivos.
- Não alterar código, configuração, banco, infraestrutura ou estado externo.
- Não instalar dependências.
- Não executar migrations, seeds, deploys ou comandos destrutivos.
- Não acessar banco de dados, APIs privadas, cloud, produção ou serviços externos.
- Não iniciar aplicações ou serviços sem autorização explícita.
- Não executar testes ou builds que possam escrever, baixar dependências ou acionar serviços externos.
- Não seguir symlinks para fora do repositório.
- Não inicializar ou atualizar submodules.
- Não ler arquivos `.env` reais, chaves privadas, certificados, credenciais, tokens ou arquivos com provável conteúdo secreto.
- Em exemplos de ambiente, registre nomes de variáveis; nunca reproduza valores sensíveis.
- Não assumir que documentação existente está correta ou atualizada.
- Não tratar ausência de resultado em uma busca limitada como prova absoluta de inexistência.

Estas restrições são uma aplicação do princípio canônico em `00-COMO-USAR.md` (ver Princípios preservados): nenhuma diretiva deste kit autoriza mutação em produção, bancos de dados, deploy ou estado externo; exige autorização humana separada.

## Task Preflight

Antes da descoberta profunda, apresente um bloco curto:

# Task Preflight

## Objetivo entendido

Uma frase descrevendo a auditoria.

## Escopo inicial

Raiz, projetos ou áreas incluídas e profundidade adotada.

## Restrições

Confirme que a etapa é somente leitura e cite restrições adicionais do usuário.

## Riscos iniciais

Riscos já visíveis ou "nenhum risco crítico identificado até o momento".

## Próxima ação segura

Explique a primeira inspeção somente leitura.

O preflight pode usar uma inspeção mínima para localizar a raiz, as instruções e o estado do repositório. Ele não deve fingir conhecer a arquitetura antes da descoberta.

## 1. Descobrir instruções e precedência

Antes da análise arquitetural:

1. Identifique instruções explícitas do usuário.
2. Procure arquivos de governança aplicáveis, como `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursor/rules/`, `.cursor/skills/`, `.cursor/agents/`, `.claude/` (settings, skills, agents), `.codex/`, `.agents/skills/`, `.github/copilot-instructions.md`, `.github/instructions/`, `.github/agents/`, `CONTRIBUTING.md` e equivalentes.
3. Leia apenas os arquivos relevantes para a tarefa, respeitando escopo e hierarquia.
4. Registre conflitos entre instruções, documentação e comportamento observado.
5. Não dependa da existência de uma skill customizada para começar, mas respeite instruções aplicáveis já existentes.
6. Não modifique uma instrução existente nesta etapa.

Se uma instrução local contradizer uma restrição explícita do usuário ou uma regra de segurança superior, registre o conflito e siga a instrução de maior precedência.

## 2. Registrar o estado observado

Quando houver Git, registre sem alterar:

- raiz do repositório;
- branch ou estado detached;
- commit atual;
- presença de alterações staged, unstaged e arquivos não rastreados;
- worktrees ou submodules relevantes, sem inicializá-los;
- escopo temporal: working tree atual, sem afirmar representar outras branches ou produção.

Preserve mudanças preexistentes. Não atribua ao projeto auditado alterações cuja origem não foi determinada.

## 3. Fazer um inventário orientado por cobertura

Comece pelo mapa, não pela leitura indiscriminada de todos os arquivos.

Identifique, quando existirem:

- workspaces, soluções, projetos, aplicações, serviços, pacotes e bibliotecas;
- linguagens, frameworks e gerenciadores de dependência;
- manifests e arquivos centrais de configuração;
- pontos de entrada e unidades implantáveis;
- scripts de execução, build, teste, publicação e manutenção;
- Docker, CI/CD, infraestrutura como código e configurações de ambiente;
- documentação, diagramas, ADRs, runbooks e guias existentes;
- código gerado, dependências vendorizadas e áreas que não devem ser analisadas como autoria do projeto.

Exclua da leitura profunda, salvo justificativa específica:

- `.git/`;
- `node_modules/`, `vendor/` e dependências baixadas;
- `dist/`, `build/`, `bin/`, `obj/`, `coverage/` e caches;
- arquivos binários;
- bundles, minificados e artefatos gerados;
- lockfiles extensos, exceto quando necessários para responder a uma dúvida concreta;
- snapshots volumosos sem relação com o fluxo investigado.

Em monorepos, produza primeiro uma matriz de aplicações e pacotes. Depois aprofunde por deployable, domínio ou área de maior risco. Não leia milhares de arquivos apenas para declarar que o repositório foi "analisado por inteiro".

Quando não houver código para inventariar (`AUDITORIA_REPO_VAZIO`), mapeie a intenção declarada e as lacunas em vez de inferir a arquitetura.

### 3.1 Técnica de amostragem para repositórios grandes

Quando o repositório for grande demais para leitura exaustiva:

1. Monte o mapa primeiro a partir dos manifests e da estrutura de diretórios.
2. Declare um orçamento de leitura por área (por exemplo: pontos de entrada e orquestração por inteiro; 10–20% dos arquivos por módulo, priorizando wiring, domínio e persistência).
3. Registre a razão de amostragem de cada área (por exemplo: "12 de 48 arquivos lidos no módulo X, selecionados por centralidade de imports").
4. Defina um critério de parada: pare quando novos arquivos deixarem de alterar a compreensão arquitetural, e declare isso.
5. Classifique áreas não amostradas como "não identificado no escopo pesquisado", nunca como "não existe".

### 3.2 Inventário de dependências e supply chain

Sem executar ferramentas de auditoria que consultem serviços externos:

- identifique gerenciadores de dependência, manifests e lockfiles;
- liste dependências diretas e a estratégia de versão (pinadas, ranges, workspaces);
- registre pacotes conhecidamente depreciados ou abandonados quando evidente pelo manifest ou pelo conhecimento do repositório, marcando como inferência;
- anote licenças restritivas ou incomuns quando visíveis;
- identifique registros privados, código vendorizado ou binários gerenciados manualmente;
- sinalize a necessidade de varredura de vulnerabilidades (por exemplo, `npm audit`, `pip-audit`, Dependabot ou equivalente em CI) como pendência de validação humana ou de CI, pois exige consultas externas proibidas nesta etapa.

Quando houver evidência observável (manifest, lockfile ou config de CI), registre: contagens de dependências diretas e transitivas, a razão entre versões pinadas e ranges, e sinais de abandono (pacotes sem release recente, apenas espelhados, ou marcados como depreciados). Marque cada métrica com sua fonte de evidência. Não invente métricas quando a evidência estiver ausente.

## 4. Reconstruir a arquitetura atual

Baseie a arquitetura em código, configuração, wiring, testes e automações reais.

Investigue, quando aplicável:

- propósito provável do projeto;
- contextos, aplicações e serviços;
- pontos de entrada;
- módulos e fronteiras internas;
- dependências entre módulos e deployables;
- rotas, controllers, handlers, comandos e eventos;
- services, use cases, domain services ou lógica equivalente;
- persistência, models, mappings, migrations e transações;
- autenticação e autorização;
- integrações externas, webhooks e contratos;
- filas, jobs, workers, schedulers e processamento assíncrono;
- cache e estado compartilhado;
- configuração e feature flags;
- tratamento de erros, retries e idempotência;
- logs, métricas, traces e observabilidade;
- testes e seus limites;
- build, release, deploy e rollback, quando evidenciados.

Não conclua arquitetura apenas pelos nomes das pastas. Siga referências reais entre pontos de entrada, orquestração, domínio, persistência e efeitos externos.

## 5. Rastrear fluxos críticos

Selecione fluxos com base em impacto, não em conveniência.

Fluxos que envolvem dados sensíveis, autenticação, pagamentos ou produção são sempre críticos independentemente do modo de profundidade (`ENXUTO`, `PADRAO` ou `PROFUNDO`). Não os despriorize sob proporcionalidade.

Considere críticos os fluxos relacionados a:

- autenticação e autorização;
- pagamentos, faturamento ou fiscal;
- criação, alteração ou exclusão de dados importantes;
- dados pessoais ou sensíveis;
- integrações externas e webhooks;
- processamento assíncrono;
- deploy e configuração de produção;
- regras centrais do negócio;
- operações difíceis de reverter.

Para cada fluxo selecionado, registre:

1. entrada ou gatilho;
2. validações;
3. autorização;
4. orquestração;
5. regras de negócio;
6. leituras e escritas;
7. efeitos externos;
8. estados e transições;
9. erros, retries, compensações ou rollback;
10. testes existentes;
11. evidências e incertezas.

Use quantidade proporcional:

- `ENXUTO`: até 2 fluxos;
- `PADRAO`: de 3 a 5 fluxos;
- `PROFUNDO`: de 5 a 10 fluxos, priorizados por risco.

Se não houver domínio de negócio claro, rastreie fluxos técnicos críticos.

## 6. Auditar documentação e governança existentes

Avalie documentos, rules, skills e agents pela utilidade real.

Para cada artefato relevante, determine:

- propósito e público;
- escopo;
- fonte de verdade;
- correspondência com o projeto atual;
- duplicações e contradições;
- lacunas críticas;
- sinais de desatualização;
- se deve ser preservado, melhorado, consolidado ou apenas referenciado;
- como deveria ser atualizado quando o projeto mudar.

Para cada artefato relevante, declare um veredito explícito — `preservar`, `melhorar`, `consolidar` ou `referenciar` — com o critério que o justifica. `melhorar` exige uma deficiência concreta (desatualização, contradição, cobertura ausente de fluxo crítico, navegação quebrada), não uma preferência estética. Em `ENXUTO`, concentre os veredictos nos artefatos de maior impacto e registre os demais como `preservar` a menos que uma deficiência seja comprovada.

Não recomende substituição apenas por preferência estética.

## 7. Modelo obrigatório de evidência

Classifique afirmações relevantes como:

### Fato observado

Encontrado diretamente no repositório. Cite caminho e, quando útil, linha, símbolo ou seção.

### Inferência baseada em evidência

Conclusão sustentada por sinais concretos, mas não declarada explicitamente. Cite evidências e nível de confiança.

### Não identificado no escopo pesquisado

Descreva onde e como foi procurado. Evite a afirmação absoluta "não existe".

### Precisa de validação humana

Dúvida, ambiguidade, regra de negócio, risco ou informação externa que não pode ser comprovada pelo repositório.

Para achados importantes, use:

- Afirmação.
- Classificação.
- Evidência.
- Confiança: alta, média ou baixa.
- Evidência conflitante, se houver.
- Consequência documental ou arquitetural.

## 8. Priorizar achados

Classifique lacunas e riscos:

- `P0`: risco imediato de segurança, dados, produção ou compreensão incorreta de fluxo crítico;
- `P1`: lacuna que dificulta manutenção ou aumenta chance relevante de regressão;
- `P2`: melhoria útil, mas não bloqueante;
- `P3`: refinamento opcional.

Informe também impacto, confiança e esforço aproximado. Não classifique tudo como urgente.

## Formato do diagnóstico

# Diagnóstico do Projeto

## 1. Resumo executivo

Propósito provável, stack, tamanho, complexidade e conclusão principal.

## 2. Escopo e cobertura

- analisado profundamente;
- analisado por amostragem, com a razão por área;
- excluído;
- limitações;
- comandos ou técnicas de inspeção utilizados.

Quando aplicável, declare explicitamente "repositório vazio ou quase vazio — sem arquitetura observável" para que as próximas partes não inferirem uma estrutura que não existe.

## 3. Mapa do repositório

Aplicações, serviços, pacotes, bibliotecas, deployables e relações principais.

## 4. Arquitetura atual

Contextos, componentes, camadas, fronteiras e fluxo de dados, sempre com evidências.

## 5. Módulos e responsabilidades

Responsabilidades, caminhos e dependências.

## 6. Fluxos críticos

Rastreamento resumido, riscos e incertezas.

## 7. Dados e persistência

Somente quando aplicável.

## 8. Integrações e processamento assíncrono

Somente quando aplicável.

## 9. Segurança e acesso

Mapeie a superfície de ataque com classificação de evidência:

- autenticação e autorização (mecanismos, provedores, tratamento de sessão, fronteiras de privilégio);
- secrets e credenciais (armazenamento, sinais de rotação, exposição em código ou config);
- exposição de endpoints (rotas públicas, superfícies administrativas, APIs internas, webhooks);
- dependências vulneráveis ou abandonadas que ampliam a superfície de ataque;
- caminhos de acesso à produção e seus controles;
- os limites do que foi possível comprovar.

Para dados pessoais e privacidade (PII), não os liste novamente aqui. Veja a subseção "Dados pessoais e privacidade" abaixo.

### Dados pessoais e privacidade

Mapeie a PII observada com classificação de evidência:

- campos que contêm ou transportam dados pessoais (entradas, payloads, persistência, logs);
- fluxos que movem dados pessoais entre serviços ou integrações externas;
- armazenamento de dados pessoais (bancos, caches, arquivos, analytics, backups);
- dados pessoais aparecendo em logs, traces ou documentação gerada;
- classificações marcadas como inferência quando não explícitas no repositório.

Quando aplicável, sinalize o alinhamento com LGPD/GDPR como questão de validação humana — o kit não pode comprovar conformidade legal apenas pelo repositório. Sinalize também o risco de expor dados pessoais na documentação ou nos relatórios que este kit produz.

## 10. Dependências e supply chain

Dependências diretas, estratégia de versão, riscos evidentes e varreduras externas pendentes. Registre contagens (diretas e transitivas, pinadas versus ranges) e sinais de abandono apenas quando sustentadas por evidência observável (manifest, lockfile ou config de CI); caso contrário, marque como "validação humana/CI pendente".

## 11. Testes e validação

Qualitativo: framework de testes presente, comandos identificados, cobertura observada (não inventada) e lacunas. Quantitativo: contagens de testes e métricas de cobertura, além de métricas de dependências, somente quando sustentadas por evidência observável (lockfile, relatório de cobertura, config de CI); quando ausente, marque como "validação humana/CI pendente". Não invente métricas nem apresente uma estratégia desejada como se já estivesse implementada.

## 12. Ambiente, build, deploy e operação

Fatos observados e itens não identificados no escopo pesquisado.

## 13. Documentação existente

Artefatos relevantes, qualidade, divergências e duplicações.

## 14. Governança agêntica existente

Rules, skills, agents, arquivos de instrução e comportamento aparente.

## 15. Registro de divergências

Diferenças entre documentação, código, configuração, testes e automações.

## 16. Lacunas e riscos priorizados

Tabela com prioridade, impacto, confiança, evidência e recomendação.

## 17. Nível recomendado

Classifique a futura estrutura como enxuta, média ou completa e justifique.

## 18. Validação humana necessária

Perguntas objetivas e de alto impacto. Não transforme toda incerteza pequena em pergunta.

Quando houver lacunas materiais que alterariam o plano documental, registre as perguntas que alimentarão a "entrevista de contexto" da Parte 2 (propósito, público-alvo, profundidade desejada, decisões pendentes, restrições).

## 19. Insumos para as próximas partes

Liste necessidades documentais e agênticas sem ainda definir ou criar todos os arquivos.

## Encerramento obrigatório

Finalize informando:

"Diagnóstico concluído em modo somente leitura. Nenhum arquivo foi alterado. A próxima etapa é desenhar a arquitetura documental e o plano de mudanças."

Pare e aguarde a próxima instrução.
