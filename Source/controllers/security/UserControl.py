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
    def CheckToken(self, token: str, clientIp: str, terminalId: str):
        try:
            with orm.db_session:
                query = Tokens.select(lambda t: t.Token == token)
                mylist = list(query)
                response=""
                resp=[]
                if len(mylist) > 0:
                    if mylist[0].ClientIP == clientIp:
                            dateDiff=(datetime.now() - mylist[0].GenerationDate).total_seconds() / 60.0
                            config = configparser.ConfigParser()
                            config.sections()
                            config.read('config/conf.ini')
                            tokenExpiration = int(config['Security']['tokenexpiration'])
                            if int(dateDiff) < tokenExpiration:
                                resp = exceptionHandling.getErrorMessage("SEC00")
                                systemLog.InsertInfoLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', terminalId, clientIp, resp[1])
                            else:
                                resp = exceptionHandling.getErrorMessage("SEC01")
                                systemLog.InsertErrorLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', terminalId, clientIp, resp[1])
                    else:
                        resp = exceptionHandling.getErrorMessage("SEC05")
                        systemLog.InsertErrorLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', terminalId, clientIp, resp[1])
                else:
                    resp = exceptionHandling.getErrorMessage("SEC02")
                    systemLog.InsertErrorLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', terminalId, clientIp, resp[1])
                response = {"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
                return response
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            response={"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
            systemLog.InsertErrorLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), 'unknown', terminalId, clientIp, resp[1])
            return response

    
    def getUserRoleID(self, token: str, clientIp: str, terminalId: str):
        try:
            with orm.db_session:
                query = Tokens.select(lambda t: t.Token == token)
                mylist = list(query)
                response=""
                resp=[]
                if len(mylist) > 0:
                    query2 = Users.select(lambda u: u.UserID == mylist[0].UserID.UserID)
                    mylist2 = list(query2)
                    response = {"RoleID": mylist2[0].RoleID.RoleID}
                resp = exceptionHandling.getErrorMessage("SEC00")
                systemLog.InsertInfoLog(resp[0], 'getUserRoleID', '{"token":"'+token+'" }', datetime.now(), 'unknown', terminalId, clientIp, "")
                return response
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            response={"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
            systemLog.InsertErrorLog(resp[0], 'getUserRoleID', '{"token":"'+token+'" }', datetime.now(), 'unknown', terminalId, clientIp, "", resp[0], resp[1])
            return response