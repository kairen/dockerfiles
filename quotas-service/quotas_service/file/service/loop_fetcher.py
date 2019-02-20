# coding:utf-8

import sys
sys.path.append('/etc/log')

import os
import time
import datetime
import threading
from mysql import Mysql
from mongodb import MongoDB
import setting
import action_receiver

is_running = True
wait_seconds = 60

MYSQL_INFO = setting.mysql_info
mysql_operator = Mysql(MYSQL_INFO['user'], MYSQL_INFO['password'], MYSQL_INFO['host'], 'log')

def work():
    global is_running
    while wait_while():
        # with lock:
        action()
    write_log("Close Looper.")
    return

def wait_while():
    global is_running
    write_log("Waiting 60 seconds ...")
    second_count = 0
    while second_count != wait_seconds:
        if is_running == False :
            return False
        second_count = second_count + 1
        time.sleep(1)

    return True

def action():
    
    is_empty, logs = mysql_operator.get_last_quotas()

    if is_empty:
        write_log("Log is Empty.")
        return

    mongo_operator = MongoDB(user, password, host, port, database)
    for row in logs:
        mongo_operator.save(
            row['resource'], row['in_use'],
            row['created'], row['project_id'])

    for row in logs:
        is_saved = mongo_operator.check(
            row['resource'], row['project_id'],
            row['created'], row['in_use'])

        if is_saved == False :
            mongo_operator.save(
               row['resource'], row['in_use'],
               row['created'], row['project_id'])
        
        is_saved = mongo_operator.check(
            row['resource'], row['project_id'],
            row['created'], row['in_use'])
        if is_saved == False :
            write_log(
                "resource:" + str(row['resource']) +
                " project_id:" + str(row['project_id']) +
                " created:" + str(row['created']) +
                " in_use:" + str(row['in_use']) +
                " write failed." )

    mysql_operator.clear_old_quotas()


def wait():
    write_log("Waiting 60 seconds ...")
    time.sleep(60)

def write_log(msg):
    log_path = "/var/log/log_service/background_service";
    if os.path.exists(log_path):
    	f = open(log_path,"a+")
        f.write(str(datetime.datetime.now())+":  "+msg+"\n")
        f.close()

def success():
    global is_running
    is_running = False
    write_log("Close loop fetcher successfully.")


def fail():
    write_log("Close loop fetcher fail.")


# 取出MongoDB資料
mongodb_info = setting.mongodb_info
host = mongodb_info['host']
user = mongodb_info['user']
password = mongodb_info['password']
port = mongodb_info['port']
database = mongodb_info['database']

server_address = setting.domain_socket['server_address']
keyword = setting.domain_socket['keyword']

# lock = threading.Lock()
ThreadGroup = []
worker = threading.Thread(target=work)
ThreadGroup.append(worker)

# 執行緒與主執行緒綁定
#worker.daemon = True
worker.start()

write_log("Waiting message to close loop fetcher.")
action_receiver.wait_close_message(server_address,keyword,success,fail)

#Input = raw_input("Press Any Key To Stop Thread\n")

