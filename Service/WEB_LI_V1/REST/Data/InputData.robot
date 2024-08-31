*** Variables ***
# Configuration
${TC_PRIORITY}         LOW
${DATA_DIRECTORY}      ${CURDIR}
${BASE_URL_API}        https://192.168.33.220:444

#### DOMAIN URL ####
${MF_DOMAIN_URL}       /v1/li/mediationFunction
${TARGET_DOMAIN_URL}   /v1/li/target

${WEB_SSH_HOST}        192.168.33.220
${WEB_SSH_USERNAME}    root
${WEB_SSH_PASSWORD}    rcirkey

#### REST DATA FILE ####
${MF} =   ${DATA_DIRECTORY}${/}MF${/}MF.xlsx
${Target} =   ${DATA_DIRECTORY}${/}Target${/}Target.xlsx

########################################################################################################################
${EMAIL_SENDER} =   cirpack_wiki@tma.com.vn
${EMAIL_PWD} =    Cirpack!2024
${EMAIL_RECEIVER} =   ltbinh2@tma.com.vn, ntckhau@tma.com.vn

${EMAIL_CONTENT}    Hi All,\n\nPlease see detail the auto non reg test result in the attached html files.\n\n
${EMAIL_CONTENT2}       \n\nBest Regards\n\nTMA Validation

${WEB_SERVICES_RPM_REVISION} =   yum list installed | grep SBC_LI.noarch | awk -F" " '{print $2}' | awk -F".el" '{print $1}'
${REPORT_MODE} =   REST

