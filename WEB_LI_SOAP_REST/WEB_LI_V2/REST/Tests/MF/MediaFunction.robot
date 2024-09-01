*** Settings ***
Documentation  This is all tests of Media_Function
Resource  ../../Resources/DataManager.robot
Resource  ../../Data/InputData.robot
Resource  ../../Resources/Common.robot
Resource  ../../Resources/MF/MF.robot

*** Test Cases ***

Add MF
    [Documentation]     Add mediationFunction
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${MF}  POST
    MF.POST MF  ${AdministrationScenarios}

Add Invalid MF
    [Documentation]     Add mediationFunction
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${MF}  POST_INVALID
    MF.POST MF  ${AdministrationScenarios}

Modify MF
    [Documentation]     Modify mediationFunction
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${MF}  PUT
    MF.PUT MF  ${AdministrationScenarios}

Modify Invalid MF
    [Documentation]     Modify mediationFunction
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${MF}  PUT_INVALID
    MF.PUT MF  ${AdministrationScenarios}

Retrieve MF
    [Documentation]     Retrieve mediationFunction
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${MF}  RETRIEVE
    MF.GET MF  ${AdministrationScenarios}

Drop MF
   [Documentation]     Delete MF
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${MF}  DROP
    MF.DELETE MF  ${AdministrationScenarios}

List MF
    [Documentation]     List all mediationFunction
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${MF}  LIST
    MF.GET MF  ${AdministrationScenarios}