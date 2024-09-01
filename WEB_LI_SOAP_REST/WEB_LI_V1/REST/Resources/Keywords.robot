*** Settings ***
Library   RequestsLibrary
Resource  ../Data/InputData.robot
Resource  Common.robot
Library   String

*** Keywords ***

Verify more log
    [Arguments]  ${output}  ${EXPECTED_WS_LOG}
    @{list_logs}=  Split String  ${EXPECTED_WS_LOG}  \n
    FOR    ${List}  IN  @{list_logs}
       run keyword and continue on failure   Should Contain  ${output}  ${list}
    END

Send API And Verify
    [Arguments]    ${METHOD}    ${URL_API}   ${DOMAIN_URL}   ${TARGET_URI}     ${JSON_DATA}   ${EXPECTED_RESPONSE_STATUS_CODE}  ${EXPECTED_RESPONSE_MESSAGE}
    ${Header} =        Create Dictionary    Content-Type=application/json
    ${Alias_Session}   Set Variable  sbc_web_li_session

    IF    '''${TARGET_URI}''' != ''    
        ${TARGET_URI} =    Catenate    SEPARATOR=    /    ${TARGET_URI}
    END
    
    Create Session  ${Alias_Session}    ${URL_API}   disable_warnings=1
    ${Response} =   run keyword    ${METHOD} On Session   ${Alias_Session}   ${DOMAIN_URL}${TARGET_URI}   data=${JSON_DATA}   headers=${Header}    expected_status=anything

    ${Status_Code} =      Convert To String  ${Response.status_code}
    ${Content} =          Convert To String  ${Response.content}
    ${status_headers} =   Convert To String  ${Response.headers}

    Log    ${Content}
    Run Keyword And Return Status    Set Test Variable    ${Curl_CMD}    curl -ikX ${METHOD} '${URL_API}${DOMAIN_URL}${TARGET_URI}' -H 'Content-Type: application/json' --data '${JSON_DATA}'
    Log    ${Curl_CMD}
    Should Contain   ${Status_Code}   ${EXPECTED_RESPONSE_STATUS_CODE}
    Verify more log  ${Content}       ${EXPECTED_RESPONSE_MESSAGE}