# Planejamento de Roadmap para uma Nova Feature ou Parte do Sistema

Este guia direciona um fluxo de somente-leitura-até-aprovação para construir um roadmap baseado em evidência para entregar uma nova feature ou uma nova parte do sistema. Ele analisa o projeto existente (padrões, arquitetura, runtime, deployment e documentação) e produz um roadmap por ondas em `docs/roadmap/<nome-do-plano>/`.

Este é um guia suplementar, não uma das Partes numeradas. Use as Partes 1–4 para auditar ou governar um repositório existente; use `EVOLUTION-AND-MAINTENANCE.md` para evoluir o próprio kit.

O kit é a fonte de instruções. O repositório-alvo é onde a feature vai existir. O mesmo modelo de segurança em estágios se aplica: analisar antes de planejar, planejar antes de escrever, e escrever somente após aprovação humana explícita. Este guia produz apenas o roadmap; ele não implementa a feature.

## Objetivo

Produzir um roadmap proporcional e baseado em evidência que divida uma nova feature ou parte do sistema em ondas incrementais, cada uma com escopo, dependências, critérios de aceite, footprint de runtime/deploy e riscos claros, registrados em arquivos em `docs/roadmap/<nome-do-plano>/`.

## Quando usar

Use este guia quando o usuário quiser planejar uma nova feature ou uma nova parte do sistema e precisar de um roadmap estruturado por ondas, fundamentado no projeto real.

Não use este guia para:
- auditar um repositório existente (use as Partes 1–4);
- evoluir o próprio kit (use `EVOLUTION-AND-MAINTENANCE.md`);
- implementar a feature (este guia para no roadmap).

## Pré-condições

Antes de iniciar, confirme que você tem, ou vai coletar:

- um `APPROVABLE_DIAGNOSIS` aprovado da Parte 1, quando já existir na conversa — reutilize-o como fonte primária de evidência e execute apenas uma inspeção complementar mínima em somente leitura, escopada à feature;
- quando não existir diagnóstico prévio, execute a análise de projeto do Estágio 2 do zero, escopada à feature e ao seu raio de impacto;
- correções ou esclarecimentos que o usuário já forneceu;
- restrições adicionais do usuário (prazo, stack, runtime, conformidade).

Não reinicie uma varredura completa do repositório quando já existir um diagnóstico utilizável. Cite o diagnóstico reutilizado onde fundamentar uma decisão do roadmap.

## Princípios preservados (não negociáveis)

- Evidência antes de conclusões: analise o projeto real; não invente padrões, arquitetura, runtime ou integrações.
- Diagnóstico antes de planejamento: entenda o estado atual antes de propor ondas.
- Aprovação explícita antes de escrever: os arquivos do roadmap são escritos somente após o humano aprovar o plano.
- Proporcionalidade não é permissão para omissão: cada onda deve ter escopo e critérios de aceite concretos; um artefato opcional não é uma exigência universal.
- Estado atual separado das ondas propostas.
- Siga as convenções existentes do projeto; não introduza novos padrões sem justificativa.
- Preserve o que funciona; evite duplicação; referencie a documentação canônica em vez de copiá-la.
- Nenhuma mutação em produção, bancos de dados, deploy ou estado externo.
- Paridade bilíngue deste guia: toda mudança em `en/ROADMAP-PLANNING.md` é refletida em `pt-BR/PLANEJAMENTO-DE-ROADMAP.md`, e vice-versa. Os arquivos de roadmap produzidos no repositório-alvo são escritos no idioma de entrega escolhido pelo usuário; não precisam ser bilíngues.

## Modos de profundidade

O usuário pode declarar um modo no início. O modo governa a profundidade da análise, o número de ondas e a estrutura de arquivos; não reduz regras de segurança nem autoriza inferências sem evidência.

- `ENXUTO`: feature pequena ou exploração inicial. Tipicamente 1–2 ondas; estrutura mínima de arquivos.
- `PADRÃO`: profundidade proporcional, recomendado por padrão. Tipicamente 2–4 ondas; estrutura completa de arquivos.
- `PROFUNDO`: feature grande, parte do sistema transversal, ou com decisões arquiteturais materiais. 4+ ondas quando justificadas por risco distinto ou limites de equipe; estrutura completa mais artefatos opcionais quando justificados.

Se não especificado, adote `PADRÃO`.

## Restrições obrigatórias

- Não edite, crie, mova, renomeie ou exclua arquivos até que o gate humano seja ultrapassado.
- Não altere código funcional da aplicação, configuração, bancos de dados, infraestrutura ou estado externo.
- Não instale dependências, execute migrations, seeds, deploys ou comandos destrutivos.
- Não acesse bancos de dados, APIs privadas, cloud, produção ou serviços externos.
- Não leia arquivos `.env` reais, private keys, certificados, credenciais ou tokens; em exemplos de ambiente, registre apenas nomes de variáveis.
- Não faça stage, commit, push, crie PRs ou acesse sistemas externos.
- Preserve mudanças pré-existentes e não relacionadas na working tree; não as atribua a esta tarefa.
- Não trate a ausência de resultados em uma busca limitada como prova absoluta de não existência.

