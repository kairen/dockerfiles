# Dockerizing OpenSIPS Service
Dockerfile to build a OpenSIPS container image. The container provides rapid deployment of VoIP services

### Build Images
First, clone this project to the local：
```sh
$ git clone https://github.com/imac-cloud/docker-opensips.git
```

Then, into the directory and execute the following command：
```sh
$ cd docker-opensips
$ docker build -t imaccloud/opensips:2.1.0 .
```

### Quick Start
Automated builds of the image are available on [DockerHub](https://hub.docker.com/r/imaccloud/docker-opensips/) and is the recommended method of installation.
```sh
$ docker pull imaccloud/docker-opensips:2.1.0
```

Now, you can manually launch the OpenSIPS container, the following command：
```sh
$ docker run --name opensips -d -p 5060:5060/udp \
-e ADVERTISED_IP="<ADVERTISED_IP>" \
imaccloud/docker-opensips:2.1.0
```
> Please provides a ```ADVERTISED_IP```.
