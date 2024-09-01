import smtplib, ssl
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from xml.dom import minidom
from jinja2 import Environment
from datetime import datetime

import time
import json

def Week():
    week_now = datetime.now().strftime("%W")
    #week_now = int(week_now) - 1
    return week_now
def send_mail_with_attachment(from_user, from_password, to, subject, EMAIL_CONTENT, TOTAL, PASS, FAIL, VALIDATIONFILES, DURATION, EMAIL_CONTENT2, attach_file1, attach_file2, mode):
    msg = MIMEMultipart()

    msg['From'] = from_user
    #msg['To'] = to
    recipients = list(to.split(";"))
    msg['To'] = ";".join(recipients)
    msg['Subject'] = subject

    TEMPLATE = """
        <html>
        <head>
        <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 50%;            
        }
        td, th {
            border: 2px solid #dddddd;
            text-align: left;
            padding: 8px;
            font-weight: bold;
            font-size: 14pt;
        }
        </style>
        </head>
        <body>
        <br/>
        <table class="tableData">
              <tr style='background-color:lime'>
                  <td>PASSED TCs</td>
                  <td>{{ PASS }}</td>
              </tr>
              <tr style='background-color:orangered'>
                  <td>FAILED TCs </td>
                  <td>{{ FAIL }}</td>
              </tr>
              <tr style='background-color:aqua'>
                  <td> TOTAL TCs </td>
                  <td>{{ TOTAL }}</td>
              </tr>  
              <tr style='background-color:yellow'>
                  <td>TOTAL DURATION</td>
                  <td>{{ DURATION }}</td>
              </tr>
              <tr style='background-color:gray'>
                  <td>TOTAL TEST FILES</td>
                  <td>{{ VALIDATIONFILES }}</td>
              </tr>
        </table>
        <br/>
        <br/>
        </body>
        </html>
        """
    msg.attach(MIMEText(EMAIL_CONTENT +
        Environment().from_string(TEMPLATE).render(
            TOTAL=str(TOTAL),
            PASS=PASS,
            FAIL=FAIL,
            VALIDATIONFILES=str(VALIDATIONFILES),
            DURATION=str(DURATION)
        ) + (EMAIL_CONTENT2), "html"
    ))


    # attach1 = MIMEBase('application', 'octet-stream')
    # attach1.set_payload(open(attach_file1, 'rb').read())
    # encoders.encode_base64(attach1)
    # attach1.add_header('Content-Disposition',
    #                 'attachment; filename="%s"' % os.path.basename(attach_file1))
    # msg.attach(attach1)

    # attach2 = MIMEBase('application', 'octet-stream')
    # attach2.set_payload(open(attach_file2, 'rb').read())
    # encoders.encode_base64(attach2)
    # attach2.add_header('Content-Disposition',
    #                    'attachment; filename="%s"' % os.path.basename(attach_file2))
    # msg.attach(attach2)

    #mailServer = smtplib.SMTP("11.11.4.7")
    mailServer = smtplib.SMTP_SSL(host='11.11.4.7', port=465)
# ============================SMTP GMAIL============================
#     mailServer = smtplib.SMTP('smtp.gmail.com', 587)               #
#     mailServer.ehlo()                                              #
#     mailServer.starttls()                                          #
#     mailServer.ehlo()                                              #
# ==================================================================
    mailServer.login(from_user, from_password)
    mailServer.sendmail(from_user, recipients, msg.as_string())
    # Should be mailServer.quit(), but that crashes...
    mailServer.close()
    # Write the content to JSON file
    dictionary = {
            "TOTAL": TOTAL,
            "PASS": PASS,
            "FAIL": FAIL,
            "VALIDATIONFILES": VALIDATIONFILES,
            "DURATION": str(DURATION)
    }
    # Writing to <mode>_output.json
    with open(mode + "_output" + ".json", "w") as outfile:
        json.dump(dictionary, outfile)

def send_mail_no_attachment(from_user, from_password, to, subject, text):
    msg = MIMEMultipart()

    msg['From'] = from_user
    msg['To'] = to
    msg['Subject'] = subject
    msg.attach(MIMEText(text))

    #mailServer = smtplib.SMTP("11.11.4.7", 587)
    mailServer = smtplib.SMTP_SSL(host='11.11.4.7', port=465)
    #username = 'cirpack_wiki@tma.com.vn'
    #password = '123456789x@X'
    #mailServer.login(username, password)
