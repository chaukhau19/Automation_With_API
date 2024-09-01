*** Settings ***
Documentation  This is all tests of Media_Function
Resource  ../../Resources/DataManager.robot
Resource  ../../Data/InputData.robot
Resource  ../../Resources/Common.robot
Resource  ../../Resources/Target/Target_Li.robot

*** Test Cases ***
Drop Target
   [Documentation]     Delete Target
   [Tags]    Clear
   ${AdministrationScenarios} =  DataManager.Get Excel Data  ${Target}  DROP_ALL
   Target_LI.DELETE Target  ${AdministrationScenarios}