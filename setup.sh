#!/bin/bash
virtualenv -p python3 .
source bin/activate
pip install django==3.0.8
pip install mysqlclient==2.0.1
