import sys
import logging
from datetime import datetime

class SystemLog:
    def InsertInfoLog(self, transactionId, transactionTitle, data, transactionDateTime, username, channelId, ipAddress, response):
        logging.basicConfig(filename='config/logHistory.log',level=logging.DEBUG)
        log = logging.getLogger('werkzeug')
        log.disabled = True
        logging.info("Transaction ID:" + transactionId + " | Tranactaion Date and Time: " + transactionDateTime.strftime('%Y/%m/%d %H:%M:%S') + " | Transaction Title: " + transactionTitle + " | Username: " + username + " | Channel ID: " + channelId  + " | IP Address: " + ipAddress + " | Inserted Data: " + data + " | Response:" + response)


    def InsertErrorLog(self, transactionId, transactionTitle, data, transactionDateTime, username, channelId, ipAddress, response, errorCode, errorMessage):
        logging.basicConfig(filename='config/logHistory.log',level=logging.DEBUG)
        log = logging.getLogger('werkzeug')
        log.disabled = True
        logging.error("Transaction ID:" + transactionId + " | Tranactaion Date and Time: " + transactionDateTime.strftime('%Y/%m/%d %H:%M:%S') + " | Transaction Title: " + transactionTitle + " | Username: " + username + " | Channel ID: " + channelId  + " | IP Address: " + ipAddress + " | Inserted Data: " + data + " | Response:" + response + " | Error Code:" + errorCode + " | Error Message:" + errorMessage, exc_info=True)