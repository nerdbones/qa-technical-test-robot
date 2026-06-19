# QA Technical Test Robot

Projeto demonstrativo de **qualidade de software e automação de testes** construído com **Robot Framework**, **Browser Library/Playwright** e **Appium**.

A proposta do repositório é apresentar uma solução completa e reutilizável para validação de um fluxo de cadastro/listagem de equipamentos, cobrindo documentação de testes manuais, automação web, automação mobile, massa dinâmica, execução multiambiente, evidências e pipeline CI/CD.

O projeto foi estruturado de forma genérica para poder ser reutilizado como referência em cenários semelhantes de QA, sem dependência de documentos externos ao repositório.

## Objetivo

Demonstrar uma estratégia de QA para um fluxo funcional de equipamentos, contemplando:

- testes manuais documentados;
- automação web com Robot Framework + Browser Library;
- automação mobile com Robot Framework + Appium;
- estrutura multiambiente;
- massa dinâmica;
- separação entre pages, keywords, dados e testes;
- evidências de execução;
- pipeline CI/CD com GitHub Actions.

## Sistema sob teste

O projeto utiliza o site público de prática de automação **ExpandTesting Notes App** como sistema sob avaliação:

```text
https://practice.expandtesting.com/notes/app
```

Como o Notes App trabalha com notas, o domínio funcional foi adaptado da seguinte forma: cada nota representa um equipamento cadastrado.

| Conceito funcional | Representação no projeto |
|---|---|
| Equipamento | Nota no ExpandTesting Notes App |
| Nome do equipamento | Título da nota |
| Detalhes editáveis | Descrição da nota |
| Buscar equipamento | Consultar/validar nota pelo título |
| Editar equipamento | Atualizar descrição da nota |
| Validar status | Validar nota pendente/concluída |
| QA1 | Caminhão_01 |
| QA2 | Caminhão_02 |
| QA3 | Caminhão_03 |

## Tecnologias utilizadas

- Python
- Robot Framework
- Browser Library / Playwright
- AppiumLibrary
- Appium
- PyYAML
- Requests
- GitHub Actions

## Estrutura do projeto

```text
qa-technical-test-robot/
├── config/
│   └── environments.yaml
├── data/
│   └── equipment_data.yaml
├── docs/
│   ├── evidence/
│   ├── manual-tests/
│   └── technical-decisions.md
├── libraries/
│   ├── environment_loader.py
│   └── notes_api.py
├── resources/
│   ├── keywords/
│   ├── pages/
│   └── variables/
├── tests/
│   ├── mobile/
│   └── web/
├── scripts/
├── .github/workflows/
├── results/
├── Makefile
├── requirements.txt
└── README.md
```

## Documentação complementar

A documentação de apoio fica no diretório `docs/`:

| Documento | Finalidade |
|---|---|
| `docs/manual-tests/test-cases.md` | Cenários de testes manuais positivos e negativos |
| `docs/manual-tests/bug-report.md` | Exemplo de reporte de bug estruturado |
| `docs/evidence/README.md` | Explicação sobre geração e organização de evidências |
| `docs/evidence/execution-summary.md` | Resumo de execução e evidências esperadas |
| `docs/technical-decisions.md` | Decisões técnicas, limitações e melhorias futuras |

## Estratégia multiambiente

Os ambientes são definidos em `config/environments.yaml`.

| Ambiente | Equipamento válido | Categoria |
|---|---|---|
| QA1 | Caminhão_01 | Home |
| QA2 | Caminhão_02 | Work |
| QA3 | Caminhão_03 | Personal |

A troca de ambiente é feita por variável de execução, sem alteração do código principal dos testes:

```bash
robot -d results/web/QA1 -v ENV:QA1 tests/web
robot -d results/web/QA2 -v ENV:QA2 tests/web
robot -d results/web/QA3 -v ENV:QA3 tests/web
```

## Estratégia de massa dinâmica

A cada execução, o projeto cria automaticamente:

- usuário dinâmico;
- equipamento/nota dinâmico;
- descrição dinâmica;
- massa isolada por ambiente.

Exemplo de nome gerado:

```text
Caminhão_01 - 20260618183000-abcde
```

Isso evita dependência de massa fixa e reduz risco de conflito entre execuções.

## Testes automatizados

A suíte automatizada possui 4 testes Robot:

| Arquivo | Tipo | Objetivo |
|---|---|---|
| `tests/web/search_equipment.robot` | Web/API | Consulta do equipamento configurado e validação do dado retornado |
| `tests/web/edit_equipment.robot` | Web/API | Edição da descrição do equipamento e validação na interface |
| `tests/web/validate_equipment_status.robot` | Web/API | Alteração de status para concluído e validação visual |
| `tests/mobile/mobile_equipment_flow.robot` | Mobile/Appium | Smoke test mobile abrindo o ambiente configurado no Chrome Android |

Os testes web usam a API pública do Notes App para preparar a massa de forma estável e a interface web para validar exibição, edição refletida e status.

## Pré-requisitos

