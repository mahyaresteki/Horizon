from xml.dom import minidom
import configparser
import json

isoFieldMapping = minidom.parse('resources/mappings/isoFieldMapping.xml')
isoTransactionTypesMapping = minidom.parse('resources/mappings/isoTransactionTypesMapping.xml')

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
    def BitmapToHex(self, bitmap):
        i = 0
        hexmap=""
        while i < len(bitmap):
            bpart = bitmap[i:i+4]
            for hexChar, bit in hexDict.items():
                if bit == bpart:
                    hexmap+=hexChar
                    break
            i+=4    
        return hexmap


    def HexToBitmap(self, hexmap):
        bitmap=""
        for c in hexmap:
            bitmap+=hexDict[c]
        return bitmap

    def GetBitmap(self, transTypeCode):
        config = configparser.ConfigParser()
        config.sections()
        config.read('config/conf.ini')
        bitmap = str(config['Bitmaps'][transTypeCode])
        return bitmap

    def GetDatabaseTableName(self, transTypeCode):
        itemlist1 = isoTransactionTypesMapping.getElementsByTagName('TransactionType')
        tableName = ""
        for s in itemlist1:
            if s.getElementsByTagName('IsoMessageType')[0].childNodes[0].nodeValue == transTypeCode:
                tableName = s.getElementsByTagName('DbTableName')[0].childNodes[0].nodeValue
                break
        return tableName


    def GetFeildsDictionary(self, bitmap):
        i= 1
        itemlist2 = isoFieldMapping.getElementsByTagName('Field')
        fieldDictionary = {}
        for c in bitmap:
            for s in itemlist2:
                if i == int(s.getElementsByTagName('IsoField')[0].childNodes[0].nodeValue):
                    if c == '1':
                        fieldDictionary.update( {s.getElementsByTagName('JsonField')[0].childNodes[0].nodeValue : s.getElementsByTagName('DatabaseField')[0].childNodes[0].nodeValue} )
                    break
                else:
                    continue
            i+=1
        return fieldDictionary


    def GetJsonMessageStructure(self, bitmap):
        i= 1
        myJson = [{"head":{},"body":{}}]
        itemlist2 = isoFieldMapping.getElementsByTagName('Field')
        for c in bitmap:
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

