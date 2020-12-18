import sys
import logging
from datetime import datetime
import configparser
import os
from models.DatabaseContext import *

config = configparser.ConfigParser()
rootDir =  os.path.abspath(os.curdir)
formatter = logging.Formatter('%(levelname)s %(message)s')


class SystemLog:
    def __init__(self):    
        config.sections()
        config.read('config/conf.ini')



    def setup_logger(self, name, log_file, level=logging.DEBUG):
        handler = logging.FileHandler(log_file)        
        handler.setFormatter(formatter)

        logger = logging.getLogger(name)
        logger.setLevel(level)
        logger.addHandler(handler)

        return logger



    def InsertInstallationInfoLog(self, responseCode, transactionTitle, data, transactionDateTime, username, channelId, ipAddress, responseMessage):
        path=rootDir+'/switchReports/InstallationLog'
        logger = self.setup_logger('installation_logger', path+'/InstallationLog.log')
        logger.info("Response Code:" + str(responseCode) + " | Date and Time: " + str(transactionDateTime.strftime('%Y/%m/%d %H:%M:%S')) + " | Username: " + str(username) + " | Title: " + str(transactionTitle) + " | Channel ID: " + str(channelId)  + " | IP Address: " + str(ipAddress) + " | Inserted Data: " + data + " | Response Message:" + str(responseMessage))



    def InsertInstallationErrorLog(self, responseCode, transactionTitle, data, transactionDateTime, username, channelId, ipAddress, responseMessage, detail):
        path=rootDir+'/switchReports/InstallationLog'
        logger = self.setup_logger('installation_logger', path+'/InstallationLog.log')
        logger.error("Response Code:" + str(responseCode) + " | Date and Time: " + str(transactionDateTime.strftime('%Y/%m/%d %H:%M:%S')) + " | Username: " + str(username) + " | Title: " + str(transactionTitle) + " | Channel ID: " + str(channelId)  + " | IP Address: " + str(ipAddress) + " | Inserted Data: " + str(data) + " | Response Message:" + str(responseMessage) + " | Detail:" + str(detail))



    def InsertInfoLog(self, responseCode, transactionTitle, data, transactionDateTime, token, channelId, ipAddress, responseMessage):
        username = {"Username": 'guest'}
        if token != None:
            username = self.getUsernameForLog(token)
        path=rootDir+'/switchReports/'+ config['Security']['reportFolderName']+'/SystemLog'
        logger2 = self.setup_logger('system_logger', path+'/SystemLog-'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+'.log',level=logging.DEBUG)
        logger2.info("Response Code:" + str(responseCode) + " | Date and Time: " + str(transactionDateTime.strftime('%Y/%m/%d %H:%M:%S')) + " | Username: " + str(username['Username']) + " | Title: " + str(transactionTitle) + " | Channel ID: " + str(channelId)  + " | IP Address: " + ipAddress + " | Inserted Data: " + str(data) + " | Response Message:" + str(responseMessage))



    def InsertErrorLog(self, responseCode, transactionTitle, data, transactionDateTime, token, channelId, ipAddress, responseMessage, detail):
        username = {"Username": 'guest'}
        if token != None:
            username = self.getUsernameForLog(token)
        path=rootDir+'/switchReports/'+ config['Security']['reportFolderName']+'/SystemLog'
        logger2 = self.setup_logger('system_logger', path+'/SystemLog-'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+'.log',level=logging.DEBUG)
        logger2.error("Response Code:" + str(responseCode) + " | Date and Time: " + str(transactionDateTime.strftime('%Y/%m/%d %H:%M:%S')) + " | Username: " + str(username['Username']) + " | Title: " + str(transactionTitle) + " | Channel ID: " + str(channelId)  + " | IP Address: " + str(ipAddress) + " | Inserted Data: " + str(data) + " | Response Message:" + str(responseMessage) + " | Detail:" + str(detail))


    def getUsernameForLog(self, token: str):
        try:
            with orm.db_session:
                query = Tokens.select(lambda t: t.Token == token)
                mylist = list(query)
                response=""
                resp=[]
                if len(mylist) > 0:
                    query2 = Users.select(lambda u: u.UserID == mylist[0].UserID.UserID)
                    mylist2 = list(query2)
                    response = {"Username": mylist2[0].Username}
                return response
        except Exception as e:
            return None