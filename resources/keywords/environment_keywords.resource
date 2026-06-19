*** Settings ***
Library    ../../libraries/environment_loader.py

*** Keywords ***
Load Environment
    [Arguments]    ${env}
    ${base_url}=               Get Environment Value    ${env}    base_url
    ${mobile_url}=             Get Environment Value    ${env}    mobile_url
    ${api_url}=                Get Environment Value    ${env}    api_url
    ${login_url}=              Get Environment Value    ${env}    login_url
    ${equipment_name}=         Get Environment Value    ${env}    equipment_name
    ${category}=               Get Environment Value    ${env}    category
    ${initial_completed}=      Get Environment Value    ${env}    initial_completed
    ${updated_completed}=      Get Environment Value    ${env}    updated_completed
    ${initial_status_label}=   Get Environment Value    ${env}    initial_status_label
    ${updated_status_label}=   Get Environment Value    ${env}    updated_status_label

    Set Suite Variable    ${ENVIRONMENT}             ${env}
    Set Suite Variable    ${BASE_URL}                ${base_url}
    Set Suite Variable    ${MOBILE_URL}              ${mobile_url}
    Set Suite Variable    ${API_URL}                 ${api_url}
    Set Suite Variable    ${LOGIN_URL}               ${login_url}
    Set Suite Variable    ${EQUIPMENT_NAME}          ${equipment_name}
    Set Suite Variable    ${CATEGORY}                ${category}
    Set Suite Variable    ${INITIAL_COMPLETED}       ${initial_completed}
    Set Suite Variable    ${UPDATED_COMPLETED}       ${updated_completed}
    Set Suite Variable    ${INITIAL_STATUS_LABEL}    ${initial_status_label}
    Set Suite Variable    ${UPDATED_STATUS_LABEL}    ${updated_status_label}
