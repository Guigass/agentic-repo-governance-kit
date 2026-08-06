# Evoluindo e Mantendo o Kit

Este guia direciona um fluxo de somente-leitura-até-aprovação para revisar todo o kit e produzir uma nova versão melhorada. Execute-o quando algo no ecossistema mudar o suficiente para justificar um novo release: uma nova geração de modelos de IA, novas capacidades de agentes/IDEs, novos padrões portáteis, novas diretivas recorrentes, ou necessidades de manutenção acumuladas.

O kit é o alvo aqui. O mesmo modelo de segurança em estágios que o kit aplica a outros repositórios se aplica a si mesmo: diagnosticar antes de planejar, planejar antes de alterar, e alterar somente após aprovação humana explícita.

## Objetivo

Produzir uma próxima versão do kit que seja mais precisa, mais segura e mais proporcional que a atual, sem quebrar o modelo de segurança em estágios nem transformar artefatos opcionais em exigências universais.

## Quando executar

Acione este fluxo quando um ou mais dos itens abaixo forem verdadeiros:

- Uma nova geração de modelos de IA muda como agentes leem, amostram ou seguem prompts.
- Novas capacidades de agentes/IDEs aparecem (novos formatos de Cursor Rules/Skills/Agents, novos mecanismos de subagentes, novas opções de escopo ou somente-leitura).
- Um novo padrão portátil surge ou muda (por exemplo, suporte a `AGENTS.md` entre Claude Code, Codex, Copilot).
- Uma nova diretiva recorrente é necessária (segurança, testes, privacidade, custo-efetividade, ou outra preocupação comprovada pelo uso real).
- Feedback de execuções reais mostra um modo de falha, ambiguidade ou excesso de burocracia.
- A própria paridade, os links ou os exemplos do kit divergem do estado atual do repositório.

Não execute este fluxo para edições cosméticas; use uma alteração normal.

## Princípios preservados (não negociáveis ao evoluir)

- Evidência antes de conclusões; diagnóstico antes de planejamento; aprovação explícita antes de implementação.
- Estado atual separado de propostas.
- Proporcionalidade não é permissão para omissão; um artefato opcional não é uma exigência universal.
- Não invente capacidades, formatos ou campos que o ambiente não suporta; valide contra a documentação oficial atual.
- Preserve o que funciona; evite duplicação; documentação como sistema de navegação.
- Rules, skills e agentes a partir de necessidades observadas.
- Nenhuma mutação em produção, bancos de dados, deploy ou estado externo.
- Paridade bilíngue: toda mudança em `en/` é refletida em `pt-BR/`, e vice-versa.

## Processo

Execute os estágios em ordem. Cada estágio é somente leitura até o gate humano.

### Estágio 1 — Autodiagnóstico do kit (somente leitura)

Audite o kit atual como alvo:

- Mapeie cada arquivo e seu propósito (00–04, READMEs, CHANGELOG, scripts).
- Registre a tag de versão atual e o estado das URLs pinadas.
- Identifique o que mudou no ecossistema desde o último release: novos modelos, novas capacidades de agentes/IDEs, novos padrões portáteis, novos riscos recorrentes.
- Identifique lacunas no nível do kit: ambiguidades, duplicações, excesso de burocracia, links quebrados, divergência de paridade, exemplos que não correspondem mais ao repositório.
- Classifique cada achado com o modelo de evidência: fato observado, inferência baseada em evidência, não identificado no escopo buscado, exige validação humana.
- Priorize os achados P0–P3.
- Produza um artefato chamado KIT_DIAGNOSIS.
- Não edite nenhum arquivo.

### Estágio 2 — Plano de evolução (somente leitura)

Desenhe a próxima versão:

- Para cada achado material, proponha uma mudança concreta: expandir uma seção existente, adicionar uma nova seção, adicionar um novo modo, adicionar um novo arquivo, ou remover burocracia.
- Prefira aprofundar seções existentes em vez de criar paralelas.
- Condicionem cada nova diretiva ao contexto-alvo (opt-in, proporcional a ENXUTO/PADRÃO/PROFUNDO); nunca transforme um artefato opcional em exigência universal.
- Decida o bump de versão (ver Política de versionamento).
- Liste os arquivos e seções exatos afetados em `en/` e as contrapartes correspondentes em `pt-BR/`.
- Produza um artefato chamado EVOLUTION_PLAN.
- Não edite nenhum arquivo.

