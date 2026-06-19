*** Settings ***
Documentation     Web validation for environment-based equipment search using ExpandTesting Notes App.
Resource          ../../resources/variables/default_variables.resource
Resource          ../../resources/keywords/auth_keywords.resource
Resource          ../../resources/keywords/equipment_keywords.resource
Suite Setup       Setup Web Suite
Suite Teardown    Teardown Web Suite
Force Tags        web    browser    environment

*** Variables ***
${ENV}    QA1

*** Test Cases ***
Search Equipment By Environment Data
    [Documentation]    Validates URL, dynamic mass and returned data for the selected environment.
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
