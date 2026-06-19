*** Settings ***
Documentation     Web validation for equipment status using ExpandTesting Notes App.
Resource          ../../resources/variables/default_variables.resource
Resource          ../../resources/keywords/auth_keywords.resource
Resource          ../../resources/keywords/equipment_keywords.resource
Suite Setup       Setup Web Suite
Suite Teardown    Teardown Web Suite
Force Tags        web    browser    status

*** Variables ***
${ENV}    QA1

*** Test Cases ***
Validate Equipment Status Change
    [Documentation]    Validates that the configured equipment can be marked as completed for the selected environment.
    Mark Equipment As Completed Through Api And Validate On Web

*** Keywords ***
Setup Web Suite
    Prepare Equipment Test Data    ${ENV}
    Open Notes Application         ${BASE_URL}
    Login Through Web              ${USER_EMAIL}    ${DEFAULT_PASSWORD}
    Validate Equipment Is Displayed    ${DYNAMIC_EQUIPMENT_NAME}

Teardown Web Suite
    Run Keyword And Ignore Error    Cleanup Equipment Test Data
    Close Notes Application
