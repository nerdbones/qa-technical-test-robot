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
    # Direct login URL is more stable than relying on the landing-page link text.
    Go To                      ${LOGIN_URL}
    Wait For Elements State    ${LOGIN_EMAIL_FIELD}       visible    timeout=${TIMEOUT}
    Fill Text                  ${LOGIN_EMAIL_FIELD}       ${email}
    Fill Text                  ${LOGIN_PASSWORD_FIELD}    ${password}
    Click                      ${LOGIN_BUTTON}
    Wait For Elements State    ${NOTES_PAGE_MARKER}       visible    timeout=${TIMEOUT}

Close Notes Application
    Run Keyword And Ignore Error    Close Browser
