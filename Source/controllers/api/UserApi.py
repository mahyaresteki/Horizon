import sys, os
import json
from models.DatabaseContext import *
import flask
from flask_cors import CORS, cross_origin
import App
from flask import jsonify
from datetime import datetime
from controllers.struc.GlobalObjects import *
from controllers.struc.MessageStructure import MessageStructure

userService = UserService()
systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()
messageStructure = MessageStructure()

class UserApi:
    def getToken(self, header: dict, body: dict):
        try:
            with orm.db_session:
                username = str(body['username'])
                password = str(body['password'])
                terminalId = str(header[str('terminalId').capitalize()])
                clientIp = networkManagement.getClientIP()
                head = userService.getToken(username, password, terminalId, clientIp)
                return messageStructure.createJSONServiceResponse('getToken', head['RetCode'], None, '"token": "'+head['token']+'"', body, head['token'], terminalId, True, None)
        except Exception as e:
            terminalId = str(header[str('terminalId').capitalize()])
            clientIp = networkManagement.getClientIP()
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            error = str(e)+"-(Filename:"+str(fname)+", LineNo:"+str(exc_tb.tb_lineno)+")"
            return messageStructure.createJSONServiceResponse('getToken', 'SYS500', None, None, body, None, terminalId, False, error)