import sys
from flask import Flask, request, jsonify
from flask_cors import CORS, cross_origin
import flask
from models.DatabaseContext import *
from datetime import datetime
from controllers.security.GlobalObjects import *


global app
app = Flask(__name__)
app.config.from_object(__name__)
CORS(app, support_credentials=True)

systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()
userControl = UserControl()

userServices = UserServices()
isoServices = IsoServices()

objects={}
objects['UserServices'] = userServices
objects['IsoServices'] = isoServices

@app.route('/<object_name>/<function_name>', methods=['GET', 'POST', 'PUT'])
@cross_origin(supports_credentials=True)
def call_function(object_name: str, function_name: str):
    with orm.db_session:
        terminalId = request.headers[str('terminalId').capitalize()]
        query = Terminals.select(lambda t: t.TerminalCode == terminalId)
        mylist = list(query)
        clientIp = networkManagement.getClientIP()
        
        if len(mylist) > 0:
            if mylist[0].ChannelTypeID.IsTokenRequired:
                if function_name != "getToken" or object_name != "UserServices":
                    tokenCheckingCode = userControl.CheckToken(request.headers[str('token').capitalize()], networkManagement.getClientIP(), request.headers[str('terminalId').capitalize()])
                    resp = exceptionHandling.getErrorMessage(tokenCheckingCode["RetCode"])
                    
                    if tokenCheckingCode["RetCode"] =="SEC00":
                        systemLog.InsertInfoLog(resp[0], 'call_function', '{}', datetime.now(), 'unknown', request.headers[str('terminalId').capitalize()], clientIp, resp[1])
                    else:
                        response = flask.Response('{"RetCode":"'+resp[0]+'", "RetMsg":"'+resp[1]+'", "RetMsgFa":"'+resp[2]+'"}')
                        response.headers["TransDateTime"] = str(datetime.now())
                        response.headers["TransDate"] = str(datetime.date(datetime.now()))
                        response.headers["TransTime"] = str(datetime.time(datetime.now()))
                        systemLog.InsertErrorLog(resp[0], 'call_function', '{}', datetime.now(), 'unknown', request.headers[str('terminalId').capitalize()], clientIp, resp[1])
                        return response


            if mylist[0].IPAddress != clientIp:
                resp = exceptionHandling.getErrorMessage("SEC07")
                response = flask.Response('{"RetCode":"'+resp[0]+'", "RetMsg":"'+resp[1]+'", "RetMsgFa":"'+resp[2]+'"}')
                systemLog.InsertErrorLog(resp[0], 'call_function', '{}', datetime.now(), 'unknown', request.headers[str('terminalId').capitalize()], clientIp, "", resp[0], resp[1])
                return response
        else:
            resp = exceptionHandling.getErrorMessage("SEC08")
            response = flask.Response('{"RetCode":"'+resp[0]+'", "RetMsg":"'+resp[1]+'", "RetMsgFa":"'+resp[2]+'"}')
            systemLog.InsertErrorLog(resp[0], 'call_function', '{}', datetime.now(), 'unknown', request.headers[str('terminalId').capitalize()], clientIp, "", resp[0], resp[1])
            return response


    header={}
    if len(request.headers) > 0:
        for param in request.headers:
            p = param
            header[p[0]]=p[1]
    params = request.data.decode("utf-8").split('&')
    body={}
    if len(params) > 0 and params[0] != "":
        for param in params:
            p = param.split('=')
            body[p[0]]=p[1]
    function_to_call = getattr(objects[object_name], function_name)
    return function_to_call(header, body)
