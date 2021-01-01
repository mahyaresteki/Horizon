import sys, os
import json
from models.DatabaseContext import *
from datetime import datetime
from controllers.struc.GlobalObjects import *
import hashlib
import uuid


systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()

class UserService:
    def getToken(self, username: str, password: str, terminalId: str, clientIp: str):
        try:
            with orm.db_session:
                passwordhash = hashlib.sha512(str(password).encode('utf-8')).hexdigest()
                query = Users.select(lambda u: u.Username == str(username) and u.Password == str(passwordhash))
                mylist = list(query)
                response=""
                if len(mylist) > 0:
                    if mylist[0].IsActive :
                        token=uuid.uuid4().hex
                        tokens = Tokens(Token = token, UserID = mylist[0].UserID, GenerationDate = datetime.now(), ClientIP = clientIp)
                        orm.commit()
                        resp = exceptionHandling.getErrorMessage('SEC00')
                        response = {"token":token, "RetCode":resp[0], "RetMsg":resp[1], "RetMsgFa":resp[2]}
                        systemLog.InsertInfoLog(resp[0], 'getToken', '{"username":"'+username+'"","password":"'+password+'"}', datetime.now(), token, terminalId, clientIp, resp[1])
                    else:
                        resp = exceptionHandling.getErrorMessage('SEC03')
                        response = {"RetCode":resp[0], "RetMsg":resp[1], "RetMsgFa":resp[2]}
                        systemLog.InsertErrorLog(resp[0], 'getToken', '{"username":"'+username+'"","password":"'+password+'"}', datetime.now(), None, terminalId, clientIp, resp[1], None)
                else:
                    resp = exceptionHandling.getErrorMessage('SEC04')
                    response = {"RetCode":resp[0], "RetMsg":resp[1], "RetMsgFa":resp[2]}
                    systemLog.InsertErrorLog(resp[0], 'getToken', '{"username":"'+username+'"","password":"'+password+'"}', datetime.now(), None, terminalId, clientIp, resp[1], None)
                return response
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            error = str(e)+"-(Filename:"+str(fname)+", LineNo:"+str(exc_tb.tb_lineno)+")"
            resp = exceptionHandling.getErrorMessage('SYS500')
            response = {"RetCode":resp[0], "RetMsg":resp[1], "RetMsgFa":resp[2]}
            systemLog.InsertErrorLog(resp[0], 'getToken', '{"username":"'+username+'"","password":"'+password+'"}', datetime.now(), None, terminalId, clientIp, resp[1], error)
            return response



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
                                systemLog.InsertInfoLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1])
                            else:
                                resp = exceptionHandling.getErrorMessage("SEC01")
                                systemLog.InsertErrorLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1], None)
                    else:
                        resp = exceptionHandling.getErrorMessage("SEC05")
                        systemLog.InsertErrorLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1], None)
                else:
                    resp = exceptionHandling.getErrorMessage("SEC02")
                    systemLog.InsertErrorLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1], None)
                response = {"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
                return response
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            error = str(e)+"-(Filename:"+str(fname)+", LineNo:"+str(exc_tb.tb_lineno)+")"
            resp = exceptionHandling.getErrorMessage("SYS500")
            response={"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
            systemLog.InsertErrorLog(resp[0], 'CheckToken', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1], error)
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
                systemLog.InsertInfoLog(resp[0], 'getUserRoleID', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1])
                return response
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            error = str(e)+"-(Filename:"+str(fname)+", LineNo:"+str(exc_tb.tb_lineno)+")"
            resp = exceptionHandling.getErrorMessage("SYS500")
            response={"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
            systemLog.InsertErrorLog(resp[0], 'getUserRoleID', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1], error)
            return response



    def checkAdministrativePermission(self, token: str, serviceTitle: str, clientIp: str, terminalId: str):
        try:
            with orm.db_session:
                userRoleID = self.getUserRoleID(token, clientIp, terminalId)
                query = AdministrativeRoleAccesses.select(lambda u: u.RoleID.RoleID == int(userRoleID["RoleID"]) and u.AdministrativeServiceID.ServiceTitle == serviceTitle)
                mylist = list(query)
                response=""
                resp=[]
                if len(mylist) > 0:
                    response = {"RoleAccess": True, "RoleID": mylist[0].RoleID.RoleID, "ServiceID": mylist[0].AdministrativeServiceID.AdministrativeServiceID}
                else:
                    response = {"RoleAccess": False, "RoleID": '', "ServiceID": ''}
                resp = exceptionHandling.getErrorMessage("SEC00")
                systemLog.InsertInfoLog(resp[0], 'checkAdministrativePermission', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1])
                return response
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            error = str(e)+"-(Filename:"+str(fname)+", LineNo:"+str(exc_tb.tb_lineno)+")"
            resp = exceptionHandling.getErrorMessage("SYS500")
            response={"RetCode": resp[0], "RetMsg": resp[1], "RetMsgFa": resp[2]}
            systemLog.InsertErrorLog(resp[0], 'checkAdministrativePermission', '{"token":"'+token+'" }', datetime.now(), token, terminalId, clientIp, resp[1], error)
            return response