*** Settings ***
Library    String
Library    DateTime
Library    OperatingSystem
Library    Collections

*** Keywords ***
Generate Run Id
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${random}=       Generate Random String    5    [LOWER]
    ${run_id}=       Set Variable    ${timestamp}-${random}
    RETURN    ${run_id}

Build Dynamic Email
    [Arguments]    ${env}    ${run_id}
    ${env_lower}=    Convert To Lower Case    ${env}
    ${safe_run_id}=  Replace String    ${run_id}    -    .
    ${email}=        Set Variable    ${env_lower}.${safe_run_id}@example.com
    RETURN    ${email}

Build Dynamic Equipment Name
    [Arguments]    ${equipment_name}    ${run_id}
    ${dynamic_name}=    Set Variable    ${equipment_name} - ${run_id}
    RETURN    ${dynamic_name}

Build Equipment Description
    [Arguments]    ${env}    ${equipment_name}
    ${description}=    Set Variable    Registro de equipamento gerado automaticamente para ${env}: ${equipment_name}
    RETURN    ${description}

Build Updated Equipment Description
    [Arguments]    ${env}    ${equipment_name}
    ${description}=    Set Variable    Registro de equipamento atualizado automaticamente para ${env}: ${equipment_name}
    RETURN    ${description}