Estas restrições são uma aplicação do princípio canônico em `00-COMO-USAR.md` (ver Princípios preservados): nenhuma diretiva deste kit autoriza mutação em produção, bancos de dados, deploy ou estado externo; exige autorização humana separada.

## Task Preflight

Antes da análise profunda, apresente um bloco curto:

```text
# Task Preflight

## Objetivo entendido
Uma frase descrevendo a feature a ser planejada no roadmap.

## Escopo inicial
Raiz, projetos ou áreas incluídos e o modo de profundidade adotado.

## Evidência reutilizada
Se um APPROVABLE_DIAGNOSIS prévio está sendo reutilizado, ou a análise rodará do zero.

## Restrições
Confirme que o estágio é somente leitura e cite restrições adicionais do usuário.

## Riscos iniciais
Riscos já visíveis ou "nenhum risco crítico identificado até aqui".

## Próxima ação segura
Explique a primeira inspeção em somente leitura.
```

O preflight pode usar inspeção mínima para localizar a raiz, as instruções e o estado do repositório. Não deve fingir conhecer a arquitetura antes da descoberta.

## Processo

Execute os estágios em ordem. Cada estágio é somente leitura até o gate humano.

### Estágio 1 — Entrevista de contexto (somente leitura)

Faça ao usuário as perguntas mínimas para definir a feature. Proporcionalidade: em `ENXUTO`, uma única rodada curta; em `PROFUNDO`, múltiplas rodadas por área quando restarem lacunas materiais.

- Qual é a feature ou parte do sistema a ser construída?
- Qual é o objetivo e o usuário pretendido?
- O que está no escopo e explicitamente fora do escopo?
- Quais são as restrições (prazo, stack, runtime, conformidade)?
- O que significa "pronto" (critérios de aceite)?

Registre as respostas como `FEATURE_BRIEF`. Se o usuário ainda não puder responder, proponha um rascunho mínimo e peça confirmação. Não edite nenhum arquivo.

### Estágio 2 — Análise do projeto (somente leitura)

Analise o projeto existente para fundamentar o roadmap na realidade. Reutilize o `APPROVABLE_DIAGNOSIS` da Parte 1 quando existir; caso contrário, execute esta análise escopada à feature e ao seu raio de impacto.

- Arquitetura e camadas: como o código está organizado, onde a nova feature se encaixa.
- Padrões e convenções: nomenclatura, estrutura, tratamento de erros, gestão de estado e padrões de teste já em uso.
- Runtime e deployment: onde o projeto roda — plataforma, runtime, serviços, ambientes, CI/CD, IaC, manifests e os runbooks/ADRs que o documentam. Extraia padrões e docs de onde o projeto realmente roda; não invente runtime.
- Documentação existente: docs de arquitetura, ADRs, runbooks e qualquer roadmap prévio que informe o plano.
- Dependências e integrações: bibliotecas, serviços e APIs que a feature vai tocar.
- Testes e validação: o framework de testes presente e a baseline de cobertura.
- Riscos e restrições: limites de segurança, dados, produção e conformidade.

Classifique cada achado com o modelo de evidência:
- **Fato observado** — encontrado diretamente no repositório; cite o caminho e, quando útil, linha ou símbolo.
- **Inferência baseada em evidência** — sustentada por sinais concretos mas não explícitos; cite evidência e confiança.
- **Não identificado no escopo buscado** — descreva onde e como buscou; evite a afirmação absoluta "não existe".
- **Exige validação humana** — uma pergunta, ambiguidade ou informação externa que não pode ser provada a partir do repositório.

Priorize os achados `P0`–`P3`. Produza um artefato chamado `PROJECT_ANALYSIS`. Quando for derivado de um `APPROVABLE_DIAGNOSIS` existente, declare isso explicitamente e registre apenas o delta e a evidência específica da feature. Não edite nenhum arquivo.

### Estágio 3 — Plano do roadmap (somente leitura)

Desenhe o roadmap por ondas.

- Decida o nome do plano: um slug em kebab-case usado como nome da pasta sob `docs/roadmap/`. Mantenha-o estável; não renomeie após a criação sem aprovação.
- Divida a feature em ondas incrementais. Cada onda deve entregar valor utilizável e verificável de forma independente — não apenas setup — a menos que a feature seja documentação.
- A Onda 1 deve estabelecer o menor slice vertical utilizável ou a restrição fundacional (por exemplo, o esqueleto de runtime/deploy) que reduz o risco das ondas seguintes.
- Para cada onda: escopo, dependências de ondas anteriores, critérios de aceite, áreas afetadas, footprint de runtime/deploy (serviços, envs, infra, novos requisitos de runtime), riscos e validação.
- As dependências devem formar um grafo acíclico dirigido; sem dependências circulares; cada onda lista explicitamente as ondas anteriores das quais depende.
- Reutilize padrões existentes; sinalize onde um novo padrão é necessário e justifique.
- O número de ondas é proporcional ao tamanho e risco da feature, governado pelo modo de profundidade (ver Modos de profundidade).

