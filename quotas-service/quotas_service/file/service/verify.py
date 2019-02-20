# coding:utf-8

import json
import urllib2

class Verify:

    def set_request(self, ip, port):
        self.ip = ip
        self.port = port
    
    def set_tenantname(self, tenantname):
        self.tenantname = tenantname
    
    def is_token_available(self, token):
        headers = {'Content-Type':'application/json',"Accept":"application/json"}
        data = json.dumps({"auth":{"tenantId":self.tenantname,"token":{"id":token}}})
        url = 'http://' + self.ip + ':' + self.port + '/v2.0/tokens'
        request = urllib2.Request(url,data,headers)
        
        try:
            urllib2.urlopen(request)
            return True
        except urllib2.URLError, e:
            return False

if __name__ == "__main__":

    v = Verify()
    v.set_request('10.21.20.118', '5000')
    v.set_tenantname('admin')
    print(v.is_token_available("576debfebfbf43e58b6f031569b941dc"))