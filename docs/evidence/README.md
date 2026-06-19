# Evidências de Execução

As evidências são geradas automaticamente pelo Robot Framework durante a execução das suítes.

## Evidências geradas

Para cada ambiente executado, o projeto gera:

- `log.html`
- `report.html`
- `output.xml`
- screenshots capturados durante as validações principais

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

## Observação

Os arquivos dentro de `results/` são ignorados pelo Git para evitar versionar artefatos grandes ou temporários. Para envio da entrega, recomenda-se executar os testes e anexar os relatórios gerados como evidência complementar ou disponibilizá-los como artefato da pipeline.
