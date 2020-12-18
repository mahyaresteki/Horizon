import sys
import json
from models.DatabaseContext import *
import flask
from flask_cors import CORS, cross_origin
import App
from datetime import datetime
from controllers.struc.GlobalObjects import *

systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()

class MessageStructure:
    def createJSONServiceResponse(self, functionName, resultCode, headerCustomResponseParameter, bodyCustomResponseParameter, requestBody, token, terminalId, IsSuccess, messageDetail):
        resp = exceptionHandling.getErrorMessage(resultCode)
        responsebody = '{"ResultCode":"'+resp[0]+'", "ResultMessage":"'+resp[1]+'", "ResultFarsiMessage":"'+resp[2]+'"'
        if bodyCustomResponseParameter != None:
            responsebody += ', '+ bodyCustomResponseParameter +'}'
        response = flask.Response(responsebody)
        response.headers["ResponseDateTime"] = str(datetime.now())
        response.headers["ResponseDate"] = str(datetime.date(datetime.now()))
        response.headers["ResponseTime"] = str(datetime.time(datetime.now()))
        if IsSuccess == True:
            systemLog.InsertInfoLog(resp[0], functionName, str(requestBody), datetime.now(), str(token), str(terminalId), networkManagement.getClientIP(), resp[1])
        else:
            systemLog.InsertErrorLog(resp[0], functionName, str(requestBody), datetime.now(), str(token), str(terminalId), networkManagement.getClientIP(), resp[1], messageDetail)
        return response