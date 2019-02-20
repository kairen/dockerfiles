# coding:utf-8

from pymongo import MongoClient
import urllib


class MongoDB:

    # 處理格式
    def __init__(self, account='guest', password='guest', ip='127.0.0.1', port='27017', database='guest'):
        password = urllib.quote_plus(password)
        self.uri = 'mongodb://'+account+':'+password+'@'+ip+':'+port+'/'+database

    # 設定條件、資源後讀取
    def load(self, resource, project_id, start_timestamp=0, end_timestamp=0):
        client = MongoClient(self.uri)
        collection = client.log_service.quotas
        results = []
        conditions = {'resource': resource, 'project_id':project_id, 'timestamp': {'$gte': start_timestamp, '$lte': end_timestamp}, }
        for row in collection.find(conditions):
            row_dict = {};
            for key in row.keys():
                row_dict[str(key)]=str(row.get(key))
            results.append(row_dict)
        client.close()
        return results

    def check(self, resource, project_id, timestamp, value):
        client = MongoClient(self.uri)
        collection = client.log_service.quotas
        conditions = {'resource':resource, 'project_id':project_id, 'timestamp':timestamp, 'value':value}
        is_saved = collection.find(conditions).count() > 0
        client.close()
        return is_saved

    # 以特定格式儲存
    def save(self, resource, value, timestamp, project_id):
        client = MongoClient(self.uri)
        collection = client.log_service.quotas
        collection.insert({'resource': resource, 'value': value, 'timestamp': timestamp, 'project_id': project_id, })
        client.close()

# 測試
if __name__ == "__main__":
    import random
    import time
    import sys
    sys.path.append('/etc/log')

    timestamp = int(time.time())
    instances_use = random.randint(0,10)    
    ram_use = random.randint(0,10)    
    cores_use = random.randint(0,10)    
    floating_ips_use = random.randint(0,10)    
    security_groups_use = random.randint(0,10)    

    import setting
    mongodb_info = setting.mongodb_info
    host = mongodb_info['host']
    user = mongodb_info['user']
    password = mongodb_info['password']
    port = mongodb_info['port']
    database = mongodb_info['database']

    operator = MongoDB(user, password, host, port, database)
    operator.save('instances', instances_use, timestamp, 'f4712f4b831e429ba44ccfb576cb6109')
    operator.save('ram', ram_use, timestamp, 'f4712f4b831e429ba44ccfb576cb6109')
    operator.save('cores', cores_use, timestamp, 'f4712f4b831e429ba44ccfb576cb6109')
    operator.save('floating_ips', floating_ips_use, timestamp, 'f4712f4b831e429ba44ccfb576cb6109')
    operator.save('security_groups', security_groups_use, timestamp, 'f4712f4b831e429ba44ccfb576cb6109')
    
    print operator.check('instances', 'f4712f4b831e429ba44ccfb576cb6109', timestamp, instances_use)

    results = operator.load('instances', 'f4712f4b831e429ba44ccfb576cb6109', 1420009692, int(time.time()))
    print 'documents: ' + str(results)
    print 'first document: ' + str(results[0])
    print 'timestamp: ' + str(results[0]['timestamp'])
    print 'project_id: ' + str(results[0]['project_id'])
    print str(results[0]['resource'] + ': ' + str(results[0]['value']))

    results = operator.load('ram', 'f4712f4b831e429ba44ccfb576cb6109', 1420009692, int(time.time()))
    print str(results[0]['resource'] + ': ' + str(results[0]['value']))

    results = operator.load('cores', 'f4712f4b831e429ba44ccfb576cb6109', 1420009692, int(time.time()))
    print str(results[0]['resource'] + ': ' + str(results[0]['value']))

    results = operator.load('floating_ips', 'f4712f4b831e429ba44ccfb576cb6109', 1420009692, int(time.time()))
    print str(results[0]['resource'] + ': ' + str(results[0]['value']))

    results = operator.load('security_groups', 'f4712f4b831e429ba44ccfb576cb6109', 1420009692, int(time.time()))
    print str(results[0]['resource'] + ': ' + str(results[0]['value']))
