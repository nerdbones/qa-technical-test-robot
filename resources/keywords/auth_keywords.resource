*** Settings ***
Library    Browser
Resource   ../variables/default_variables.resource
Resource   ../pages/login_page.resource

*** Keywords ***
Open Notes Application
    [Arguments]    ${url}
    New Browser    ${DEFAULT_BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1366, 'height': 768}
    New Page       ${url}

Login Through Web
    [Arguments]    ${email}    ${password}
    # A URL direta de login é mais estável do que depender do texto do link na página inicial.
    Go To                      ${LOGIN_URL}
    Wait For Elements State    ${LOGIN_EMAIL_FIELD}       visible    timeout=${TIMEOUT}
    Fill Text                  ${LOGIN_EMAIL_FIELD}       ${email}
    Fill Text                  ${LOGIN_PASSWORD_FIELD}    ${password}
    Click                      ${LOGIN_BUTTON}
    Wait For Elements State    ${NOTES_PAGE_MARKER}       visible    timeout=${TIMEOUT}

Close Notes Application
    Run Keyword And Ignore Error    Close Browser
