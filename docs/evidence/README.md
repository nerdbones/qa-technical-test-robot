# Evidências de Execução

As evidências são geradas automaticamente pelo Robot Framework durante a execução das suítes.

## Evidências geradas

Para cada ambiente executado, o projeto gera:

- `log.html`;
- `report.html`;
- `output.xml`;
- screenshots capturados durante as validações principais.

## Estrutura esperada

```text
results/
├── web/
│   ├── QA1/
│   ├── QA2/
│   └── QA3/
└── mobile/
    ├── QA1/
    ├── QA2/
    └── QA3/
```

## Versionamento das evidências

Os arquivos gerados dentro de `results/` são ignorados pelo Git para evitar versionamento de relatórios temporários, screenshots e artefatos pesados.

Em execuções locais, as evidências podem ser consultadas diretamente na pasta `results/`. Em CI, os relatórios web são disponibilizados como artefatos do GitHub Actions.
