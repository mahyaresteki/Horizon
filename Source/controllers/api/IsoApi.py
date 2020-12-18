import sys
import json
from models.DatabaseContext import *
import uuid
import hashlib
import flask
from flask_cors import CORS, cross_origin
import App
from datetime import datetime
from controllers.struc.GlobalObjects import *
from controllers.struc.MessageStructure import MessageStructure

systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()
isoService = IsoService()
userService = UserService()

messageStructure = MessageStructure()

class IsoApi:
    def getTransTypeList(self, header: dict, body: dict):
        try:
            roleID = userService.getUserRoleID(header[str('token').capitalize()], networkManagement.getClientIP(), header[str('terminalId').capitalize()])
            transTypeList = isoService.GetValidTransTypeList(roleID["RoleID"])
            json_string = '"TransTypes":'+json.dumps(transTypeList)
            return messageStructure.createJSONServiceResponse('getTransTypeList', "SEC00", None, json_string, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], True, None)
        except Exception as e:
            return messageStructure.createJSONServiceResponse('getTransTypeList', 'SYS500', None, None, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], False, str(e))

    

    def getIsoServiceList(self, header: dict, body: dict):
        try:
            roleID = userService.getUserRoleID(header[str('token').capitalize()], networkManagement.getClientIP(), header[str('terminalId').capitalize()])
            serviceList = isoService.GetValidIsoServiceList(roleID["RoleID"], body["transTypeCode"])
            json_string = '"Services":'+json.dumps(serviceList)
            return messageStructure.createJSONServiceResponse('getServiceList', "SEC00", None, json_string, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], True, None)
        except Exception as e:
            return messageStructure.createJSONServiceResponse('getServiceList', 'SYS500', None, None, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], False, str(e))



    def getRequestStructure(self, header: dict, body: dict):
        try:
            response=""
            resp = exceptionHandling.getErrorMessage("ISO00")
            bitValue = isoService.GetBitValue(body['transTypeCode'], body['processCode'])
            bitmap = isoService.BitValueToBitmap(bitValue)
            databaseTableName = isoService.GetDatabaseTableName(body['transTypeCode'])
            messageJsonStructure = json.dumps(isoService.GetJsonMessageStructure(bitValue))
            resText ='"BitValue":"' + bitValue + '", "Bitmap":"' + bitmap + '", "TableName":"' + databaseTableName + '" ,"TransTypeCode":"'+body['transTypeCode']+'", "MessageRequestStructure":'+messageJsonStructure[1:-1]
            return messageStructure.createJSONServiceResponse('getRequestStructure', "SEC00", None, resText, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], True, None)
        except Exception as e:
            return messageStructure.createJSONServiceResponse('getRequestStructure', "SYS500", None, None, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], False, str(e))
    

    def getResponseStructure(self, header: dict, body: dict):
        try:
            response=""
            resp = exceptionHandling.getErrorMessage("ISO00")
            respType = isoService.GetResponseType(body['transTypeCode'])
            bitValue = isoService.GetBitValue(respType, body['processCode'])
            bitmap = isoService.BitValueToBitmap(bitValue)
            databaseTableName = isoService.GetDatabaseTableName(respType)
            messageJsonStructure = json.dumps(isoService.GetJsonMessageStructure(bitValue))
            resText ='"BitValue":"' + bitValue + '", "Bitmap":"' + bitmap + '", "TableName":"' + databaseTableName + '" ,"TransTypeCode":"'+respType+'", "MessageResponseStructure":'+ messageJsonStructure[1:-1]
            return messageStructure.createJSONServiceResponse('getResponseStructure', "SEC00", None, resText, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], True, None)
        except Exception as e:
            return messageStructure.createJSONServiceResponse('getResponseStructure', "SYS500", None, None, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], False, str(e))