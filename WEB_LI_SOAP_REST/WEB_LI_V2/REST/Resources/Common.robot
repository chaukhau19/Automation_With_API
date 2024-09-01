*** Settings ***
Library   SSHLibrary
Library   Collections
Resource   ../Data/InputData.robot
Library  ../CustomLibs/sendEmail.py
Resource  Keywords.robot

*** Keywords ***
Get Remote RPM
    [Arguments]   ${SSH_HOST}   ${SSH_USERNAME}     ${SSH_PASSWORD}   ${RPM_NAME}

    Open Connection   ${SSH_HOST}
    Login   ${SSH_USERNAME}   ${SSH_PASSWORD}
    ${RPM_REVISION}=   Execute Command   ${RPM_NAME}
    Close All Connections
    Log    ${RPM_REVISION}
    RETURN  ${RPM_REVISION}

Open SSH Connection To Remote Server
    [Arguments]  ${HOST}  ${USER_NAME}  ${PSW}
    Open Connection   ${HOST}
    Login   ${USER_NAME}   ${PSW}


######################
Send Notification Email for SOAP
    ${WEB_SERVICES_RPM_REVISION} =    Get Remote RPM    ${WEB_SSH_HOST}    ${WEB_SSH_USERNAME}    ${WEB_SSH_PASSWORD}    ${WEB_SERVICES_RPM_REVISION}
    ${SUBJECT_WEB_SERVICES} =   Set Variable   [ SBC WEB LI ] AUTO NON REG TEST FOR SOAP - RPM REVISION ${WEB_SERVICES_RPM_REVISION}
    Log    ${SUBJECT_WEB_SERVICES}
    Send Notification Email SOAP    ${SUBJECT_WEB_SERVICES}    result/Report.csv    result/Request-Response.7z    SBC_WEB_LI

Send Notification Email SOAP
    [Arguments]   ${EMAIL_SUBJECT}    ${REPORT_CSV}   ${LOG}  ${MODE}

    ${TOTAL}    ${PASS}    ${FAIL} =    Send Count TCs SOAP  ${REPORT_CSV}
  #  Send Mail With Attachment    ${EMAIL_SENDER}   ${EMAIL_PWD}    ${EMAIL_RECEIVER}   ${EMAIL_SUBJECT}    ${EMAIL_CONTENT}   ${TOTAL}    ${PASS}    ${FAIL}   ${EMAIL_CONTENT2}    ${LOG}   ${REPORT_CSV}  ${MODE}
   send mail with attachment soap    ${EMAIL_SENDER}   ${EMAIL_PWD}    ${EMAIL_RECEIVER}   ${EMAIL_SUBJECT}    ${EMAIL_CONTENT}   ${TOTAL}    ${PASS}    ${FAIL}   ${EMAIL_CONTENT2}    ${LOG}   ${REPORT_CSV}  ${MODE}

######################
Send Notification Email for REST
    ${WEB_SERVICES_RPM_REVISION} =    Get Remote RPM    ${WEB_SSH_HOST}    ${WEB_SSH_USERNAME}    ${WEB_SSH_PASSWORD}    ${WEB_SERVICES_RPM_REVISION}
    ${SUBJECT_WEB_SERVICES}   Set Variable   [ SBC WEB LI ] AUTO NON REG TEST FOR REST - RPM REVISION ${WEB_SERVICES_RPM_REVISION}
    Log    ${SUBJECT_WEB_SERVICES}
    Send Notification Email REST     ${SUBJECT_WEB_SERVICES}    result/log.html    result/report.html    result/output.xml    SBC_WEB_LI_REST_RHEL8

Send Notification Email REST
    [Arguments]   ${EMAIL_SUBJECT}    ${LOG_HTML}   ${REPORT_HTML}   ${OUTPUT_DIR}  ${MODE}

    ${TOTAL}    ${PASS}    ${FAIL}   ${VALIDATIONFILES}  ${DURATION} =    Send Count TCs REST   ${OUTPUT_DIR}
    Send Mail With Attachment    ${EMAIL_SENDER}   ${EMAIL_PWD}    ${EMAIL_RECEIVER}   ${EMAIL_SUBJECT}    ${EMAIL_CONTENT}   ${TOTAL}    ${PASS}    ${FAIL}   ${VALIDATIONFILES}   ${DURATION}   ${EMAIL_CONTENT2}    ${LOG_HTML}   ${REPORT_HTML}  ${MODE}
######################

Send Count TCs REST
    [Arguments]   ${OUTPUT_DIR}
    ${value}    ${value2}   ${value3}   ${value4}   ${value5} =   count_test_cases   ${OUTPUT_DIR}
    RETURN    ${value}    ${value2}   ${value3}   ${value4}  ${value5}

Send Count TCs SOAP
    [Arguments]   ${REPORT_CSV}

    ${value}    ${value2}   ${value3} =   count_test_cases_soap   ${REPORT_CSV}
    RETURN    ${value}    ${value2}   ${value3}


Send Request
    [Arguments]  ${Scenarios}    ${Method}    ${DOMAIN_URL}
    FOR    ${Info}  IN  @{Scenarios}
        TRY
            ${Data} =    Get Slice From List    ${Info}    2    7    #Not included the end
            ${Data} =    Set Data Test WS    ${Data}  
            
            Send API And Verify    ${Method}    ${BASE_URL_API}    ${DOMAIN_URL}    ${Data}[Target_Uri]  ${Data}[Json]   ${Data}[Status_Code]   ${Data}[Message]

        EXCEPT    AS    ${error}
            Run Keyword And Continue On Failure    Fail   ${error}    TCS Failed
        END     
    END

Set Data Test WS
    [Arguments]    ${Data}
    &{dict} =    Create Dictionary     Target_Uri=    Json=    Status_Code=    Message=
    FOR    ${key}    ${value}    IN ZIP    ${dict}    ${Data}
        Set To Dictionary    ${dict}    ${key}    ${value}      
    END
    RETURN    ${dict}
