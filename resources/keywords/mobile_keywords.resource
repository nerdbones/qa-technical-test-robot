*** Settings ***
Library    AppiumLibrary

*** Keywords ***
Open Mobile Browser
    [Arguments]    ${url}
    Open Application
    ...    http://127.0.0.1:4723
    ...    platformName=Android
    ...    automationName=UiAutomator2
    ...    browserName=Chrome
    ...    newCommandTimeout=120
    Go To Url    ${url}

Validate Mobile Page Is Open
    Wait Until Page Contains    Notes    timeout=30s
    Capture Page Screenshot

Close Mobile Browser
    Run Keyword And Ignore Error    Close Application
