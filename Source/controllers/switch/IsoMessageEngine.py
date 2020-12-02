from xml.dom import minidom
import configparser
import json
from models.DatabaseContext import *
from datetime import datetime

isoFieldMapping = minidom.parse('resources/mappings/isoFieldMapping.xml')

hexDict =	{
  "0": "0000",
  "1": "0001",
  "2": "0010",
  "3": "0011",
  "4": "0100",
  "5": "0101",
  "6": "0110",
  "7": "0111",
  "8": "1000",
  "9": "1001",
  "A": "1010",
  "B": "1011",
  "C": "1100",
  "D": "1101",
  "E": "1110",
  "F": "1111"
}

class IsoMessageEngine:
    def BitValueToBitmap(self, bitValue):
        i = 0
        bitmap=""
        while i < len(bitValue):
            bpart = bitValue[i:i+4]
            for hexChar, bit in hexDict.items():
                if bit == bpart:
                    bitmap+=hexChar
                    break
            i+=4    
        return bitmap


    def BitmapToBitValue(self, bitmap):
        bitValue=""
        for c in bitmap:
            bitValue+=hexDict[c]
        return bitValue


    def GetBitValue(self, transTypeCode, processCode):
        bitValue = ''
        with orm.db_session:
            query = list(TransServices.select(lambda t: t.TransTypeID.TransTypeCode == str(transTypeCode) and t.ServiceID.ProcessCode == str(processCode)))
            if len(query) > 0:
               bitValue = query[0].BitValue
        return bitValue


    def GetDatabaseTableName(self, transTypeCode):
        tableName = ""
        with orm.db_session:
            query = list(TransTypes.select(lambda t: t.TransTypeCode == str(transTypeCode)))
            if len(query) > 0:
               tableName = query[0].DbTableName
        return tableName


    def GetResponseType(self, transTypeCode):
        respType = ""
        with orm.db_session:
            query = list(TransRequestResponseMapping.select(lambda t: t.RequestID.TransTypeCode == str(transTypeCode)))
            if len(query) > 0:
               respType = query[0].ResponseID.TransTypeCode
        return respType


    def GetValidTransTypeList(self, roleID):
        tansTypeList = list()
        with orm.db_session:
            query = list(orm.select(r.TransServiceID.TransTypeID.TransTypeID for r in RoleAccesses if r.RoleID.RoleID == roleID))
            query2 = list(orm.select(r.RequestID.TransTypeID for r in TransRequestResponseMapping if r.RequestID.TransTypeID in(query)))
            query3 = list(orm.select(tt for tt in TransTypes if tt.TransTypeID in(query2) ))
            for c in query3:
                tansTypeList.append({"TransTypeCode": c.TransTypeCode, "TransTypeTitle": c.TransTypeTitle})
        return tansTypeList



    def GetValidServiceList(self, roleID, transTypeCode):
        serviceList = list()
        with orm.db_session:
            query = list(orm.select(r.TransServiceID.ServiceID.ServiceID for r in RoleAccesses if r.RoleID.RoleID == roleID and r.TransServiceID.TransTypeID.TransTypeCode == transTypeCode))
            query2 = list(orm.select(s for s in Services if s.ServiceID in(query) ))
            for c in query2:
                serviceList.append({"ProcessCode": c.ProcessCode, "ServiceTitle": c.ServiceTitle})
        return serviceList



    def GetFeildsDictionary(self, bitValue):
        i= 1
        itemlist2 = isoFieldMapping.getElementsByTagName('Field')
        fieldDictionary = {}
        for c in bitValue:
            for s in itemlist2:
                if i == int(s.getElementsByTagName('IsoField')[0].childNodes[0].nodeValue):
                    if c == '1':
                        fieldDictionary.update( {s.getElementsByTagName('JsonField')[0].childNodes[0].nodeValue : s.getElementsByTagName('DatabaseField')[0].childNodes[0].nodeValue} )
                    break
                else:
                    continue
            i+=1
        return fieldDictionary


    def GetJsonMessageStructure(self, bitValue):
        i= 1
        myJson = [{"head":{},"body":{}}]
        itemlist2 = isoFieldMapping.getElementsByTagName('Field')
        for c in bitValue:
            for s in itemlist2:
                if i == int(s.getElementsByTagName('IsoField')[0].childNodes[0].nodeValue):
                    if c == '1':
                        if s.getElementsByTagName('JsonField')[0].getAttribute('jsonPart') == 'head':
                            myJson[0]['head'][s.getElementsByTagName('JsonField')[0].childNodes[0].nodeValue]=''
                        elif s.getElementsByTagName('JsonField')[0].getAttribute('jsonPart') == 'body':
                            myJson[0]['body'][s.getElementsByTagName('JsonField')[0].childNodes[0].nodeValue]=''
                        else:
                            myJson[0][s.getElementsByTagName('JsonField')[0].childNodes[0].nodeValue]=''
                    break
                else:
                    continue
            i+=1
        return myJson

