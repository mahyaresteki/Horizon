from flask import request
from flask import jsonify
import socket
import getpass

class NetworkManagement:
    def getClientIP(self):
        return request.remote_addr

    def getHostIP(self):
        hostName = socket.gethostname() 
        hostIp = socket.gethostbyname(hostName)
        return hostIp
    
    def getHostName(self):
        hostName = socket.gethostname()
        return hostName

    def getHostUsername(self):
        username = getpass.getuser()
        return username
