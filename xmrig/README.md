# Run xmrig on Docker
Monero (XMR) CPU miner on Docker container.

# Quick Start
To build and run xmrig container as follow command:
```sh
$ docker build -t kairen/xmrig:v2.4.1 .
$ docker run -d --restart=always --name xmrig kairen/xmrig:v2.4.1
```