Instale os pacotes básicos no Ubuntu:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl unzip zip build-essential python3 python3-pip python3-venv nodejs npm openjdk-17-jdk
```

Para execução mobile, além do ADB, o Appium precisa encontrar o Android SDK. O caminho mais comum no Ubuntu após instalação do Android Studio é `$HOME/Android/Sdk`.

```bash
sudo apt install -y android-tools-adb

export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin
```

Para persistir a configuração, adicione os três `export` acima no final do arquivo `~/.bashrc` e execute `source ~/.bashrc`.

## Instalação

Clone o projeto e acesse a pasta:

```bash
git clone <repository-url>
cd qa-technical-test-robot
```

Crie e ative o ambiente virtual:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Instale as dependências:

```bash
pip install -r requirements.txt
rfbrowser init
```

Também é possível instalar usando o Makefile:

```bash
make install
```

## Execução web

### Executar QA1

```bash
robot -d results/web/QA1 -v ENV:QA1 tests/web
```

### Executar QA2

```bash
robot -d results/web/QA2 -v ENV:QA2 tests/web
```

### Executar QA3

```bash
robot -d results/web/QA3 -v ENV:QA3 tests/web
```

### Executar todos os ambientes web

```bash
bash scripts/run_web_all_envs.sh
```

Ou:

```bash
make test-all
```

## Execução headless

Por padrão, os testes web rodam em modo headless, ou seja, sem abrir a janela do navegador. Essa configuração fica em `resources/variables/default_variables.resource`:

```robot
${HEADLESS}               True
```

Para depurar visualmente, execute sobrescrevendo a variável:

```bash
robot -d results/web/QA1 -v ENV:QA1 -v HEADLESS:False tests/web
```

## Execução mobile com Appium

A suíte mobile exige um ambiente Android funcional. É necessário ter **um emulador Android iniciado** ou **um aparelho físico Android conectado via USB com depuração ativada**.

Instale o Appium globalmente:

```bash
sudo npm install -g appium
appium driver install uiautomator2
```

Antes de executar a suíte mobile, valide o Android SDK:

```bash
echo $ANDROID_HOME
echo $ANDROID_SDK_ROOT
adb version
```

Valide também se existe um device disponível:

```bash
adb devices
```

O resultado precisa exibir ao menos um device com status `device`, por exemplo:

```text
List of devices attached
emulator-5554    device
```

Se a lista aparecer vazia, o problema está no ambiente Android local, não na suíte Robot.

Inicie o Appium Server **depois** de configurar `ANDROID_HOME` e `ANDROID_SDK_ROOT`:

```bash
source ~/.bashrc
appium
```

Em outro terminal, execute:

```bash
source ~/.bashrc
source .venv/bin/activate
robot -d results/mobile/QA1 -v ENV:QA1 tests/mobile
```

Também é possível executar via script:

```bash
bash scripts/run_mobile_env.sh QA1
```

> Observação: a pipeline CI/CD executa apenas os testes web. A suíte mobile foi mantida para execução local, pois depende de Appium Server, Android SDK e device/emulador disponível.

## Evidências

O Robot Framework gera automaticamente:

- `log.html`
- `report.html`
- `output.xml`
- screenshots de evidência

Os resultados ficam em:

```text
results/web/QA1
results/web/QA2
results/web/QA3
results/mobile/QA1
```

Os arquivos gerados em `results/` não são versionados. Em CI, os relatórios web são publicados como artefatos do GitHub Actions.

## Testes manuais

Os cenários manuais estão documentados em:

```text
docs/manual-tests/test-cases.md
docs/manual-tests/bug-report.md
```

O material contempla:

- 6 cenários positivos;
- 4 cenários negativos;
- 1 reporte de bug;
- regras de negócio assumidas;
- mapeamento entre o domínio funcional de equipamentos e o ExpandTesting Notes App.

## Pipeline CI/CD

O projeto possui pipeline em GitHub Actions:

```text
.github/workflows/robot-web-tests.yml
```

A pipeline executa os testes web em matriz para:

- QA1;
- QA2;
- QA3.

Os relatórios são publicados como artefatos da execução. Essa é a principal evidência automatizada da execução web em CI.

## Comandos úteis

```bash
make install
make test-qa1
make test-qa2
make test-qa3
make test-all
make mobile-qa1
```

## Decisões técnicas

As decisões de arquitetura, limitações e melhorias futuras estão descritas em:

```text
docs/technical-decisions.md
```

## Observação sobre dry-run

O comando `robot --dryrun` valida se a suíte possui keywords e sintaxe corretas, mas não executa navegador, API, login ou Appium. Portanto, um dry-run aprovado não significa que o fluxo funcional executou com sucesso; ele apenas confirma que o projeto está estruturalmente consistente.

## Limitações conhecidas

- O ExpandTesting Notes App é uma aplicação pública, portanto depende de disponibilidade externa.
- Os ambientes QA1, QA2 e QA3 são representados por configuração e massa dinâmica, pois o site público não fornece ambientes reais separados.
- A suíte mobile exige Appium Server e um dispositivo/emulador Android configurado localmente.

## Melhorias futuras

- Expandir a suíte mobile para cobrir CRUD completo.
- Adicionar execução paralela com Pabot.
- Integrar relatório Allure.
- Adicionar validações de contrato para a API do Notes App.
