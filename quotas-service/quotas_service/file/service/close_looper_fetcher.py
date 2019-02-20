
import sys
sys.path.append('/etc/log')

import os
import setting
import action_receiver

server_address = setting.domain_socket['server_address']
keyword = setting.domain_socket['keyword']

if os.path.exists(server_address):
    is_close = action_receiver.send_close_message(server_address,keyword)
    if is_close :
        print "Close loop fetcher successfully.\n"
    else:
        print "Close loop fetcher fail.\n"
else:
    print "No bind file.\n"
