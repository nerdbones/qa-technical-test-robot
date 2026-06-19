*** Settings ***
Documentation     Validação web da consulta de equipamento por ambiente usando o ExpandTesting Notes App.
Resource          ../../resources/variables/default_variables.resource
Resource          ../../resources/keywords/auth_keywords.resource
Resource          ../../resources/keywords/equipment_keywords.resource
Suite Setup       Setup Web Suite
Suite Teardown    Teardown Web Suite
Force Tags        web    browser    environment

*** Variables ***
${ENV}    QA1

*** Test Cases ***
Consultar Equipamento Por Massa Do Ambiente
    [Documentation]    Valida a URL, a massa dinâmica e o dado retornado para o ambiente selecionado.
    Search Equipment Record          ${DYNAMIC_EQUIPMENT_NAME}
    Validate Equipment Is Displayed  ${DYNAMIC_EQUIPMENT_NAME}
    Validate Equipment Through Api

*** Keywords ***
Setup Web Suite
    Prepare Equipment Test Data    ${ENV}
    Open Notes Application         ${BASE_URL}
    Login Through Web              ${USER_EMAIL}    ${DEFAULT_PASSWORD}

Teardown Web Suite
    Run Keyword And Ignore Error    Cleanup Equipment Test Data
    Close Notes Application
