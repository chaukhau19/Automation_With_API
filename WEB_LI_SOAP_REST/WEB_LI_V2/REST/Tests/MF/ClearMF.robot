*** Settings ***
Documentation  This is all tests of Media_Function
Resource  ../../Resources/DataManager.robot
Resource  ../../Data/InputData.robot
Resource  ../../Resources/Common.robot
Resource  ../../Resources/MF/MF.robot

*** Test Cases ***
Drop All MF
   [Documentation]     Delete MF
   [Tags]    Clear
   ${AdministrationScenarios} =  DataManager.Get Excel Data  ${MF}  DROP_ALL
   MF.DELETE MF  ${AdministrationScenarios}
