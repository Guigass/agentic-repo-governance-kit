# Parte 4 — Implementação Aprovada, Validação e Relatório

Você é responsável por implementar somente o plano de documentação e governança agêntica explicitamente aprovado pelo usuário.

Esta etapa não autoriza alteração funcional da aplicação.

## Gate de autorização

Antes de editar qualquer arquivo:

1. Localize a aprovação explícita do usuário.
2. Extraia dela o conjunto exato de arquivos e ações autorizados.
3. Compare a aprovação com os planos das Partes 2 e 3.
4. Identifique itens rejeitados, adiados ou condicionais.
5. Se a aprovação não for clara, não implemente. Apresente a divergência e peça decisão.

Um plano apresentado pelo agente não é aprovação.

## Task Preflight de implementação

Apresente um bloco curto:

# Task Preflight de Implementação

## Aprovação localizada

Cite resumidamente o que foi aprovado.

## Allowlist de arquivos

Liste arquivos que podem ser criados, atualizados, unificados, refatorados ou removidos, com a ação exata por caminho.

## Itens fora do escopo

Liste arquivos, áreas e tipos de alteração proibidos.

## Estado do working tree

Registre mudanças preexistentes e possíveis sobreposições.

## Riscos

Informe riscos e itens que ainda exigem cuidado.

## Validações previstas

Liste verificações proporcionais à mudança.

Não edite se houver sobreposição insegura com mudanças preexistentes que não possam ser preservadas.

## Regras de implementação

- Altere somente arquivos autorizados.
- Não modifique código-fonte funcional.
- Não altere dependências, banco, CI/CD, deploy ou infraestrutura para acomodar a documentação.
- Não remova arquivos sem aprovação específica do caminho e da ação.
- Preserve informações válidas existentes.
- Prefira mudanças incrementais a reescritas totais.
- Não apague contexto histórico útil.
- Não transforme inferência em fato durante a redação.
- Não copie a mesma fonte de conhecimento para docs, rules, skills e agents.
- Use links ou referências para a fonte canônica.
- Não registre secrets, tokens, valores de `.env`, endpoints privados sensíveis ou dados pessoais.
- Não execute comandos com efeitos externos.
- Não faça commit, stage, push, PR, release ou publicação sem pedido explícito adicional.

Estas regras são uma aplicação do princípio canônico em `00-COMO-USAR.md` (ver Princípios preservados): nenhuma diretiva deste kit autoriza mutação em produção, bancos de dados, deploy ou estado externo; exige autorização humana separada.

## 1. Revalidar antes de escrever

Faça uma verificação direcionada das evidências utilizadas pelo arquivo que será alterado:

- confirme que caminhos e símbolos continuam existindo;
- confirme que o working tree não mudou materialmente desde o diagnóstico;
- confirme que a documentação canônica escolhida continua adequada;
- confirme a sintaxe atual de rules, skills e agents para cada ambiente-alvo aprovado antes de criá-los;
- registre qualquer deriva que invalide o plano. No modo `REAUDITORIA`, registre também a deriva entre auditorias — o delta entre o estado atual do código e a documentação ou governança existente produzida pela auditoria anterior.

Se a deriva alterar materialmente o plano, pare e solicite nova aprovação.

## 2. Implementar a arquitetura documental

Ao criar ou atualizar documentos:

- escreva para o público definido no plano;
- preserve navegação e fontes canônicas;
- cite caminhos reais;
- marque fatos, inferências e dúvidas quando a distinção for relevante;
- separe estado atual de propostas;
- indique comandos não verificados;
- use diagramas somente quando aprovados e sustentados por evidência;
- inclua metadados somente quando tiverem função de manutenção;
- evite documentos vazios ou preenchidos com "não identificado" sem utilidade operacional.

## 3. Implementar Rules

Para cada rule aprovada:

- use o diretório, extensão e frontmatter suportados por cada ambiente-alvo aprovado;
- coloque instruções portáteis em `AGENTS.md` quando essa for a camada aprovada;
- crie adaptadores específicos de ambiente apenas para conteúdo não portável e referencie a fonte canônica;
- configure ativação e escopo de forma explícita;
- mantenha o conteúdo curto e acionável;
- referencie documentação canônica;
- evite always-on quando um escopo específico for suficiente;
- confirme que não conflita com rules existentes;
- não inclua permissões ou ações não autorizadas.

## 4. Implementar Skills

Para cada skill aprovada:

- prefira o formato aberto Agent Skills sob `.agents/skills/<skill-name>/SKILL.md` quando aprovado e suportado;
- use um caminho de skill específico de ambiente somente quando aprovado e necessário; não duplique a mesma skill em múltiplas raízes;
- use a estrutura e o frontmatter suportados pelo ambiente-alvo;
- deixe a descrição específica para seleção correta;
- defina entradas, passos, limites, saída e validação;
- diferencie inspeção, recomendação e execução;
- inclua gates humanos para ações sensíveis;
- use scripts ou assets apenas se aprovados e necessários;
- configure invocação automática ou manual conforme o plano e o suporte atual.

Uma skill nunca deve ampliar a autorização recebida na tarefa que a invoca.

## 5. Implementar Agents e Router

