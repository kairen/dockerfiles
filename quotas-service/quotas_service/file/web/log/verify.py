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
        header_list = {
            'Content-Type':'application/json',
            'Accept':'application/json',
            'X-Auth-Token':token
        }
        url = 'http://' + self.ip + ':' + self.port + '/v2.0/tenants'
        request = urllib2.Request(url, headers=header_list)
        
        try:
            result = urllib2.urlopen(request)
            self.data = result.read()
            decode = json.loads(self.data)
            if ('tenants' in decode) & ('tenants_links' in decode) :
                return True
        except urllib2.URLError, e:
            self.data = e.read()
        return False

    def get_request_data(self):
        return self.data


if __name__ == "__main__":

    v = Verify()
    v.set_request('10.21.20.118', '5000')
    v.set_tenantname('admin')
    is_ok = v.is_token_available("576debfebfbf43e58b6f031569b941dc")
    if is_ok:
        print "Ok."
    else:
        print v.get_request_data()
