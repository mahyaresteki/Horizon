import sys
import json
from models.DatabaseContext import *
import uuid
import hashlib
import flask
from flask_cors import CORS, cross_origin
import App
from datetime import datetime
from controllers.security.SystemLog import SystemLog
from controllers.security.NetworkManagement import NetworkManagement
from controllers.security.ExceptionHandling import ExceptionHandling
from controllers.switch.IsoMessageEngine import IsoMessageEngine

systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()
isoMessageEngine = IsoMessageEngine()

class IsoServices:
    def getBitmap(self, header: dict, body: dict):
        try:
            response=""
            resp = exceptionHandling.getErrorMessage("ISO00")
            bitmap = isoMessageEngine.GetBitmap(header[str('transTypeCode').capitalize()])
            response = flask.Response('{"Bitmap":"' + bitmap + '", "RetCode":"'+ resp[0]+ '", "RetMsg":"' + resp[1] + '", "RetMsgFa":"' + str(resp[2]) + '"}')
            response.headers["TransDateTime"] = str(datetime.now())
            response.headers["TransDate"] = str(datetime.date(datetime.now()))
            response.headers["TransTime"] = str(datetime.time(datetime.now()))
            systemLog.InsertInfoLog(resp[0], 'GetBitmap', str(body), datetime.now(), str(body["username"]), str(header[str('channelId').capitalize()]), networkManagement.getClientIP(), "")
            return response
        except Exception as e:
            resp = exceptionHandling.getErrorMessage('SYS500')
            response = flask.Response('{"RetCode":"'+resp[0]+'", "RetMsg":"'+resp[1]+'", "RetMsgFa":"'+resp[2]+'"}')
            response.headers["TransDateTime"] = str(datetime.now())
            response.headers["TransDate"] = str(datetime.date(datetime.now()))
            response.headers["TransTime"] = str(datetime.time(datetime.now()))
            systemLog.InsertErrorLog(resp[0], 'GetBitmap', str(body), datetime.now(), str(body["username"]), str(header[str('channelId').capitalize()]), networkManagement.getClientIP(), ""), resp[0], resp[1]
            return response