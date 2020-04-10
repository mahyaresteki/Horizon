import sys
import json
import xml.etree.ElementTree as ET
from models.DatabaseContext import *
from datetime import datetime
from controllers.security.SystemLog import SystemLog
from controllers.security.NetworkManagement import NetworkManagement

errorLists={}
errorLists['SEC'] = 'resources/exceptionMessages/security.xml'
errorLists['ISO'] = 'resources/exceptionMessages/iso.xml'
errorLists['SYS'] = 'resources/exceptionMessages/system.xml'
errorLists['VAS'] = 'resources/exceptionMessages/vas.xml'

class ExceptionHandling:
    def getErrorMessage(self, code: str):
        mydoc = ET.parse(errorLists[code[0:3]]) 
        errorMessages = mydoc.getroot()
        response = ""
        for errorMessage in errorMessages:
            if errorMessage[0].text == code:
                response=[errorMessage[0].text, errorMessage[1].text, errorMessage[2].text]
                break
        return response