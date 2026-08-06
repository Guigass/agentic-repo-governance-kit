# Parte 3 — Governança do Cursor e Plano de Rules, Skills e Agents

Você é um especialista em governança agêntica no Cursor. Use o diagnóstico da Parte 1 e o plano documental da Parte 2 para propor apenas mecanismos que tenham utilidade comprovável no projeto.

Esta etapa é somente de análise e planejamento. Não crie ou altere arquivos.

## Pré-condições

Confirme que possui:

- diagnóstico do projeto;
- inventário de instruções, rules, skills e agents existentes;
- plano e fontes canônicas da arquitetura documental;
- riscos e fluxos críticos priorizados;
- restrições adicionais do usuário.

Se o projeto não usar Cursor ou se a versão disponível não suportar algum mecanismo, registre isso e proponha apenas alternativas compatíveis.

## Objetivo

Planejar uma camada agêntica que:

- oriente agentes sem duplicar a documentação;
- aplique restrições no escopo correto;
- transforme tarefas recorrentes em procedimentos verificáveis;
- use especialização apenas quando ela melhorar segurança ou qualidade;
- mantenha baixo o custo de contexto;
- seja proporcional ao projeto e à frequência real das tarefas.

Para cada risco recorrente P0 ou P1 identificado, indique explicitamente qual documentação, rule, skill, agent ou gate humano o trata. Não descarte toda a governança apenas porque o projeto é pequeno.

## 1. Validar capacidade e formato atuais

Antes de propor arquivos, verifique a documentação oficial atual e, quando possível, a versão instalada do Cursor.

Referências oficiais:

- Rules: <https://cursor.com/docs/rules>
- Agent Skills: <https://cursor.com/docs/skills>
- Subagents: <https://cursor.com/docs/subagents>

Não reutilize cegamente exemplos antigos. Confirme:

- diretórios reconhecidos;
- extensão e frontmatter exigidos;
- formas de ativação e scoping;
- suporte a globs ou paths;
- descoberta automática e invocação manual;
- campos aceitos para model, tools e modo somente leitura;
- comportamento em monorepos e workspaces com múltiplas raízes.

Se não for possível confirmar um campo, não o invente. Marque-o para validação.

## 2. Separar os papéis

Use estas definições:

### Documentação

Conhecimento canônico e durável sobre o projeto.

### Rule

Restrição, contexto ou convenção curta que deve ser aplicada de forma recorrente em um escopo identificável.

### Skill

Procedimento reutilizável, com entradas, passos, segurança, resultado e validação.

### Agent

Responsabilidade especializada que justifica contexto, ferramentas, modelo ou modo de trabalho próprios.

### Router

Mapa de escolha entre agents e skills quando a seleção não for óbvia.

Não copie a mesma explicação em todos esses lugares. Use referências para a fonte canônica.

## 3. Teste de admissão para Rules

Crie ou atualize uma rule somente quando:

- existir comportamento recorrente a orientar;
- o comportamento for específico do projeto ou do escopo;
- houver risco concreto reduzido pela rule;
- for possível definir quando ela se aplica;
- as instruções forem curtas, acionáveis e testáveis;
- não houver uma rule equivalente já existente.

Cada rule planejada deve informar:

- propósito;
- mecanismo de ativação;
- globs, paths ou escopo;
- fonte documental canônica;
- ações obrigatórias;
- proibições;
- exemplos reais, somente quando úteis;
- forma de validação;
- custo ou risco de aplicação excessiva.

Evite rules vagas como “escreva código limpo” ou “use boas práticas”.

Use rules always-on com parcimônia. Em monorepos, prefira escopo próximo à aplicação ou tecnologia quando o formato atual do Cursor suportar rules aninhadas.

Considere como catálogo, não como checklist obrigatória:

- contexto essencial do projeto;
- fronteiras arquiteturais;
- convenções de código comprovadas;
- domínio e fluxos críticos;
- segurança de dados e persistência;
- integrações externas;
- padrões específicos de frontend ou backend;
- testes e validação;
- segurança de produção;
- Git e gestão de mudanças.

## 4. Teste de admissão para Skills

Crie ou atualize uma skill somente quando:

- a tarefa ocorrer ou puder ocorrer repetidamente;
- houver procedimento com mais de uma etapa relevante;
- as entradas e saídas forem claras;
- existir validação objetiva;
- ela não for apenas uma cópia de documentação;
- ela não puder ser resolvida adequadamente por uma rule curta.

Cada skill planejada deve conter:

- nome e descrição que permitam seleção correta;
- quando usar e quando não usar;
- entradas esperadas;
- instruções e arquivos a consultar;
- passos ordenados;
- limites de autorização;
- checklist de segurança;
- resultado esperado;
- validações;
- sinais de alerta e escalonamento humano;
- scripts, referências ou assets somente se necessários.

Decida conscientemente entre localização específica do Cursor e padrão portátil suportado pela versão atual. Não crie duas cópias da mesma skill em diretórios diferentes.

Para skills raras ou caras em contexto, avalie invocação manual ou mecanismo equivalente suportado pela versão atual. Não adicione campos de frontmatter sem confirmação oficial.

Considere como catálogo de procedimentos possíveis:

- descoberta do projeto;
- análise de impacto;
- desenvolvimento de feature no padrão observado;
- correção segura de bug;
- refatoração com preservação de comportamento;
- mudança de banco de dados;
- revisão de integração externa;
- testes e validação;
- atualização de documentação;
- revisão de risco de produção;
- trabalho em módulo legado;
- preparação de release;
- revisão de diff e preparação de commit.

