import sys
import random, json
from psycopg2 import connect
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import pymysql
from flask import *
from flask_cors import CORS, cross_origin
from App import *
from models.DatabaseContext import *
import hashlib
import configparser
from datetime import datetime
from controllers.security.SystemLog import SystemLog
from controllers.security.NetworkManagement import NetworkManagement
from controllers.security.ExceptionHandling import ExceptionHandling
import getpass
import os
from datetime import datetime

systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()

class SystemPrepration:
    config = configparser.ConfigParser()
    host = ''
    provider = ''
    database = ''
    username = ''

    def __init__(self):    
        config.sections()
        config.read('config/conf.ini')


    def SetWebServer(self):
        print('Application Installation Step')
        print('==================================')
        server = input('Please insert server IP address: ')
        port = input('Please insert port number: ')
        config.set('DEFAULT', 'server', server)
        config.set('DEFAULT', 'port', port)
        try:
            with open('config/conf.ini', 'w') as configfile:
                config.write(configfile)
                response = exceptionHandling.getErrorMessage("SYS00")
                systemLog.InsertInfoLog('00', 'Database Prepration', '{"server":"' + server + '","port":"' + port + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+str(response[1].encode("utf-8")))
                print('Application is installed successfully!\n')
        except Exception as e:
            response = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertErrorLog('00', 'Database Prepration', '{"server":"' + server + '","port":"' + port + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+str(response[1].encode("utf-8")), str(response[0]), str(response[1]))


    def SetDatabase(self):
        print('Database Installation Step')
        print('==================================')
        self.host = input('Please insert host IP address: ')
        self.provider = input('Please insert provider: ')
        self.database = input('Please insert database name: ')
        self.username = input('Please insert username: ')
        self.password = getpass.getpass(prompt='Please insert password: ')
        try:
            if str(self.provider) == 'postgres':
                con = connect(dbname='postgres', user=str(self.username), host=str(self.host), password=str(self.password))
                con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
                cur = con.cursor()
                cur.execute('CREATE DATABASE ' + str(self.database).lower())
                cur.close()
                con.close()
            elif str(self.provider) == 'mysql':
                conn = pymysql.connect(host=str(self.host), user=str(self.username), password=str(self.password))
                conn.cursor().execute('create database '+str(self.database))
                conn.close()
            config.set('ConnectionString', 'provider', self.provider)
            config.set('ConnectionString', 'host', self.host)
            config.set('ConnectionString', 'database', self.database)
            config.set('ConnectionString', 'user', self.username)
            config.set('ConnectionString', 'password', self.password)
            with open('config/conf.ini', 'w') as configfile:
                config.write(configfile)
            db.bind(provider=config['ConnectionString']['provider'], user=config['ConnectionString']['user'], password=config['ConnectionString']['password'], host=config['ConnectionString']['host'], database=config['ConnectionString']['database'])
            db.generate_mapping(create_tables=True)
            response = exceptionHandling.getErrorMessage("SYS00")
            systemLog.InsertInfoLog('00', 'Database Prepration', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+str(response[2].encode("utf-8")))
            print('Database is created successfully!\n')
            self.InitData()
            self.SetAdministrator()
            self.ImportIntegrationData()
        except Exception as e:
            response = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertErrorLog('00', 'Database Prepration', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: ' + str(response[2].encode("utf-8")), str(response[0]), str(response[1]))


    def InitData(self):
        print('Data Initialization')
        print('==================================')
        try:
            if str(self.provider) == 'postgres':
                con = connect(dbname=str(self.database), user=str(self.username), host=str(self.host), password=str(self.password))
                con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
                cur = con.cursor()
                sql_file = open('resources/initialData/settingData.sql','r')
                cur.execute(sql_file.read())
                cur.close()
                con.close()
            elif str(self.provider == 'mysql'):
                conn = pymysql.connect(host=str(self.host), user=str(self.username), password=str(self.password))
                sql_file = open('resources/initialData/settingData.sql','r')
                conn.cursor().execute(sql_file.read())
                conn.close()
            response = exceptionHandling.getErrorMessage("SYS00")
            systemLog.InsertInfoLog('00', 'Data Initialization', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+str(response[2].encode("utf-8")))
            print('Data is initialized successfully!\n')
        except Exception as e:
            response = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertErrorLog('00', 'Data Initialization', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: ' + str(response[2].encode("utf-8")), str(response[0]), str(response[1]))


    def ImportIntegrationData(self):
        print('Data Integration')
        print('==================================')
        try:
            reply = str(input('Do you want to perform integration data process?(y/n): ')).lower().strip()
            if reply[0] == 'y':
                if str(self.provider) == 'postgres':
                    con = connect(dbname=str(self.database), user=str(self.username), host=str(self.host), password=str(self.password))
                    con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
                    cur = con.cursor()
                    sql_file = open('resources/initialData/integrationData.sql','r')
                    cur.execute(sql_file.read())
                    cur.close()
                    con.close()
                elif str(self.provider == 'mysql'):
                    conn = pymysql.connect(host=str(self.host), user=str(self.username), password=str(self.password))
                    sql_file = open('resources/initialData/integrationData.sql','r')
                    conn.cursor().execute(sql_file.read())
                    conn.close()
                response = exceptionHandling.getErrorMessage("SYS00")
                systemLog.InsertInfoLog('00', 'Data Integration', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+str(response[2].encode("utf-8")))
                print('Data integration is done successfully!\n')
            else:
                print('Data integration is ignored...')
        except Exception as e:
            response = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertErrorLog('00', 'Data Integration', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: ' + str(response[2].encode("utf-8")), str(response[0]), str(response[1]))


    def SetAdministrator(self):
        print('Set Administrator Information')
        print('==================================')
        firstName = input('Please insert first name: ')
        lastName = input('Please insert last name: ')
        personalCode = input('Please insert personal code: ')
        username = input('Please insert username: ')
        password = getpass.getpass(prompt='Please insert password: ')
        try:
            with orm.db_session:
                encryptedPassword = hashlib.sha512(str(password).encode('utf-8')).hexdigest()
                role = list(Roles.select(lambda r: r.RoleTitle == 'Administrator'))[0]
                Users(FirstName = str(firstName), LastName =str(lastName), Username=str(username), Password=encryptedPassword, RoleID=role.RoleID, PersonelCode=str(personalCode), IsActive=True, LatestUpdateDate = datetime.now() )
                response = exceptionHandling.getErrorMessage("SYS00")
                systemLog.InsertInfoLog('00', 'Set Administrator', '{"firstName":"' + firstName + '","lastName":"' + lastName + '","personalCode":"' + personalCode + '","username":"' + username + '","password":"' + password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+str(response[2].encode("utf-8")))
                print('Administrator is created successfully!\n')
        except Exception as e:
            response = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertErrorLog('00', 'Set Administrator', '{"firstName":"' + firstName + '","lastName":"' + lastName + '","personalCode":"' + personalCode + '","username":"' + username + '","password":"' + password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: ' + str(response[2].encode("utf-8")), str(response[0]), str(response[1]))

    def CreateReportFolder(self):
        print('Creating Report Folder')
        print('==================================')
        path=app.root_path+'/switchReports/'+ config['Security']['reportFolderName']+'/'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+"/"
        if os.path.exists(path) == False:
            os.makedirs(path)
            print('Switch Report folder for current date is created successfully!\n')
        else:
            print('Switch Report folder for current date is already exists!\n')
        
        path=app.root_path+'/switchReports/'+ config['Security']['reportFolderName']+'/'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+"/InternalDebitCard"
        if os.path.exists(path) == False:
            os.makedirs(path)
            print('Internal debit cards log folder is created successfully!\n')
        else:
            print('Internal debit cards log folder for current date is already exists!\n')

        path3=app.root_path+'/switchReports/'+ config['Security']['reportFolderName']+'/'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+"/OttherBanksDebitCard"
        if os.path.exists(path) == False:
            os.makedirs(path)
            print('Other banks debit cards log folder is created successfully!\n')
        else:
            print('Other banks debit cards log folder for current date is already exists!\n')
