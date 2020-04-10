import sys
import json
from models.DatabaseContext import *
from datetime import datetime
from controllers.security.SystemLog import SystemLog
from controllers.security.NetworkManagement import NetworkManagement
from controllers.security.ExceptionHandling import ExceptionHandling


systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()

class UserControl:
    def CheckToken(self, token: str, username: str, clientIp: str, channelId: str):
        try:
            with db_session:
                query = Tokens.select(lambda t: t.Token == token)
                mylist = list(query)
                response=""
                resp=[]
                if len(mylist) > 0:
                    if mylist[0].ClientIP == clientIp:
                        if mylist[0].UserID.Username == username:
                            dateDiff=(datetime.now() - mylist[0].GenerationDate).total_seconds() / 60.0
                            config = configparser.ConfigParser()
                            config.sections()
                            config.read('config/conf.ini')
                            tokenExpiration = int(config['Security']['tokenexpiration'])
                            if int(dateDiff) < tokenExpiration:
                                resp = exceptionHandling.getErrorMessage("SEC00")
                                systemLog.InsertInfoLog('00', 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', channelId, clientIp, "")
                            else:
                                resp = exceptionHandling.getErrorMessage("SEC01")
                                systemLog.InsertErrorLog('00', 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', channelId, clientIp, "", resp[0], resp[1])
                        else:
                            resp = exceptionHandling.getErrorMessage("SEC06")
                            systemLog.InsertErrorLog('00', 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', channelId, clientIp, "", resp[0], resp[1])
                    else:
                        resp = exceptionHandling.getErrorMessage("SEC05")
                        systemLog.InsertErrorLog('00', 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', channelId, clientIp, "", resp[0], resp[1])
                else:
                    resp = exceptionHandling.getErrorMessage("SEC02")
                    systemLog.InsertErrorLog('00', 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', channelId, clientIp, "", resp[0], resp[1])
                response = {"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
                return response
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            response={"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
            systemLog.InsertErrorLog('00', 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', channelId, clientIp, "", resp[0], resp[1])
            return response