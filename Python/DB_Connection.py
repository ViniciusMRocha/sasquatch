#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri May  3 10:40:06 2019

@author: nshah
"""

import mysql.connector

cnx = mysql.connector.connect(
                            user = 'NillanShah',
                            password = 'Hatchlabs123',
                            host = '192.168.248.18',
                            database = 'SasquatchDB',
                            auth_plugin='mysql_native_password'
                            )

cursor = cnx.cursor()

#Example select statement
selectStatement = ('SELECT * FROM SasquatchDB.tbl_process')

cursor.execute(selectStatement)

#printing the statement, once you print, cursor is empty
for x in cursor:
    print(x)
