# Resumo de Execução

Este documento resume como as evidências de execução são geradas e onde devem ser consultadas.

## Execução web

A suíte web foi projetada para ser executada nos três ambientes configurados:

```bash
robot -d results/web/QA1 -v ENV:QA1 tests/web
robot -d results/web/QA2 -v ENV:QA2 tests/web
robot -d results/web/QA3 -v ENV:QA3 tests/web
```

A mesma execução pode ser iniciada com:

```bash
bash scripts/run_web_all_envs.sh
```

Para cada execução, o Robot Framework gera:

- `log.html`;
- `report.html`;
- `output.xml`;
- capturas de tela de validação.

## Evidências em CI

O workflow do GitHub Actions executa a suíte web em matriz para QA1, QA2 e QA3. Ao final da execução, os relatórios do Robot Framework são publicados como artefatos do workflow.

Essa estratégia evita versionar relatórios temporários no repositório e mantém as evidências associadas à execução real da pipeline.

## Execução mobile

A suíte mobile está disponível em:

```text
tests/mobile/mobile_equipment_flow.robot
```

Ela requer infraestrutura Android local:

- Appium Server;
- Android SDK;
- `ANDROID_HOME` ou `ANDROID_SDK_ROOT`;
- emulador Android ou dispositivo Android físico;
- Chrome instalado no dispositivo Android.

Se o comando `adb devices` não exibir um dispositivo conectado com status `device`, a suíte mobile não poderá ser executada localmente.