Proponha a estrutura exata de arquivos sob `docs/roadmap/<nome-do-plano>/`, proporcional ao modo:

- `README.md`: visão geral, objetivo, escopo, tabela de status das ondas (planejada / em andamento / concluída / bloqueada), lista de ondas e pontos de entrada. Obrigatório em todo modo.
- `context.md`: resumo da análise do projeto, padrões, runtime, restrições. Incorporado ao `README.md` em `ENXUTO`.
- `wave-1.md`, `wave-2.md`, ...: um arquivo por onda com escopo, dependências, critérios de aceite, footprint de runtime/deploy, riscos, validação.
- Opcionais, apenas quando justificados (não crie arquivos vazios):
  - `decisions.md`: log leve de ADRs para decisões do roadmap (comprar vs construir, síncrono vs assíncrono etc.). Apenas em `PROFUNDO`, quando há escolhas arquiteturais materiais.
  - `risks.md`: quando a superfície de risco for grande o suficiente para um registro dedicado auxiliar a manutenção.
  - `glossary.md`: quando a feature introduz termos de domínio que reaparecem entre ondas.

Aplique o teste de admissão de artefato antes de adicionar qualquer arquivo opcional: declare a pergunta que ele responde, quem o usa, sua fonte da verdade e por que incorporá-lo ao `README.md` ou a um arquivo de onda não é suficiente. Se a resposta for fraca, não o crie.

Produza um artefato chamado `ROADMAP_PLAN` listando os arquivos exatos e um resumo de uma linha de cada, mais a divisão de ondas e os pontos que ainda precisam de decisão. Não edite nenhum arquivo.

### Gate humano obrigatório

Apresente o `FEATURE_BRIEF`, o `PROJECT_ANALYSIS` e o `ROADMAP_PLAN` ao humano. Mostre:
- a lista exata de arquivos sob `docs/roadmap/<nome-do-plano>/`;
- a divisão de ondas com dependências e critérios de aceite;
- o footprint de runtime/deploy por onda;
- riscos, itens descartados e os pontos que ainda precisam de decisão.

Pare. Não escreva nenhum arquivo até que o humano aprove explicitamente o plano ou um subconjunto explícito. A aprovação do usuário se torna o `APPROVED_ALLOWLIST`; itens não mencionados não são autorizados. A existência de um plano não é autorização.

### Estágio 4 — Geração do roadmap

Após aprovação explícita:

1. Crie os arquivos sob `docs/roadmap/<nome-do-plano>/` exatamente como aprovado, usando a estrutura aprovada.
2. Escreva cada arquivo seguindo o conteúdo aprovado; não adicione ondas, arquivos ou escopo além do `APPROVED_ALLOWLIST`.
3. Cite caminhos e evidências reais do `PROJECT_ANALYSIS`; marque inferências e comandos não verificados.
4. Mantenha o estado atual (em `context.md`) separado das ondas propostas.
5. Não altere código funcional da aplicação, configuração de produção ou estado externo.
6. Não faça stage, commit, push ou acesse sistemas externos.
7. Preserve mudanças pré-existentes e não relacionadas.

### Estágio 5 — Validação

Execute as verificações finais:

- Confirme que todos os arquivos aprovados existem sob `docs/roadmap/<nome-do-plano>/` com o conteúdo aprovado.
- Confirme que as ondas são incrementais, as dependências formam um grafo acíclico dirigido, e cada onda entrega valor utilizável.
- Confirme que cada onda registra seu footprint de runtime/deploy.
- Confirme que a estrutura de arquivos é proporcional ao modo (sem arquivos opcionais vazios, sem arquivos obrigatórios ausentes).
- Confirme que o plano reutiliza padrões existentes e sinaliza novos padrões com justificativa.
- Confirme que nenhum código funcional, estado de produção ou sistema externo foi alterado.
- Confirme que mudanças pré-existentes foram preservadas.
- Produza `QA_APROVADO` ou `CORRECOES_NECESSARIAS` com evidência.

Se houver `CORRECOES_NECESSARIAS` dentro do `APPROVED_ALLOWLIST`, corrija e revalide uma vez. Se a correção ampliar o escopo, pare e peça nova aprovação humana.

## Encerramento obrigatório

Após o Estágio 5, pare. Apresente ao humano o resumo do roadmap: nome do plano, árvore de arquivos sob `docs/roadmap/<nome-do-plano>/`, lista de ondas com status, e o próximo passo recomendado (por exemplo, iniciar a onda 1). Não comece a implementar a feature; este guia produz apenas o roadmap.

Finalize declarando:

"Planejamento de roadmap concluído em modo somente-leitura-até-aprovação. Apenas os arquivos aprovados sob `docs/roadmap/<nome-do-plano>/` foram criados. Nenhum código funcional ou estado externo foi alterado. A próxima etapa é a implementação da onda 1, sob autorização separada."

Pare e aguarde.
