import sys
import random, json
from psycopg2 import connect
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import pymysql
from flask import *
from flask_cors import CORS, cross_origin
import App
from models.DatabaseContext import *
import hashlib
import configparser
from datetime import datetime
from controllers.security.SystemLog import SystemLog
from controllers.security.NetworkManagement import NetworkManagement
from controllers.security.ExceptionHandling import ExceptionHandling
import getpass

systemLog = SystemLog()
networkManagement = NetworkManagement()
exceptionHandling = ExceptionHandling()

class SystemPrepration:
    config = configparser.ConfigParser()

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
                result = exceptionHandling.getErrorMessage("SYS00")
            systemLog.InsertInfoLog('00', 'Database Prepration', '{"server":"' + server + '","port":"' + port + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+result)
            print('Application is installed successfully!\n')
        except Exception as e:
            result = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertErrorLog('00', 'Database Prepration', '{"server":"' + server + '","port":"' + port + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+result)


    def SetDatabase(self):
        print('Database Installation Step')
        print('==================================')
        host = input('Please insert host IP address: ')
        provider = input('Please insert provider: ')
        database = input('Please insert database name: ')
        username = input('Please insert username: ')
        password = getpass.getpass(prompt='Please insert password: ')
        try:
            if str(provider) == 'postgres':
                con = connect(dbname='postgres', user=str(username), host=str(host), password=str(password))
                con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
                cur = con.cursor()
                cur.execute('CREATE DATABASE ' + str(database).lower())
                cur.close()
                con.close()
            elif str(provider) == 'mysql':
                conn = pymysql.connect(host=str(host), user=str(username), password=str(password))
                conn.cursor().execute('create database '+str(database))
                conn.close()
            config.set('ConnectionString', 'provider', provider)
            config.set('ConnectionString', 'host', host)
            config.set('ConnectionString', 'database', database)
            config.set('ConnectionString', 'user', username)
            config.set('ConnectionString', 'password', password)
            with open('config/conf.ini', 'w') as configfile:
                config.write(configfile)
            db.bind(provider=config['ConnectionString']['provider'], user=config['ConnectionString']['user'], password=config['ConnectionString']['password'], host=config['ConnectionString']['host'], database=config['ConnectionString']['database'])
            db.generate_mapping(create_tables=True)
            response = exceptionHandling.getErrorMessage("SYS00")
            systemLog.InsertInfoLog('00', 'Database Prepration', '{"provider":"' + provider + '","host":"' + host + '","database":"' + database + '","username":"' + username + '","password":"' + password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+str(response.encode("utf-8")))
            print('Database is created successfully!\n')
            self.SetAdministrator()
            print('All Done! Beep Beep!!!\n')
        except Exception as e:
            response = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertErrorLog('00', 'Database Prepration', '{"provider":"' + provider + '","host":"' + host + '","database":"' + database + '","username":"' + username + '","password":"' + password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: ' + str(response.encode("utf-8")))



    def SetAdministrator(self):
        print('Set Administrator Information')
        print('==================================')
        firstName = input('Please insert first name: ')
        lastName = input('Please insert last name: ')
        personalCode = input('Please insert personal code: ')
        username = input('Please insert username: ')
        password = getpass.getpass(prompt='Please insert password: ')
        try:
            with db_session:
                encryptedPassword = hashlib.sha512(str(password).encode('utf-8')).hexdigest()
                Roles(RoleTitle = 'Administrator', LatestUpdateDate = datetime.now())
                role = list(Roles.select(lambda r: r.RoleTitle == 'Administrator'))[0]
                Users(FirstName = str(firstName), LastName =str(lastName), Username=str(username), Password=encryptedPassword, RoleID=role.RoleID, PersonelCode=str(personalCode), IsActive=True, LatestUpdateDate = datetime.now() )
                response = exceptionHandling.getErrorMessage("SYS00")
                systemLog.InsertInfoLog('00', 'Set Administrator', '{"firstName":"' + firstName + '","lastName":"' + lastName + '","personalCode":"' + personalCode + '","username":"' + username + '","password":"' + password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: '+str(response.encode("utf-8")))
                print('Administrator is created successfully!\n')
        except Exception as e:
            response = exceptionHandling.getErrorMessage("SYS500")
            systemLog.InsertErrorLog('00', 'Set Administrator', '{"firstName":"' + firstName + '","lastName":"' + lastName + '","personalCode":"' + personalCode + '","username":"' + username + '","password":"' + password + '"}', datetime.now(), networkManagement.getHostUsername(), networkManagement.getHostName(), networkManagement.getHostIP(), 'Result: ' + str(response.encode("utf-8")))