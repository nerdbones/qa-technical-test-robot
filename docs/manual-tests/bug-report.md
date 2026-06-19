# Relatório de Bug

## BUG-001 - Sistema permite tentativa de criação de equipamento sem título

**Severidade:** Média

**Ambiente:** QA1

**Tipo:** Validação de campo obrigatório

**Pré-condição:** Usuário cadastrado e autenticado no ExpandTesting Notes App.

## Passos para reprodução

1. Acessar o sistema no ambiente QA1.
2. Realizar login com usuário válido.
3. Acionar a criação de novo registro/equipamento.
4. Deixar o campo de título vazio.
5. Preencher descrição e categoria com valores válidos.
6. Acionar o botão de salvar.

## Resultado esperado

O sistema deve bloquear o salvamento e exibir uma mensagem clara informando que o título/nome do equipamento é obrigatório.

## Resultado obtido

Durante a análise do fluxo, foi identificada a necessidade de validação obrigatória para o campo título. A API do Notes App possui regra de proteção para campos obrigatórios e retorna mensagem de validação quando título, descrição ou categoria são enviados vazios. O comportamento deve ser validado também pela interface para garantir consistência entre frontend e backend.

## Evidências

- Evidência esperada em execução manual: screenshot da tela de criação com mensagem de campo obrigatório.
- Evidência esperada em execução automatizada/API: retorno HTTP 400 com mensagem de validação.
- Diretório sugerido para evidências locais: `results/`.
- Evidências em CI: artefatos publicados pelo GitHub Actions.

## Impacto

Registros sem título prejudicam busca, rastreabilidade, manutenção da listagem e identificação correta do equipamento válido por ambiente.

## Recomendação

Adicionar ou reforçar validação client-side para impedir envio do formulário quando o título estiver vazio, mantendo a mesma regra esperada no backend.
