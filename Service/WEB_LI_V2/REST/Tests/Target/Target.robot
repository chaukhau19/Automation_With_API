*** Settings ***
Documentation  This is all tests of Media_Function
Resource  ../../Resources/DataManager.robot
Resource  ../../Data/InputData.robot
Resource  ../../Resources/Common.robot
Resource  ../../Resources/Target/Target_Li.robot

*** Test Cases ***

Add Target
    [Documentation]     Add Target
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${Target}  POST
    Target_LI.POST Target  ${AdministrationScenarios}

Add Invalid Target
    [Documentation]     Add Invalid Target
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${Target}  POST_INVALID
    Target_LI.POST Target  ${AdministrationScenarios}

Modify Target    
    [Documentation]     Modify Target
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${Target}  PUT
    Target_LI.PUT Target  ${AdministrationScenarios}

Modify Invalid Target
    [Documentation]     Modify Invalid Target
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${Target}  PUT_INVALID
    Target_LI.PUT Target  ${AdministrationScenarios}

Retrieve Target
    [Documentation]     Retrieve Target
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${Target}  RETRIEVE
    Target_LI.Get Target  ${AdministrationScenarios}

Drop Target
   [Documentation]     Delete Target
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${Target}  DROP
    Target_LI.DELETE Target  ${AdministrationScenarios}

List Target
    [Documentation]     List all Target
    [Tags]    Excute
    ${AdministrationScenarios} =  DataManager.Get Excel Data  ${Target}  LIST
    Target_LI.Get Target  ${AdministrationScenarios}