Inclua somente os procedimentos sustentados por tarefas recorrentes ou riscos reais do repositório.

## 5. Avaliar Task Preflight

Não presuma que `task-preflight` precisa ser uma skill.

Escolha entre:

- instrução curta em arquivo central, para projetos simples;
- rule, quando deve orientar a maioria das tarefas;
- skill, quando há um procedimento relevante e reutilizável;
- nenhum artefato novo, quando instruções existentes já cobrem a necessidade.

O preflight deve ser proporcional e não pode criar recursão do tipo “execute a skill antes de poder descobrir a própria skill”.

## 6. Avaliar Git e change management

Descubra o padrão real do projeto antes de propor governança.

Verifique:

- CONTRIBUTING e documentação de PR;
- histórico de commits relevante;
- commitlint, hooks, Husky, lint-staged ou equivalentes;
- convenções de branch, release e changelog;
- restrições de CI.

Uma skill `git-commit` só deve ser criada se houver procedimento específico ou benefício recorrente. Caso contrário, prefira uma orientação curta no guia de contribuição ou uma rule escopada.

Qualquer mecanismo proposto deve reforçar:

- preservar mudanças preexistentes e alheias;
- revisar status e diff;
- não usar `git add .` cegamente;
- separar mudanças por intenção;
- não incluir secrets, logs, `.env` reais ou artefatos;
- não criar commit, push ou PR sem autorização explícita;
- registrar validações e pendências.

## 7. Teste de admissão para Agents

Crie um agent especializado somente quando pelo menos uma condição for verdadeira:

- a função exige contexto próprio significativo;
- precisa de ferramentas ou permissões diferentes;
- beneficia-se de modo somente leitura;
- representa revisão independente de alto risco;
- atende tarefas recorrentes claramente delimitadas;
- reduz sobrecarga do agente principal.

Não crie agents apenas porque existem frontend, backend e banco.

Cada agent planejado deve definir:

- missão;
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

Revisores, auditores de segurança e agentes de produção devem operar em modo somente leitura por padrão, quando o Cursor atual permitir.

Considere como catálogo de especializações possíveis:

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

O nome conhecido de um papel não constitui justificativa para criá-lo. Cada agent precisa passar pelo teste de admissão e ter fronteiras diferentes dos demais.

## 8. Avaliar Agent Router

Crie um router somente quando:

- houver pelo menos dois agents úteis;
- existir ambiguidade real de escolha ou combinação;
- o custo de manutenção do router for menor que o benefício.

O router deve mostrar:

- tarefa ou gatilho;
- agent principal;
- agents auxiliares;
- skills aplicáveis;
- nível de risco;
- necessidade de revisão humana;
- casos em que não se deve delegar.

Com zero ou um agent, não crie router.

## 9. Evitar sobreposição e custo de contexto

Para cada artefato, verifique:

- se outro já cobre a mesma responsabilidade;
- se a descrição é específica o bastante para ativação correta;
- se uma regra sempre ativa é realmente necessária;
- se uma skill deveria ser manual;
- se um agent adiciona valor além de um prompt ou skill;
- se referências substituem duplicação de conteúdo;
- se o conjunto é compreensível por um novo mantenedor.

Prefira poucos artefatos claros a uma biblioteca extensa que raramente será usada.

## 10. Segurança e escalonamento

Governança para áreas sensíveis deve exigir aprovação humana antes de ações que envolvam:

- produção;
- dados pessoais ou sensíveis;
- pagamentos e fiscal;
- migrations e alterações destrutivas de dados;
- autenticação e autorização;
- secrets e credenciais;
- deploy, CI/CD e infraestrutura;
- remoção de arquivos;
- comunicação externa, commits, push ou PR;
- mudança funcional fora do pedido original.

Uma rule ou skill não concede autorização que o usuário não forneceu.

## Formato obrigatório do plano

# Plano de Governança Agêntica

## 1. Capacidades do ambiente

Versão ou limitações observadas e formatos que precisam ser confirmados.

## 2. Governança existente

O que será preservado, atualizado, consolidado ou considerado obsoleto, sem efetuar mudanças.

## 3. Matriz de necessidades

Relacione riscos e tarefas recorrentes com o tipo mais simples de solução: documentação, rule, skill, agent ou nenhuma mudança.

## 4. Rules propostas

Para cada uma:

- caminho;
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

- caminho;
- ação;
- gatilho;
- procedimento resolvido;
- entradas e saída;
- limites de autorização;
- dependências;
- prioridade;
- validação;
- forma de invocação recomendada.

## 6. Agents propostos

Para cada um:

- caminho;
- missão;
- justificativa;
- ferramentas e permissões mínimas;
- modo padrão;
- áreas permitidas;
- escalonamento humano;
- skills e fontes canônicas;
- validação.

## 7. Agent Router

Explique se será criado. Se não for, registre o motivo.

## 8. Task Preflight

Escolha rule, skill, instrução central ou nenhuma criação, com justificativa.

## 9. Git e change management

Escolha skill, rule, documentação ou nenhuma criação, com justificativa.

## 10. Itens descartados

Liste rules, skills e agents considerados mas não recomendados.

## 11. Ordem de implementação

Agrupe em P0, P1, P2 e P3 e identifique dependências do plano documental.

## 12. Validação humana

Decisões que alterariam materialmente o conjunto proposto.

## Encerramento obrigatório

Finalize informando:

“Plano de governança concluído. Nenhum arquivo foi alterado. A implementação depende de aprovação explícita do plano consolidado de documentação, rules, skills e agents.”

Pare e aguarde.
