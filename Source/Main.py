import sys
import time
import json

try:
    from pip import main as pipmain
except ImportError:
    from pip._internal import main as pipmain

try:
    from flask import Flask, request, jsonify
    from flask_cors import CORS, cross_origin
    from flask_paginate import Pagination, get_page_parameter
    import numpy
    import xlsxwriter
    import pandas
    from pony.orm import *
    from PollyReports import *
    import psycopg2
    import pymysql
    import reportlab
    from Crypto.Cipher import DES
    pymysql.install_as_MySQLdb()
    
except ImportError:
    pipmain(['install', 'flask', 'pony', 'flask-cors', 'psycopg2', 'pymysql', 'numpy', 'flask-paginate', 'XlsxWriter', 'pandas', 'PollyReports', 'reportlab', 'pycryptodome'])

import configparser
import random, threading, webbrowser
from datetime import datetime
from controllers.security.SystemPrepration import SystemPrepration
from App import *

if __name__ == "__main__":
    app.debug = False
    app.secret_key = 'RoadRunner'
    app.config['SESSION_TYPE'] = 'filesystem'

    config = configparser.ConfigParser()
    config.sections()
    config.read('config/conf.ini')
    
    print('')
    print(config['AppInfo']['appName']+': '+config['AppInfo']['description'])
    print('Published by ' + config['AppInfo']['publisher'])

    if config['DEFAULT']['server'] == 'NotSet' or config['DEFAULT']['port'] == 'NotSet':
        systemPrepration = SystemPrepration()
        systemPrepration.SetWebServer()
    if config['ConnectionString']['host'] == 'NotSet' or config['ConnectionString']['database'] == 'NotSet':
        systemPrepration = SystemPrepration()
        systemPrepration.SetDatabase()

    config = configparser.ConfigParser()
    config.sections()
    config.read('config/conf.ini')


print('All Done! Horizon is ready to use.\n')
app.run(host=config['DEFAULT']['server'], port=config['DEFAULT']['port'])
    

