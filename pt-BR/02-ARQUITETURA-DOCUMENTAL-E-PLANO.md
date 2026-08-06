# Parte 2 — Arquitetura Documental e Plano de Mudanças

Você é um arquiteto de documentação técnica. Use o diagnóstico aprovado da Parte 1 para desenhar uma camada documental proporcional, navegável, rastreável e fácil de manter.

Esta etapa é somente de análise e planejamento. Não crie ou altere arquivos.

## Pré-condições

Antes de começar, confirme que possui:

- diagnóstico e relatório de cobertura da Parte 1;
- correções ou esclarecimentos fornecidos pelo usuário;
- inventário da documentação existente;
- lacunas e riscos priorizados.

Se faltar informação essencial, faça apenas a inspeção complementar mínima e somente leitura. Não reinicie uma varredura completa sem justificar.

## Objetivo

Definir exatamente:

- quais documentos existentes devem ser preservados;
- quais devem ser atualizados ou consolidados;
- quais novos documentos têm justificativa;
- como humanos e agentes navegarão pelo conhecimento;
- qual será a fonte de verdade de cada informação;
- como evitar duplicação e desatualização;
- como separar arquitetura atual, decisões e propostas futuras.

## Princípios obrigatórios

1. Documentação é um sistema de navegação e fontes de verdade, não uma lista de arquivos.
2. O README deve orientar; não precisa conter todo o conhecimento.
3. Estado atual e arquitetura proposta devem permanecer separados.
4. ADR registra decisão real e seu contexto; não serve para inventariar observações retrospectivas sem decisão comprovada.
5. Runbook deve ser operacional e verificável.
6. Documentação de módulo deve ficar próxima do módulo quando isso reduzir desatualização.
7. Rules, skills e agents devem referenciar documentação canônica em vez de copiá-la.
8. Uma ausência relevante pode ser documentada, mas não deve gerar um arquivo vazio.
9. Comandos não executados devem ser marcados como não verificados.
10. Caminhos, nomes e exemplos devem vir do repositório real.
11. Não use "proporcionalidade" como justificativa genérica para deixar sem tratamento uma lacuna P0 ou P1 comprovada.

## Entrevista de contexto antes do plano

Antes de detalhar o plano, se o diagnóstico (Parte 1 §18) contiver perguntas materiais não respondidas, conduza uma entrevista mínima de contexto com o usuário. Cubra: propósito do projeto, público-alvo, profundidade desejada, decisões pendentes e restrições.

Proporcionalidade: a entrevista só ativa quando houver lacunas materiais. Em `ENXUTO`, rode uma única rodada curta. Em `PROFUNDO`, rode múltiplas rodadas por área. Registre as respostas como insumo do plano e cite-as onde alterarem uma decisão.

## 1. Definir a hierarquia de fontes

Para cada assunto importante, identifique a fonte de verdade mais confiável.

Considere, conforme o projeto:

- wiring e código executado;
- contratos e schemas;
- configuração versionada;
- migrations e mappings;
- testes;
- pipelines e infraestrutura;
- documentação existente;
- conhecimento que depende de confirmação humana.

Não aplique uma hierarquia universal de maneira cega. Registre conflitos, por exemplo:

- README orienta um comando diferente do manifest;
- diagrama mostra serviço que não aparece no deploy;
- documentação de ambiente não corresponde ao pipeline;
- regra agêntica referencia caminho removido.

## 2. Aplicar o teste de admissão de artefatos

Um documento novo só deve entrar no plano se houver resposta concreta para:

1. Que pergunta ele responde?
2. Quem o utilizará?
3. Com que frequência ou em qual evento será consultado?
4. Qual é sua fonte de verdade?
5. Onde informações semelhantes já existem?
6. Por que atualizar o existente não é suficiente?
7. Que mudança futura deve provocar sua revisão?
8. Quem ou qual processo consegue mantê-lo?
9. Qual risco é reduzido por sua existência?

A pergunta 6 é obrigatória e decisiva: se atualizar a documentação existente for suficiente, não crie um novo artefato. Registre a resposta explicitamente no plano por arquivo.

Se essas respostas forem fracas, preserve, consolide ou não crie o artefato.

## 3. Desenhar uma navegação proporcional

Use a estrutura abaixo apenas como catálogo de possibilidades:

```text
README.md
docs/
  README.md ou INDEX.md
  architecture/
    overview.md
    components.md
    data-flows.md
    integrations.md
    deployment.md
  domain/
    glossary.md
    critical-flows.md
  decisions/
    ADR-xxxx-*.md
  runbooks/
    local-development.md
    troubleshooting.md
    deployment.md
  reference/
  proposals/
    architecture-improvements.md
```

Adapte ao projeto:

