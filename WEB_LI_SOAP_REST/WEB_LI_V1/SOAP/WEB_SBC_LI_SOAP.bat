@echo off

set SOAP_Folder="D:\SBC_WEB_LI_AUTO\RHEL88\SOAP"
set SOAPUI_bin="C:\Program Files\SmartBear\SoapUI-5.7.2\bin"

call rmdir /s /q %SOAP_Folder%\SoapUIResults

%SOAPUI_bin%\testrunner.bat -A -f %SOAP_Folder%\SoapUIResults %SOAP_Folder%\SBC-LI-SOAP-soapui-project.xml