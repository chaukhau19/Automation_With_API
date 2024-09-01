*** Settings ***
Resource  ../Common.robot
Resource  ../../Data/InputData.robot

*** Keywords ***
GET MF
    [Arguments]  ${Scenarios}
    Send Request    ${Scenarios}    GET    ${MF_DOMAIN_URL}

POST MF
    [Arguments]  ${Scenarios}
    Send Request    ${Scenarios}    POST    ${MF_DOMAIN_URL}

PUT MF
    [Arguments]  ${Scenarios}
    Send Request    ${Scenarios}    PUT    ${MF_DOMAIN_URL}

DELETE MF
    [Arguments]  ${Scenarios}
    Send Request    ${Scenarios}    DELETE    ${MF_DOMAIN_URL}
