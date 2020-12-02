import sys
import json
from models.DatabaseContext import *
import uuid
import hashlib
import flask
from flask_cors import CORS, cross_origin
import App
from datetime import datetime
from controllers.security.GlobalObjects import *
from controllers.security.MessageStructure import MessageStructure

systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()
isoMessageEngine = IsoMessageEngine()
userControl = UserControl()

messageStructure = MessageStructure()

class IsoServices:
    def getTransTypeList(self, header: dict, body: dict):
        try:
            roleID = userControl.getUserRoleID(header[str('token').capitalize()], networkManagement.getClientIP(), header[str('terminalId').capitalize()])
            transTypeList = isoMessageEngine.GetValidTransTypeList(roleID["RoleID"])
            json_string = '"TransTypes":'+json.dumps(transTypeList)
            return messageStructure.createJSONServiceResponse('getTransTypeList', "SEC00", None, json_string, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], True)
        except Exception as e:
            return messageStructure.createJSONServiceResponse('getTransTypeList', 'SYS500', None, None, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], False)

    

    def getServiceList(self, header: dict, body: dict):
        try:
            roleID = userControl.getUserRoleID(header[str('token').capitalize()], networkManagement.getClientIP(), header[str('terminalId').capitalize()])
            serviceList = isoMessageEngine.GetValidServiceList(roleID["RoleID"], body["transTypeCode"])
            json_string = '"Services":'+json.dumps(serviceList)
            return messageStructure.createJSONServiceResponse('getServiceList', "SEC00", None, json_string, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], True)
        except Exception as e:
            return messageStructure.createJSONServiceResponse('getServiceList', 'SYS500', None, None, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], False)



    def getRequestStructure(self, header: dict, body: dict):
        try:
            response=""
            resp = exceptionHandling.getErrorMessage("ISO00")
            bitValue = isoMessageEngine.GetBitValue(body['transTypeCode'], body['processCode'])
            bitmap = isoMessageEngine.BitValueToBitmap(bitValue)
            databaseTableName = isoMessageEngine.GetDatabaseTableName(body['transTypeCode'])
            messageJsonStructure = json.dumps(isoMessageEngine.GetJsonMessageStructure(bitValue))
            resText ='"BitValue":"' + bitValue + '", "Bitmap":"' + bitmap + '", "TableName":"' + databaseTableName + '" ,"TransTypeCode":"'+body['transTypeCode']+'", "MessageRequestStructure":'+messageJsonStructure[1:-1]
            return messageStructure.createJSONServiceResponse('getRequestStructure', "SEC00", None, resText, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], True)
        except Exception as e:
            return messageStructure.createJSONServiceResponse('getRequestStructure', "SYS500", None, None, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], False)
    

    def getResponseStructure(self, header: dict, body: dict):
        try:
            response=""
            resp = exceptionHandling.getErrorMessage("ISO00")
            respType = isoMessageEngine.GetResponseType(body['transTypeCode'])
            bitValue = isoMessageEngine.GetBitValue(respType, body['processCode'])
            bitmap = isoMessageEngine.BitValueToBitmap(bitValue)
            databaseTableName = isoMessageEngine.GetDatabaseTableName(respType)
            messageJsonStructure = json.dumps(isoMessageEngine.GetJsonMessageStructure(bitValue))
            resText ='"BitValue":"' + bitValue + '", "Bitmap":"' + bitmap + '", "TableName":"' + databaseTableName + '" ,"TransTypeCode":"'+respType+'", "MessageResponseStructure":'+ messageJsonStructure[1:-1]
            return messageStructure.createJSONServiceResponse('getResponseStructure', "SEC00", None, resText, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], True)
        except Exception as e:
            return messageStructure.createJSONServiceResponse('getResponseStructure', "SYS500", None, None, body, header[str('token').capitalize()], header[str('terminalId').capitalize()], False)