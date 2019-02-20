# coding:utf-8

import sys
sys.path.append('/etc/log/')
sys.path.append('/opt/log/service/')

from django.http import HttpResponse
from verify import Verify
from mongodb import MongoDB
import json
import setting
import time
import os

KEY_STONE_HOST = setting.keystone_info

def quotas_usage(request, project_id, resource):
    token = request.META.get('HTTP_X_AUTH_TOKEN')

    mongodb_info = setting.mongodb_info
    host = mongodb_info['host']
    user = mongodb_info['user']
    password = mongodb_info['password']
    port = mongodb_info['port']
    database = mongodb_info['database']

    m = MongoDB(user, password, host, port, database)
    
    v = Verify()
    v.set_request(KEY_STONE_HOST['host'], KEY_STONE_HOST['port'])
    v.set_tenantname(project_id)
    
    if v.is_token_available(token):
        start_time = int(request.GET.get('start_time'))
        end_time = int(request.GET.get('end_time'))
        response = m.load(resource, project_id, start_time, end_time)
        response_json = json.dumps(response)
        return HttpResponse(response_json, content_type="application/json")
    else:
        return HttpResponse(v.get_request_data())
