*** Settings ***
Documentation     Web validation for equipment editing using ExpandTesting Notes App.
Resource          ../../resources/variables/default_variables.resource
Resource          ../../resources/keywords/auth_keywords.resource
Resource          ../../resources/keywords/common_keywords.resource
Resource          ../../resources/keywords/equipment_keywords.resource
Suite Setup       Setup Web Suite
Suite Teardown    Teardown Web Suite
Force Tags        web    browser    edit

*** Variables ***
${ENV}    QA1

*** Test Cases ***
Edit Equipment Data
    [Documentation]    Validates that the equipment record can be updated without changing test code for each environment.
    ${updated_description}=    Build Updated Equipment Description    ${ENV}    ${DYNAMIC_EQUIPMENT_NAME}
    Edit Equipment Description Through Api And Validate On Web    ${updated_description}

*** Keywords ***
Setup Web Suite
    Prepare Equipment Test Data    ${ENV}
    Open Notes Application         ${BASE_URL}
    Login Through Web              ${USER_EMAIL}    ${DEFAULT_PASSWORD}
    Validate Equipment Is Displayed    ${DYNAMIC_EQUIPMENT_NAME}

Teardown Web Suite
    Run Keyword And Ignore Error    Cleanup Equipment Test Data
    Close Notes Application
