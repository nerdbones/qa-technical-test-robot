*** Settings ***
Documentation     Mobile smoke validation using Appium and the same environment configuration used by web tests.
Resource          ../../resources/variables/default_variables.resource
Resource          ../../resources/keywords/environment_keywords.resource
Resource          ../../resources/keywords/mobile_keywords.resource
Suite Setup       Setup Mobile Suite
Suite Teardown    Close Mobile Browser
Force Tags        mobile    appium    smoke

*** Variables ***
${ENV}    QA1

*** Test Cases ***
Open Notes App On Mobile Environment
    [Documentation]    Opens the configured environment URL in Android Chrome through Appium.
    Validate Mobile Page Is Open

*** Keywords ***
Setup Mobile Suite
    Load Environment        ${ENV}
    Open Mobile Browser     ${MOBILE_URL}
