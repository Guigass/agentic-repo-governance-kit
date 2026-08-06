# Pacote de Prompts — Arquitetura Documental e Governança Agêntica v2

Este pacote transforma a auditoria de um repositório em quatro etapas controladas. Ele preserva a essência do prompt original — análise profunda, documentação baseada em evidências, proporcionalidade, segurança e governança útil — sem concentrar descoberta, planejamento e implementação em uma única execução.

Esta é a tradução em português brasileiro da versão canônica em inglês, disponível em [`en/`](../en/).

## Objetivo

Criar ou melhorar, quando houver justificativa no projeto real:

- documentação técnica e arquitetural;
- documentação de módulos, domínio, fluxos críticos e integrações;
- guias de desenvolvimento, ambiente, testes, deploy e troubleshooting;
- instruções portáteis de agentes (`AGENTS.md`) e rules específicas de ambiente quando justificadas;
- Skills operacionais e reutilizáveis, preferindo o padrão aberto Agent Skills;
- Agents especializados e um router, quando trouxerem benefício real;
- mecanismos para manter documentação e governança sincronizadas com o projeto.

O pacote não autoriza alterações funcionais na aplicação.

## Ordem recomendada

1. Execute [01-DESCOBERTA-E-DIAGNOSTICO.md](01-DESCOBERTA-E-DIAGNOSTICO.md).
2. Revise o diagnóstico e corrija eventuais conclusões.
3. Execute [02-ARQUITETURA-DOCUMENTAL-E-PLANO.md](02-ARQUITETURA-DOCUMENTAL-E-PLANO.md).
4. Execute [03-GOVERNANCA-AGENTICA-E-PLANO.md](03-GOVERNANCA-AGENTICA-E-PLANO.md).
5. Aprove, rejeite ou ajuste o plano consolidado.
6. Somente após aprovação explícita, execute [04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md](04-IMPLEMENTACAO-VALIDACAO-E-RELATORIO.md).

As partes 2 e 3 podem ser executadas na mesma conversa, mas devem continuar sem editar arquivos.

> Pinning para reprodutibilidade: em produção, aponte as URLs raw usadas para carregar as partes do kit para uma tag de versão específica (por exemplo, `/v1.2.3/pt-BR/00-COMO-USAR.md`) em vez de `main`. Veja a seção "Versionamento" em `README.pt-BR.md`.

## Gates obrigatórios

### Gate 1 — Diagnóstico

A Parte 1 deve parar após entregar o diagnóstico. Ela não pode criar ou alterar arquivos.

### Gate 2 — Plano documental e agêntico

As Partes 2 e 3 devem parar depois de listar exatamente o que será criado, atualizado, preservado ou descartado do plano. A existência de um plano não equivale a autorização para implementá-lo.

### Gate 3 — Aprovação explícita

A Parte 4 só pode começar se a conversa contiver aprovação inequívoca do conjunto de arquivos e ações. Exemplos válidos:

- "Aprovado o plano completo. Pode implementar."
- "Aprovados apenas os itens P0 e P1 da tabela."
- "Pode atualizar os três arquivos listados, mas não crie agents."

Frases como "continue", "veja isso" ou "faça o melhor" não substituem uma aprovação clara quando o plano ainda contiver escolhas materiais.

## Como transportar contexto entre conversas

Se cada parte for executada em uma conversa diferente, forneça à próxima etapa:

- o diagnóstico final da Parte 1;
- correções feitas pelo responsável humano;
- o plano documental da Parte 2;
- o plano de governança da Parte 3;
- a decisão de aprovação, com inclusões e exclusões.

Não é necessário transportar todas as mensagens intermediárias.

## Modos de profundidade

O usuário pode informar um modo no início da Parte 1:

- `ENXUTO`: projeto pequeno ou investigação inicial;
- `PADRAO`: profundidade proporcional, recomendada por padrão;
- `PROFUNDO`: sistema grande, legado, crítico ou com múltiplos deployables.

O modo altera a quantidade de amostragem e de fluxos rastreados, não reduz as regras de segurança nem autoriza inferências sem evidência.

## Execução multi-agente

Este kit suporta execução multiagente via o orquestrador de cópia única descrito no `README.pt-BR.md`. O orquestrador inicia um especialista por vez, aguarda seu resultado e transporta as evidências para a próxima etapa. Todos os gates humanos são preservados: diagnóstico e planejamento somente leitura, uma única aprovação humana obrigatória antes de qualquer arquivo ser alterado e uma revisão final de QA. Veja a seção "Orquestrador multi-agente de cópia única" no `README.pt-BR.md` para a cadeia completa e os contratos de artefato.

Fallback: se o ambiente não suportar subagents reais ou tarefas delegadas, execute as mesmas funções sequencialmente no agente principal, mantendo todos os gates intactos. Não finja ter criado subagents.

## Princípios preservados

- Ler antes de escrever.
- Entender antes de sugerir.
- Separar fatos, inferências, ausências de evidência e dúvidas humanas.
- Não inventar arquitetura, banco, integrações, testes ou deploy.
- Preservar o que funciona e evitar duplicação.
- Tratar documentação como um sistema navegável, não como uma coleção de arquivos.
- Criar rules, skills e agents a partir de necessidades observadas.
- Manter o estado atual separado de propostas futuras.
- Explicitar cobertura, limitações e riscos.
- Revisar o diff e não incluir mudanças alheias à tarefa.
- Nenhuma diretiva deste kit autoriza mutação em produção, bancos de dados, deploy ou estado externo; exige autorização humana separada.

Proporcionalidade não é permissão para omissão. Quando o diagnóstico comprovar uma lacuna relevante ou um risco recorrente, o plano deve apresentar uma correção concreta — ainda que enxuta — ou justificar objetivamente por que nenhum novo artefato é apropriado.

## Resultado esperado

Ao final das quatro partes, o projeto deve ganhar uma camada documental e agêntica proporcional, rastreável e utilizável. Também deve ficar claro:

- o que foi comprovado;
- o que foi inferido;
- o que continua desconhecido;
- quais artefatos foram criados e por quê;
- como eles devem ser mantidos;
- o que não foi criado para evitar burocracia.
