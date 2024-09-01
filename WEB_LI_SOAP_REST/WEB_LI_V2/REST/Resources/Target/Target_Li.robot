*** Settings ***
Resource  ../Common.robot
Resource  ../../Data/InputData.robot

*** Keywords ***
GET Target
    [Arguments]  ${Scenarios}
    Send Request    ${Scenarios}    GET    ${TARGET_DOMAIN_URL}

POST Target
    [Arguments]  ${Scenarios}
    Send Request    ${Scenarios}    POST    ${TARGET_DOMAIN_URL}

PUT Target
    [Arguments]  ${Scenarios}
    Send Request    ${Scenarios}    PUT    ${TARGET_DOMAIN_URL}

DELETE Target
    [Arguments]  ${Scenarios}
    Send Request    ${Scenarios}    DELETE    ${TARGET_DOMAIN_URL}