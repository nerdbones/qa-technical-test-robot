*** Settings ***
Documentation     Smoke test mobile usando Appium e a mesma configuração de ambiente utilizada nos testes web.
Resource          ../../resources/variables/default_variables.resource
Resource          ../../resources/keywords/environment_keywords.resource
Resource          ../../resources/keywords/mobile_keywords.resource
Suite Setup       Setup Mobile Suite
Suite Teardown    Close Mobile Browser
Force Tags        mobile    appium    smoke

*** Variables ***
${ENV}    QA1

*** Test Cases ***
Abrir Aplicacao No Ambiente Mobile
    [Documentation]    Abre a URL configurada para o ambiente no Chrome Android por meio do Appium.
    Validate Mobile Page Is Open

*** Keywords ***
Setup Mobile Suite
    Load Environment        ${ENV}
    Open Mobile Browser     ${MOBILE_URL}
