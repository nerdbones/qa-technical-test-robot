# Decisões Técnicas

## Uso do ExpandTesting Notes App

Para manter o projeto executável e independente, foi escolhido o site público de prática de automação **ExpandTesting Notes App** como sistema sob avaliação.

No projeto, cada nota representa um equipamento. O título da nota representa o nome do equipamento, a descrição representa detalhes editáveis e o status `completed` representa o status operacional do registro.

Essa adaptação permite demonstrar arquitetura de automação, massa dinâmica, execução multiambiente e organização de testes sem depender de uma aplicação privada ou de dados externos ao repositório.

## Estratégia multiambiente

Os ambientes QA1, QA2 e QA3 são configurados externamente no arquivo `config/environments.yaml`. Ao trocar a variável `ENV`, a automação carrega automaticamente:

- URL correta;
- endpoint de API;
- equipamento válido;
- categoria;
- status esperado.

Exemplo:

```bash
robot -d results/web/QA1 -v ENV:QA1 tests/web
robot -d results/web/QA2 -v ENV:QA2 tests/web
robot -d results/web/QA3 -v ENV:QA3 tests/web
```

## Estratégia de massa dinâmica

A cada execução, a automação cria:

- usuário dinâmico;
- equipamento/nota com timestamp;
- descrição dinâmica;
- nota isolada por usuário.

Isso reduz dependência de massa fixa e evita colisão entre execuções.

## Uso combinado de API e UI

A API é utilizada para preparar massa de teste de forma rápida e estável. A interface web é utilizada para validar a experiência do usuário, exibição dos dados, edição refletida e status.

Essa decisão reduz fragilidade da automação sem eliminar a cobertura da camada visual.

## Estratégia mobile

A suíte mobile utiliza AppiumLibrary e abre o ExpandTesting Notes App no Chrome Android. Ela foi mantida como smoke test local porque sua execução depende de componentes externos ao projeto:

- Appium Server em execução;
- Android SDK configurado;
- variável `ANDROID_HOME` ou `ANDROID_SDK_ROOT` exportada;
- emulador Android iniciado ou aparelho físico conectado;
- Chrome disponível no device Android.

Por esse motivo, a pipeline CI/CD executa apenas a suíte web. A automação mobile está documentada para execução local e pode ser expandida para fluxos completos quando houver infraestrutura Android disponível.

## Limitações conhecidas

- O ExpandTesting Notes App é uma aplicação pública, portanto pode sofrer indisponibilidade externa.
- Os ambientes QA1, QA2 e QA3 são representados por configuração e massa dinâmica, pois o site público não fornece ambientes reais separados.
- A suíte mobile exige Appium Server e dispositivo/emulador Android configurado localmente.
