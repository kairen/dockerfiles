# coding:utf-8

from sqlalchemy import *
import datetime
import time
import os

MYSQL_HOST = os.environ.get('MYSQL_HOST')
MYSQL_USER = os.environ.get('MYSQL_USER')
MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD')


class Mysql:

    def __init__(self, user, password, ip, database):
        
        self.log_db = create_engine('mysql://'+user+':'+password+'@'+ip+'/'+database)
        self.str_date = ''
        self.is_empty = True
        self.date_format = '%Y-%m-%d %H:%M:%S'

    def get_last_quotas(self):
        self.is_empty, created = self.get_last_timer()
        if self.is_empty:
            return True, []

        created += datetime.timedelta(seconds=10)
        self.str_date = created.strftime(self.date_format)

        sql = 'SELECT created, project_id, resource, in_use FROM `log`.`quotas` WHERE created <=  "' + self.str_date + '"'
        cursor = self.log_db.execute(sql)
        results = []
        for row in cursor:
            str_time = row['created'].strftime(self.date_format)
            results.append({
                'created': time.mktime(time.strptime(str_time, self.date_format)),
                'project_id': row['project_id'],
                'resource': row['resource'],
                'in_use': row['in_use']
            })

        cursor.close()
        return False, results

    # 取出最新時間
    def get_last_timer(self):
        cursor = self.log_db.execute('SELECT MAX(created) FROM `log`.`quotas` LIMIT 1')
        for row in cursor:
            time = row[0]
        if time is None:
            cursor.close()
            return True, None
        return False, time

    # 將取出後的數據都刪除
    def clear_old_quotas(self):
        if not self.is_empty:
            self.log_db.execute('DELETE FROM `log`.`quotas` WHERE created <= "' + self.str_date + '"')


# 測試
if __name__ == "__main__":
    operator = Mysql(MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST, 'log')
    is_empty, results = operator.get_last_quotas()
    operator.clear_old_quotas()
    if is_empty:
        print "Log is Empty."
    for row in results:
        print str(row)