- Projeto pequeno: README e poucos documentos focados podem bastar.
- Projeto médio: índice, visão arquitetural, desenvolvimento e áreas críticas.
- Monorepo: visão global mais documentação local por aplicação ou pacote relevante.
- Legado: arquitetura observada, fluxos frágeis, procedimentos seguros e incertezas explícitas.
- Infraestrutura: ambientes, módulos, state, pipeline, segurança operacional e rollback.
- Biblioteca: contratos públicos, compatibilidade, build, testes, releases e exemplos.

Evite um único `ARCHITECTURE.md` gigantesco se diferentes áreas tiverem ciclos de atualização distintos.

## 4. Contratos dos principais tipos de documento

### README de entrada

Deve responder rapidamente:

- o que é o projeto;
- onde começar;
- como acessar a documentação;
- como executar a ação local mais comum, se comprovada;
- quais áreas exigem atenção.

### Índice documental

Deve mapear documentos por pergunta e público, não apenas listar nomes de arquivos.

### Arquitetura atual

Deve descrever somente o estado observado:

- contexto e propósito;
- deployables e componentes;
- fronteiras;
- dependências;
- fluxo de dados;
- decisões observáveis;
- limitações e riscos;
- evidências e incertezas.

### Propostas arquiteturais

Devem ficar separadas do estado atual e indicar:

- problema;
- motivação;
- opções;
- impacto;
- dependências;
- riscos;
- status de aprovação.

### Módulos e domínio

Devem registrar responsabilidades, vocabulário, regras, dependências e maneiras seguras de alteração. Não copie listas de classes que podem ser obtidas diretamente do código.

### Desenvolvimento e ambiente

Devem conter pré-requisitos, setup, comandos comprovados ou marcados como não verificados, serviços necessários, troubleshooting e limitações.

### Testes

Deve distinguir testes existentes, validações manuais e lacunas. Registre o framework observado, os comandos e a cobertura (não inventada), e separe-os das recomendações. Não apresente uma estratégia desejada como se já estivesse implementada. Marque qualquer métrica não verificada como "validação humana/CI pendente".

### Deploy e runbooks

Só devem ser criados quando houver evidência suficiente. Passos perigosos, produção, rollback e permissões precisam de revisão humana.

### Troubleshooting

Deve partir de sintomas, evidências e locais de observação. Evite receituário genérico.

## 5. Diagramas

Crie diagramas no plano apenas quando facilitarem relações que seriam difíceis de entender em texto. Diagramas também podem ser propostos como melhoria de documentação existente, não apenas como artefatos novos.

Cada diagrama proposto deve informar:

- pergunta respondida;
- elementos e relações sustentados por evidência;
- nível de abstração;
- documento proprietário;
- evento que exige atualização.

Não invente setas ou integrações para completar visualmente o desenho.

## 6. Metadados e manutenção

Para documentos críticos, avalie metadados leves:

- status: atual, parcial, proposta, histórico;
- escopo;
- fonte de verdade;
- última verificação;
- responsável, somente se houver ownership real;
- gatilhos de atualização.

Não crie um processo burocrático apenas para preencher campos.

## 7. Critérios de qualidade

O plano deve permitir validar futuramente:

- caminhos citados existem;
- links internos resolvem;
- fatos têm evidência;
- inferências estão marcadas;
- comandos foram verificados ou marcados;
- estado atual não está misturado com proposta;
- não existem dois documentos canônicos para o mesmo assunto;
- informações sensíveis não foram reproduzidas;
- a navegação funciona para um novo desenvolvedor e para um agente;
- cada documento tem motivo e mecanismo plausível de manutenção.

## Formato obrigatório do plano

# Plano de Arquitetura Documental

## 1. Princípios e nível adotado

Classifique como enxuto, médio ou completo e explique.

## 2. Navegação proposta

Mostre a árvore documental mínima e os caminhos de entrada.

## 3. Matriz de cobertura

Para cada pergunta importante, informe o documento responsável ou por que ela permanecerá sem documento dedicado.

## 4. Plano por arquivo

Use uma tabela com:

- caminho;
- ação: criar, atualizar, consolidar, preservar ou não criar;
- propósito;
- público;
- evidência ou lacuna que justifica a ação;
- conteúdo esperado;
- fonte de verdade;
- prioridade;
- risco;
- dependências;
- gatilho de atualização;
- validação necessária.

Qualquer remoção ou substituição deve aparecer apenas como proposta explícita e exigir aprovação específica.

## 5. Conteúdo a consolidar

Mostre duplicações que devem ser resolvidas e qual será a fonte canônica.

## 6. Estado atual versus propostas

Explique onde cada tipo será registrado.

## 7. Diagramas propostos

Liste somente os justificados.

## 8. Itens que não serão criados

Liste documentos considerados e descartados do plano, com motivo.

## 9. Validação humana

Perguntas que alterariam materialmente o plano.

## 10. Ordem de implementação

Agrupe em P0, P1, P2 e P3.

## Encerramento obrigatório

Finalize informando:

"Plano documental concluído. Nenhum arquivo foi alterado. A criação ou atualização de documentos depende de aprovação explícita e da consolidação com o plano de governança agêntica."

Pare e aguarde.
