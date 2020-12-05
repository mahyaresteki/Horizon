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
        try:
            config.set('DEFAULT', 'server', server)
            config.set('DEFAULT', 'port', port)
            with open('config/conf.ini', 'w') as configfile:
                config.write(configfile)
                resp = exceptionHandling.getErrorMessage("SYS00")
                systemLog.InsertInstallationInfoLog(resp[0], 'Database Prepration', '{"server":"' + server + '","port":"' + port + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])
                print('Application is installed successfully!\n')
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertInstallationErrorLog(resp[0], 'Database Prepration', '{"server":"' + server + '","port":"' + port + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])


    def SetDatabase(self):
        print('Database Installation Step')
        print('==================================')
        prov = str(input('What is you database? (Press "p" for PostgreSQL or press "m" for MySQL) ')).lower().strip()
        if prov == 'p':
            self.provider = 'postgres'
        elif prov == 'm':
            self.provider = 'mysql'
        self.host = input('Please insert host IP address: ')
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
            resp = exceptionHandling.getErrorMessage("SYS00")
            systemLog.InsertInstallationInfoLog(resp[0], 'Database Prepration', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])
            print('Database is created successfully!\n')
            self.InitData()
            self.SetOwnerBank()
            self.SetAdministrator()
            self.ImportIntegrationData()
            self.CreateReportFolder()
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertInstallationErrorLog(resp[0], 'Database Prepration', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])

    
    def InitData(self):
        print('Data Initialization')
        print('==================================')
        print('Data prepration is in progress. Please Wait...')
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
            resp = exceptionHandling.getErrorMessage("SYS00")
            systemLog.InsertInstallationInfoLog(resp[0], 'Data Initialization', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])
            print('Data is initialized successfully!\n')
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertInstallationErrorLog(resp[0], 'Data Initialization', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])


    def SetOwnerBank(self):
        print('Set Owner Bank')
        print('==================================')
        try:
            print('All available banks are listed as follows: \n')
            with orm.db_session:
                banks = Banks.select()
                for b in banks:
                    print(str(b.BankCode) + ' -> '+ b.BankName)
                bankCode = input('Please insert your bank code based on the abow list: ')
                bank = Banks.get(BankCode =str(bankCode))
                bank.set(IsOwner = True, LatestUpdateDate = datetime.now())
                config.set('Security', 'reportfoldername', str(bank.BankName).replace(" ", ""))
                with open('config/conf.ini', 'w') as configfile:
                    config.write(configfile)
            resp = exceptionHandling.getErrorMessage("SYS00")
            systemLog.InsertInstallationInfoLog(resp[0], 'Set Owner Bank', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])
            print('The owner bank is set successfully!\n')
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertInstallationErrorLog(resp[0], 'Set Owner Bank', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])


    def ImportIntegrationData(self):
        print('Data Integration')
        print('==================================')
        print('Data prepration is in progress. Please Wait...')
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
                resp = exceptionHandling.getErrorMessage("SYS00")
                systemLog.InsertInstallationInfoLog(resp[0], 'Data Integration', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])
                print('Data integration is done successfully!\n')
            else:
                print('Data integration is ignored...')
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertInstallationErrorLog(resp[0], 'Data Integration', '{"provider":"' + self.provider + '","host":"' + self.host + '","database":"' + self.database + '","username":"' + self.username + '","password":"' + self.password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])


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
                Users(FirstName = str(firstName).capitalize(), LastName =str(lastName).capitalize(), Username=str(username).lower(), Password=encryptedPassword, RoleID=role.RoleID, PersonelCode=str(personalCode), IsActive=True, LatestUpdateDate = datetime.now() )
                resp = exceptionHandling.getErrorMessage("SYS00")
                systemLog.InsertInstallationInfoLog(resp[0], 'Set Administrator', '{"firstName":"' + str(firstName).capitalize() + '","lastName":"' + str(lastName).capitalize() + '","personalCode":"' + personalCode + '","username":"' + str(username).lower() + '","password":"' + password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])
                print('Administrator is created successfully!\n')
        except Exception as e:
            resp = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertInstallationErrorLog(resp[0], 'Set Administrator', '{"firstName":"' + str(firstName).capitalize() + '","lastName":"' + str(lastName).capitalize() + '","personalCode":"' + personalCode + '","username":"' + str(username).lower() + '","password":"' + password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), resp[1])

    def CreateReportFolder(self):
        print('Creating Report Folder')
        print('==================================')
        path=app.root_path+'/switchReports/'+ config['Security']['reportFolderName']+'/'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+"/"
        if os.path.exists(path) == False:
            os.makedirs(path)
            print('Switch Report folder for current date is created successfully!\n')
        else:
            print('Switch Report folder for current date is already exists!\n')
        
        path=app.root_path+'/switchReports/'+ config['Security']['reportFolderName']+'/'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+"/InternalTransactionLog"
        if os.path.exists(path) == False:
            os.makedirs(path)
            dir_list = os.listdir(path)
            open(path+'/InternalTransactions-'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+'.log', 'w')
            print('Internal transactions log folder is created successfully!\n')
        else:
            print('Internal tranactions log folder for current date is already exists!\n')

        path=app.root_path+'/switchReports/'+ config['Security']['reportFolderName']+'/'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+"/OtherTranscationLog"
        if os.path.exists(path) == False:
            os.makedirs(path)
            dir_list = os.listdir(path)
            open(path+'/OtherTransactions-'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+'.log', 'w')
            print('Other transactions log folder is created successfully!\n')
        else:
            print('Other transcations log folder for current date is already exists!\n')

        path=app.root_path+'/switchReports/'+ config['Security']['reportFolderName']+'/'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+"/SystemLog"
        if os.path.exists(path) == False:
            os.makedirs(path)
            open(path+'/SystemLog-'+str(datetime.now().year)+str(datetime.now().month)+str(datetime.now().day)+'.log', 'w')
            print('System log folder is created successfully!\n')
        else:
            print('System log folder for current date is already exists!\n')
