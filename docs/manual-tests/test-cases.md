# Cenários de Testes Manuais

## Contexto

Este documento descreve cenários manuais para um fluxo funcional de cadastro/listagem de equipamentos.

O projeto utiliza o **ExpandTesting Notes App** como sistema sob teste. Neste contexto, cada nota representa um equipamento cadastrado.

## Mapeamento funcional

| Conceito funcional | Implementação no projeto |
|---|---|
| Equipamento | Nota no ExpandTesting Notes App |
| Nome do equipamento | Título da nota |
| Detalhes editáveis | Descrição da nota |
| Buscar equipamento | Consultar/validar nota pelo título |
| Editar equipamento | Atualizar descrição/status da nota |
| Validar status | Validar nota pendente/concluída |
| QA1 | Caminhão_01 |
| QA2 | Caminhão_02 |
| QA3 | Caminhão_03 |

## Regras de negócio assumidas

1. Cada ambiente possui apenas um equipamento válido para a massa principal.
2. O equipamento deve possuir título/nome, descrição, categoria e status.
3. O nome do equipamento deve possuir entre 4 e 100 caracteres.
4. Equipamentos podem estar pendentes ou concluídos.
5. A consulta deve retornar o registro compatível com o equipamento esperado para o ambiente.
6. O sistema deve impedir criação/edição com campos obrigatórios vazios.

---

## Cenários positivos

### TC-001 - Buscar equipamento válido no ambiente QA1

**Pré-condição:** Usuário cadastrado e autenticado. Existe um registro para o equipamento `Caminhão_01` no ambiente QA1.

**Passos:**
1. Acessar o ExpandTesting Notes App configurado para QA1.
2. Realizar login com usuário válido.
3. Consultar o registro referente a `Caminhão_01`.
4. Observar a listagem retornada.

**Resultado esperado:** O sistema deve exibir o registro correspondente ao equipamento `Caminhão_01`, sem retornar equipamentos de outros ambientes.

---

### TC-002 - Buscar equipamento válido no ambiente QA2

**Pré-condição:** Usuário cadastrado e autenticado. Existe um registro para o equipamento `Caminhão_02` no ambiente QA2.

**Passos:**
1. Acessar o ExpandTesting Notes App configurado para QA2.
2. Realizar login com usuário válido.
3. Consultar o registro referente a `Caminhão_02`.
4. Observar a listagem retornada.

**Resultado esperado:** O sistema deve exibir o registro correspondente ao equipamento `Caminhão_02`, usando a massa configurada para QA2.

---

### TC-003 - Buscar equipamento válido no ambiente QA3

**Pré-condição:** Usuário cadastrado e autenticado. Existe um registro para o equipamento `Caminhão_03` no ambiente QA3.

**Passos:**
1. Acessar o ExpandTesting Notes App configurado para QA3.
2. Realizar login com usuário válido.
3. Consultar o registro referente a `Caminhão_03`.
4. Observar a listagem retornada.

**Resultado esperado:** O sistema deve exibir o registro correspondente ao equipamento `Caminhão_03`, usando a massa configurada para QA3.

---

### TC-004 - Editar descrição de equipamento válido

**Pré-condição:** Usuário cadastrado e autenticado. Existe um equipamento válido cadastrado para o ambiente selecionado.

**Passos:**
1. Acessar a listagem de equipamentos.
2. Localizar o equipamento válido do ambiente.
3. Alterar a descrição do equipamento.
4. Salvar a alteração.
5. Reabrir ou recarregar a listagem.

**Resultado esperado:** A descrição atualizada deve ser exibida corretamente após o salvamento, mantendo o mesmo equipamento e categoria configurados para o ambiente.

---

### TC-005 - Validar status inicial do equipamento

**Pré-condição:** Usuário cadastrado e autenticado. Existe um equipamento criado com status inicial pendente.

**Passos:**
1. Acessar a listagem de equipamentos.
2. Localizar o equipamento válido do ambiente.
3. Verificar o status exibido.

**Resultado esperado:** O equipamento deve ser exibido com status inicial `Pending`/pendente.

---

### TC-006 - Alterar status do equipamento para concluído

**Pré-condição:** Usuário cadastrado e autenticado. Existe um equipamento válido com status pendente.

**Passos:**
1. Acessar a listagem de equipamentos.
2. Localizar o equipamento válido do ambiente.
3. Alterar o status para concluído.
4. Recarregar ou consultar novamente o registro.

**Resultado esperado:** O equipamento deve ser exibido com status `Completed`/concluído.

---

## Cenários negativos

### TC-007 - Buscar equipamento inexistente

**Pré-condição:** Usuário cadastrado e autenticado. Não existe equipamento com o nome `Equipamento_Inexistente`.

**Passos:**
1. Acessar a listagem de equipamentos.
2. Consultar `Equipamento_Inexistente`.
3. Observar a listagem retornada.

**Resultado esperado:** O sistema deve informar que nenhum registro foi encontrado ou exibir a listagem vazia, sem retornar equipamentos incorretos.

---

### TC-008 - Criar equipamento sem título

**Pré-condição:** Usuário cadastrado e autenticado.

**Passos:**
1. Acessar a opção de criação de equipamento.
2. Deixar o campo título/nome vazio.
3. Preencher descrição e categoria.
4. Tentar salvar o registro.

**Resultado esperado:** O sistema deve impedir o salvamento e exibir mensagem de validação indicando que campos obrigatórios não podem ficar vazios.

---

### TC-009 - Criar equipamento com título menor que o mínimo permitido

**Pré-condição:** Usuário cadastrado e autenticado.

**Passos:**
1. Acessar a opção de criação de equipamento.
2. Informar título com menos de 4 caracteres, por exemplo `ABC`.
3. Preencher descrição e categoria válidas.
4. Tentar salvar o registro.

**Resultado esperado:** O sistema deve impedir o salvamento e informar que o título deve possuir entre 4 e 100 caracteres.

---

### TC-010 - Acessar listagem sem autenticação

**Pré-condição:** Usuário não autenticado ou sessão expirada.

**Passos:**
1. Acessar diretamente a URL da listagem de equipamentos/notas.
2. Observar o comportamento do sistema.

**Resultado esperado:** O sistema deve bloquear o acesso à listagem protegida e direcionar o usuário para login ou exibir mensagem de autenticação obrigatória.
