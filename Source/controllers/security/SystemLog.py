import sys
import logging
from datetime import datetime

class SystemLog:
    def InsertInfoLog(self, responseCode, transactionTitle, data, transactionDateTime, username, channelId, ipAddress, responseMessage):
        logging.basicConfig(filename='config/logHistory.log',level=logging.DEBUG)
        log = logging.getLogger('werkzeug')
        log.disabled = True
        logging.info("Response Code:" + responseCode + " | Date and Time: " + transactionDateTime.strftime('%Y/%m/%d %H:%M:%S') + " | Title: " + transactionTitle + " | Username: " + username + " | Channel ID: " + channelId  + " | IP Address: " + ipAddress + " | Inserted Data: " + data + " | Response Message:" + responseMessage)


    def InsertErrorLog(self, responseCode, transactionTitle, data, transactionDateTime, username, channelId, ipAddress, responseMessage):
        logging.basicConfig(filename='config/logHistory.log',level=logging.DEBUG)
        log = logging.getLogger('werkzeug')
        log.disabled = True
        logging.error("Response Code:" + responseCode + " | Date and Time: " + transactionDateTime.strftime('%Y/%m/%d %H:%M:%S') + " | Title: " + transactionTitle + " | Username: " + username + " | Channel ID: " + channelId  + " | IP Address: " + ipAddress + " | Inserted Data: " + data + " | Response Message:" + responseMessage, exc_info=True)