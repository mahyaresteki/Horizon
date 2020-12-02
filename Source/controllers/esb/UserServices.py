import sys
import json
from models.DatabaseContext import *
import uuid
import hashlib
import flask
from flask_cors import CORS, cross_origin
import App
from flask import jsonify
from datetime import datetime
from controllers.security.SystemLog import SystemLog
from controllers.security.NetworkManagement import NetworkManagement
from controllers.security.ExceptionHandling import ExceptionHandling

systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()

class UserServices:
    def getToken(self, header: dict, body: dict):
        try:
            with orm.db_session:
                username = str(body['username'])
                password = hashlib.sha512(str(body['password']).encode('utf-8')).hexdigest()
                query = Users.select(lambda u: u.Username == str(username) and u.Password == str(password))
                mylist = list(query)
                response=""
                if len(mylist) > 0:
                    if mylist[0].IsActive :
                        token=uuid.uuid4().hex
                        tokens = Tokens(Token = token, UserID = mylist[0].UserID, GenerationDate = datetime.now(), ClientIP = networkManagement.getClientIP())
                        orm.commit()
                        resp = exceptionHandling.getErrorMessage('SEC00')
                        response = flask.Response('{"token":"' + token + '", "RetCode":"'+resp[0]+'", "RetMsg":"'+resp[1]+'", "RetMsgFa":"'+resp[2]+'"}')
                        systemLog.InsertInfoLog(resp[0], 'Logging', str(body), datetime.now(), str(body["username"]), str(header[str('terminalId').capitalize()]), networkManagement.getClientIP(), resp[1])
                    else:
                        resp = exceptionHandling.getErrorMessage('SEC03')
                        response = flask.Response('{"RetCode":"'+resp[0]+'", "RetMsg":"'+resp[1]+'", "RetMsgFa":"'+resp[2]+'"}')
                        systemLog.InsertErrorLog(resp[0], 'Logging', str(body), datetime.now(), str(body["username"]), str(header[str('terminalId').capitalize()]), networkManagement.getClientIP(), resp[1])
                else:
                    resp = exceptionHandling.getErrorMessage('SEC04')
                    response = flask.Response('{"RetCode":"'+resp[0]+'", "RetMsg":"'+resp[1]+'", "RetMsgFa":"'+resp[2]+'"}')
                    systemLog.InsertErrorLog(resp[0], 'Logging', str(body), datetime.now(), str(body["username"]), str(header[str('terminalId').capitalize()]), networkManagement.getClientIP(), resp[1])
                response.headers["TransDateTime"] = str(datetime.now())
                response.headers["TransDate"] = str(datetime.date(datetime.now()))
                response.headers["TransTime"] = str(datetime.time(datetime.now()))
                return response
        except Exception as e:
            resp = exceptionHandling.getErrorMessage('SYS500')
            response = flask.Response('{"RetCode":"'+resp[0]+'", "RetMsg":"'+resp[1]+'", "RetMsgFa":"'+resp[2]+'"}')
            response.headers["TransDateTime"] = str(datetime.now())
            response.headers["TransDate"] = str(datetime.date(datetime.now()))
            response.headers["TransTime"] = str(datetime.time(datetime.now()))
            systemLog.InsertErrorLog(resp[0], 'Logging', str(body), datetime.now(), str(body["username"]), str(header[str('terminalId').capitalize()]), networkManagement.getClientIP(), resp[1])
            return response