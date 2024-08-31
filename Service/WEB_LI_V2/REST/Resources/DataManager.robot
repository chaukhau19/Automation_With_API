*** Settings ***
Documentation  Use this layer to get data from external files
Library  ../CustomLibs/Csv.py
Library  ../CustomLibs/Excel.py
Library  ../CustomLibs/ReadDataExcel.py


*** Keywords ***
Get CSV Data
    [Arguments]  ${FilePath}
    ${Data} =  read csv file  ${FilePath}
    RETURN  ${Data}

Get Excel Data
    [Arguments]  ${FilePath}    ${Worksheet}
    ${Data} =  read excel file  ${FilePath}     ${Worksheet}
    RETURN  ${Data}