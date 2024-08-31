*** Settings ***
Documentation    Tool to send notification email
Resource  ../Data/InputData.robot
Resource  ../Resources/Common.robot

*** Test Cases ***
Send Auto Result Notification Email
    [Tags]    SendEmail
    IF  '${REPORT_MODE}' == 'REST'             Run Keyword And Continue On Failure  Send Notification Email for REST
    ...  ELSE IF  '${REPORT_MODE}' == 'SOAP'   Run Keyword And Continue On Failure  Send Notification Email for SOAP    
    ...  ELSE   log to console  ERROR: Wrong options. Please select REPORT_MODE=[SOAP|REST].