import socket
import sys
import os

success_num = '1'
fail_num = '0'

def wait_close_message(server_address,keyword,success,fail):
    try:
        os.unlink(server_address)
    except OSError:
        if os.path.exists(server_address):
            raise

    server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    server.bind(server_address)
    server.listen(10)
    loop_accept(server,keyword, success, fail)


def loop_accept(server,keyword,success,fail):
    while True:
        client, address = server.accept()
        try:
            msg = client.recv(len(keyword))
            if msg == keyword:
                success()
                client.sendall(success_num)
		return
            else:
                fail()
                client.sendall(fail_num)
                
        finally:
            client.close()


def send_close_message(server_address,keyword):
    client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    try:
        client.connect(server_address)
    except socket.error, msg:
        print >>sys.stderr, msg
        sys.exit(1)
    try:
        client.sendall(keyword)
        data = client.recv(1)
        return data == success_num
    finally:
        client.close()

if __name__ == "__main__":
    server_address = "./close_stream"
    keyword = "close_quotas_record"
    def success():
        print "Close Successfully."


    def fail():
        print "Close fail."


    mode = raw_input("Select server(0) or client(1):")
    if mode == '0':
        wait_close_message(server_address,keyword,success,fail)
    else:
        if os.path.exists(server_address):
            is_close = send_close_message(server_address,keyword)
            if is_close :
                success()
            else:
                fail()
        else:
            print "No bind file."