Para cada agent aprovado:

- mapeie a missão aprovada para o formato de subagent ou custom agent de cada ambiente aprovado;
- use o formato e o frontmatter suportados por esse ambiente;
- defina missão limitada;
- conceda ferramentas e permissões mínimas;
- use modo somente leitura por padrão para análise e revisão, quando suportado;
- explicite o que pode e o que não pode alterar;
- indique fontes canônicas e skills relacionadas;
- defina condições de parada e revisão humana;
- evite sobreposição não explicada.

Crie ou atualize o router somente se aprovado. Confirme que todos os agents e skills referenciados realmente existem no plano implementado.

## 6. Validar a implementação

Execute verificações somente locais, seguras e proporcionais.

### Integridade documental

- caminhos citados existem ou estão explicitamente marcados como externos ou planejados;
- links relativos resolvem;
- índice alcança os documentos principais;
- não há duas fontes canônicas conflitantes;
- títulos e navegação são consistentes;
- estado atual e propostas estão separados;
- comandos estão comprovados ou marcados como não verificados;
- incertezas permanecem visíveis.

### Governança agêntica

- nomes de arquivos e diretórios são reconhecidos por cada ambiente-alvo aprovado;
- frontmatter é válido para cada ambiente que recebe um adaptador;
- conteúdo portável não está duplicado em arquivos específicos de ambiente;
- rules possuem ativação e escopo coerentes;
- skills têm gatilhos claros e procedimentos completos;
- agents têm responsabilidade e limites claros;
- router não referencia artefatos inexistentes;
- não existe duplicação relevante entre docs, rules, skills e agents;
- unificações e remoções aprovadas não deixaram duplicata material residual;
- artefatos automáticos não adicionam contexto excessivo sem justificativa.

### Segurança

- nenhum secret, token, senha ou valor real de ambiente foi introduzido;
- nenhum dado pessoal ou sensível, incluindo PII, foi reproduzido;
- nenhum comando destrutivo foi documentado sem contexto, alerta e gate humano;
- nenhuma instrução concede autonomia sobre produção ou sistemas externos;
- nenhuma mudança funcional entrou no diff;
- caminhos de autenticação, autorização, pagamento e produção não foram enfraquecidos ou contornados pela documentação ou governança escrita;
- exposição de dados sensíveis em logs, documentação gerada ou relatórios foi verificada e sinalizada.

### Working tree e diff

- revise `git status`, quando houver Git;
- revise o diff dos arquivos alterados;
- use `git diff --check` ou equivalente seguro;
- distinga mudanças desta tarefa de mudanças preexistentes;
- não reverta, formate ou inclua arquivos alheios.

Não marque validação como concluída se ela não foi executada. Explique limitações.

## 7. Revisão de commit, sem criar commit

Se houver Git, prepare apenas uma recomendação:

- arquivos pertencentes à mudança;
- separação sugerida em um ou mais commits;
- mensagem de commit alinhada ao padrão observado;
- validações executadas;
- riscos e pendências.

Use Conventional Commits apenas se o projeto não possuir outro padrão e se isso fizer sentido.

Não faça stage ou commit sem autorização explícita.

## Formato do relatório final

# Relatório Final

## 1. Resultado

Resumo do que foi implementado e benefício esperado.

## 2. Escopo aprovado

O que foi autorizado e eventuais restrições.

## 3. Arquivos criados

Caminho e finalidade.

## 4. Arquivos atualizados, unificados ou refatorados

Caminho, ação e resumo da mudança.

## 5. Arquivos removidos

Caminho e motivo de cada remoção aprovada. Se não houver, declare nenhum.

## 6. Arquivos preservados

Liste apenas os relevantes para decisões do plano, não todos os arquivos inspecionados.

## 7. Arquitetura documental resultante

Explique navegação, fontes canônicas e separação entre estado atual e propostas.

## 8. Rules, Skills e Agents resultantes

Liste somente os implementados e seus gatilhos.

## 9. Itens aprovados não implementados

Explique bloqueios, deriva ou limitações.

## 10. Itens não criados

Registre as exclusões relevantes que evitaram duplicação ou burocracia.

## 11. Validações executadas

Comandos e resultados resumidos.

## 12. Limitações e validação humana

O que permanece incerto ou depende de contexto externo.

## 13. Manutenção

Eventos que devem provocar atualização de cada área documental ou agêntica.

## 14. Recomendação de commit

Arquivos, separação, mensagem sugerida e indicação se está pronto para revisão humana.

## 15. Confirmação de segurança

Declare explicitamente:

- se houve alteração funcional;
- se houve acesso externo;
- se houve remoção;
- se houve stage ou commit;
- se foram encontrados possíveis secrets;
- se alterações preexistentes foram preservadas.

## Critério de conclusão

A tarefa só está concluída quando:

- todos os arquivos implementados pertencem ao escopo aprovado;
- documentação reflete evidências atuais;
- rules, skills e agents têm utilidade e escopo claros;
- a limpeza aprovada não deixou duplicação material residual;
- navegação e referências foram verificadas;
- riscos e limitações estão explícitos;
- o diff foi revisado;
- nenhuma alteração funcional ou externa não autorizada foi realizada.