# ============================SMTP GMAIL============================
#     mailServer = smtplib.SMTP('smtp.gmail.com', 587)               #
#     mailServer.ehlo()                                              #
#     mailServer.starttls()                                          #
#     mailServer.ehlo()                                              #
# ==================================================================
    mailServer.login(from_user, from_password)
    mailServer.sendmail(from_user, to, msg.as_string())
    # Should be mailServer.quit(), but that crashes...
    mailServer.close()

# Summary the metrics of test cases in output.xml file.
def count_test_cases(outputDir):
    xmldoc = minidom.parse(outputDir)
    testcasesList = xmldoc.getElementsByTagName('iter')
    statusList = xmldoc.getElementsByTagName('status')
    tcsTotal = 0
    tcsPass = 0
    tcsFailed = 0
    countValidationFiles = 0
    duration = 0

#=========== Count Total - Pass - Fail tcs ===========
    for testCase in testcasesList:
        tcsList = testCase.getElementsByTagName('var')
        for case in tcsList:
            if case.hasAttribute('name') and 'Info' in case.attributes['name'].value:           
                statusForItemList = testCase.getElementsByTagName('status')
                statusOfTc = statusForItemList[len(statusForItemList) - 1].attributes['status'].value
                # In new format of Robot Framework xml file, it has 3 status: PASS + FAIL + NOT RUN (Binh Le update - 09/08/2022)
                if statusOfTc == 'PASS':
                    tcsPass += 1
                    tcsTotal += 1
                elif statusOfTc == 'FAIL':
                    tcsFailed += 1
                    tcsTotal += 1              
#====== Count validation files
    validationFilesList = xmldoc.getElementsByTagName('test')
    for validationFiles in validationFilesList:
        if validationFiles.attributes['name']:
            countValidationFiles = countValidationFiles + 1
            # print(validationFiles.attributes['name'].value)
            
#====== Count Duration
    ## Use for RF >7.0
    # if len(statusList) > 0:
    #     lastStatus = statusList[len(statusList) - 1] 
    #     elapsedTime = float(lastStatus.attributes['elapsed'].value)
    #     duration = time.strftime('%H:%M:%S', time.gmtime(elapsedTime))

    ## Use for RF >7.0
    # if len(statusList) > 0:
    #     lastStatus = statusList[len(statusList) - 1]
    #     start = lastStatus.attributes['starttime'].value
    #     end = lastStatus.attributes['endtime'].value
    #     if ((start == 'N/A') and (end == 'N/A')):
    #         elapsedtime = float(lastStatus.attributes['elapsedtime'].value)
    #         # print(elapsedtime)
    #         duration = time.strftime('%H:%M:%S', time.gmtime(elapsedtime / 1000))
    #         #duration = time.strftime('%H:%M:%S', time.gmtime(elapsedtime))
    #     else:
    #         FMT = '%Y%m%d %H:%M:%S.%f'
    #         duration = (datetime.strptime(end, FMT) - datetime.strptime(start, FMT)).total_seconds()
    #         duration = time.strftime('%H:%M:%S', time.gmtime(duration))  

    # print('PASS TCs:', str(tcsPass) + percentage(tcsPass, tcsTotal))
    # print('FAILED TCs:', str(tcsFailed) + percentage(tcsFailed, tcsTotal))
    # print('Total TCs: ', tcsTotal)   
    # print('Total Duration: ', duration)   
    # print('Total Test Files: ', countValidationFiles)   

    # return tcsTotal, str(tcsPass) + percentage(tcsPass, tcsTotal), str(tcsFailed) + percentage(tcsFailed, tcsTotal), countValidationFiles, duration
#====== Count Duration
    if len(statusList) > 0:
        lastStatus = statusList[len(statusList) - 1] 
        elapsedTime = float(lastStatus.attributes['elapsed'].value)
        duration = time.strftime('%H:%M:%S', time.gmtime(elapsedTime))
    print(duration)
    print('PASS TCs:', str(tcsPass) + percentage(tcsPass, tcsTotal))
    print('FAILED TCs:', str(tcsFailed) + percentage(tcsFailed, tcsTotal))
    print('Total TCs: ', tcsTotal)   
    print('Total Duration: ', duration)   
    print('Total Test Files: ', countValidationFiles)   

    return tcsTotal, str(tcsPass) + percentage(tcsPass, tcsTotal), str(tcsFailed) + percentage(tcsFailed, tcsTotal), countValidationFiles, duration


def percentage(tcs, total):
    if total > 0:
        return ' ({0:.1f}'.format((float(tcs) / float(total) * 100)) + '%)'
    return ' (0%)'
# print('====================Web Prov====================')
# count_test_cases('D:\IMS_WEB_AUTO\Sanity\Results\WebProv37.209\output.xml')
