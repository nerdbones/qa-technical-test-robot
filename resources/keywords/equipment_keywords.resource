*** Settings ***
Library    Browser
Library    Collections
Library    ../../libraries/notes_api.py
Resource   ../variables/default_variables.resource
Resource   common_keywords.resource
Resource   environment_keywords.resource
Resource   ../pages/notes_page.resource

*** Keywords ***
Prepare Equipment Test Data
    [Arguments]    ${env}
    Load Environment    ${env}
    ${run_id}=       Generate Run Id
    ${email}=        Build Dynamic Email    ${env}    ${run_id}
    ${title}=        Build Dynamic Equipment Name    ${EQUIPMENT_NAME}    ${run_id}
    ${description}=  Build Equipment Description    ${env}    ${title}

    Register User Through Api    ${API_URL}    ${TESTER_NAME} ${env}    ${email}    ${DEFAULT_PASSWORD}
    ${token}=    Login User Through Api    ${API_URL}    ${email}    ${DEFAULT_PASSWORD}
    ${note_id}=  Create Note Through Api    ${API_URL}    ${token}    ${title}    ${description}    ${CATEGORY}

    Set Suite Variable    ${RUN_ID}                     ${run_id}
    Set Suite Variable    ${USER_EMAIL}                 ${email}
    Set Suite Variable    ${API_TOKEN}                  ${token}
    Set Suite Variable    ${NOTE_ID}                    ${note_id}
    Set Suite Variable    ${DYNAMIC_EQUIPMENT_NAME}     ${title}
    Set Suite Variable    ${EQUIPMENT_DESCRIPTION}      ${description}

Search Equipment Record
    [Arguments]    ${title}
    # The public Notes UI may render the same title inside both title and
    # description areas. To avoid Browser Library strict-mode ambiguity, this
    # keyword validates the searched record via API and then targets only the
    # note-card title in the UI.
    ${response}=    Get Note Through Api    ${API_URL}    ${API_TOKEN}    ${NOTE_ID}
    ${data}=        Get From Dictionary    ${response}    data
    ${api_title}=   Get From Dictionary    ${data}        title
    Should Be Equal    ${api_title}    ${title}
    Wait Until Equipment Title Is Visible    ${title}
    Take Evidence Screenshot   search-equipment

Validate Equipment Is Displayed
    [Arguments]    ${title}
    Wait Until Equipment Title Is Visible    ${title}
    Take Evidence Screenshot   equipment-displayed

Validate Equipment Description Is Displayed
    [Arguments]    ${description}
    Wait Until Equipment Description Is Visible    ${description}
    Take Evidence Screenshot   equipment-description

Edit Equipment Description Through Api And Validate On Web
    [Arguments]    ${description}
    Update Note Through Api    ${API_URL}    ${API_TOKEN}    ${NOTE_ID}    ${DYNAMIC_EQUIPMENT_NAME}    ${description}    ${CATEGORY}    ${INITIAL_COMPLETED}
    Reload
    Wait Until Equipment Description Is Visible    ${description}
    Take Evidence Screenshot   edited-equipment

Mark Equipment As Completed Through Api And Validate On Web
    Update Note Through Api    ${API_URL}    ${API_TOKEN}    ${NOTE_ID}    ${DYNAMIC_EQUIPMENT_NAME}    ${EQUIPMENT_DESCRIPTION}    ${CATEGORY}    ${UPDATED_COMPLETED}
    Reload
    Wait Until Equipment Title Is Visible    ${DYNAMIC_EQUIPMENT_NAME}
    Wait For Elements State    ${NOTE_STATUS_TOGGLE}    checked    timeout=${TIMEOUT}
    Take Evidence Screenshot   completed-equipment

Validate Equipment Through Api
    ${response}=    Get Note Through Api    ${API_URL}    ${API_TOKEN}    ${NOTE_ID}
    ${data}=        Get From Dictionary    ${response}    data
    ${title}=       Get From Dictionary    ${data}        title
    Should Be Equal    ${title}    ${DYNAMIC_EQUIPMENT_NAME}

Cleanup Equipment Test Data
    Run Keyword And Ignore Error    Delete Note Through Api    ${API_URL}    ${API_TOKEN}    ${NOTE_ID}

Wait Until Equipment Title Is Visible
    [Arguments]    ${title}
    ${title_selector}=    Set Variable    xpath=//div[@data-testid="note-card-title" and normalize-space(.)="${title}"]
    Wait For Elements State    ${title_selector}    visible    timeout=${TIMEOUT}

Wait Until Equipment Description Is Visible
    [Arguments]    ${description}
    ${description_selector}=    Set Variable    xpath=//p[@data-testid="note-card-description" and contains(normalize-space(.), "${description}")]
    Wait For Elements State    ${description_selector}    visible    timeout=${TIMEOUT}

Take Evidence Screenshot
    [Arguments]    ${name}
    ${file}=    Set Variable    ${OUTPUT DIR}/${name}-${ENVIRONMENT}-${RUN_ID}.png
    Take Screenshot    filename=${file}