### Gate humano obrigatório

Apresente o KIT_DIAGNOSIS e o EVOLUTION_PLAN ao humano. Mostre a lista exata de arquivos e ações, o bump de versão e os pontos que ainda precisam de decisão. Pare. Não implemente até que o humano aprove explicitamente a lista ou um subconjunto explícito. A existência de um plano não é autorização.

### Estágio 3 — Implementação

Após aprovação explícita:

1. Implemente o escopo aprovado em `en/` e `README.md` primeiro (canônico).
2. Replique as mesmas mudanças em `pt-BR/` e `README.pt-BR.md`, mantendo paridade exata de conteúdo e estrutura. Traduza os nomes de modo de forma consistente com a convenção já existente em `pt-BR/`.
3. Não altere o comportamento funcional do kit além do escopo aprovado.
4. Não faça stage, commit, push ou acesse sistemas externos.

### Estágio 4 — Validação

Execute as verificações finais antes do release:

- Execute `scripts/check-parity.sh` (ou `scripts/check-parity.ps1` no Windows). Deve sair com código 0.
- Confirme que cada nova seção em `en/` tem contraparte em `pt-BR/` no mesmo ponto de inserção.
- Confirme que as URLs pinadas ainda resolvem para a tag pretendida (ou atualize-as como parte do release).
- Confirme que o estilo e o tom correspondem aos arquivos existentes.
- Confirme que não houve mudança fora do escopo aprovado.
- Produza QA_APROVADO ou CORRECOES_NECESSARIAS.

Se houver CORRECOES_NECESSARIAS dentro do escopo aprovado, corrija e revalide uma vez. Se a correção ampliar o escopo, pare e peça nova aprovação humana.

### Estágio 5 — Release

Após aprovação do QA:

1. Atualize o `CHANGELOG.md` sob `[Unreleased]` (ou uma nova seção de versão) com as mudanças, seguindo o Keep a Changelog.
2. Decida a nova tag de versão (ver Política de versionamento).
3. Mova as entradas de `[Unreleased]` para a nova seção de versão e abra um novo `[Unreleased]` vazio.
4. Se o release alterar prompts que os usuários copiam, atualize as URLs pinadas nos READMEs para a nova tag.
5. Recomende o commit e a tag ao humano; não os crie sem autorização separada.

## Política de versionamento

Este kit segue Versionamento Semântico:

- **Patch** (`v0.1.0` → `v0.1.1`): correções, esclarecimentos, correção de links, reparos de paridade. Sem novo comportamento para quem consome o kit.
- **Minor** (`v0.1.0` → `v0.2.0`): novas diretivas opcionais, novos modos, novas seções, suporte a novos padrões portáteis. Compatível com as URLs pinadas existentes.
- **Major** (`v0.1.0` → `v1.0.0`): mudanças que quebram execuções pinadas existentes (arquivos renomeados, seções renumeradas, estágios removidos, semântica de gate alterada). Exige migrar as URLs pinadas.

Em caso de dúvida, prefira minor em vez de major e patch em vez de minor. Uma nova geração de modelos de IA geralmente justifica minor; uma reestruturação do modelo de estágios justifica major.

## Checklist de release

- [ ] KIT_DIAGNOSIS produzido e validado.
- [ ] EVOLUTION_PLAN aprovado pelo humano; APPROVED_ALLOWLIST registrada.
- [ ] `en/` e `README.md` atualizados dentro da lista aprovada.
- [ ] `pt-BR/` e `README.pt-BR.md` atualizados em paridade.
- [ ] `scripts/check-parity.sh` e `.ps1` saem com código 0.
- [ ] URLs pinadas nos READMEs apontam para a tag pretendida.
- [ ] `CHANGELOG.md` atualizado; `[Unreleased]` rotacionado.
- [ ] Bump de versão decidido e consistente com a política.
- [ ] Nenhum commit, push, tag ou ação externa executada sem autorização separada.

## Encerramento obrigatório

Após o Estágio 5, pare. Apresente ao humano o resumo do release: bump de versão, trecho do CHANGELOG, arquivos alterados, confirmação de paridade e os comandos recomendados de commit e tag. Não os execute sem autorização separada.
