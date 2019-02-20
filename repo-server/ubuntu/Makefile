IMAGE_NAME = kairen/apt-repos
IMAGE_VESION = 0.1.0
NAME = apt-repos

.PHONY: all build run rm exec

all: build

build:
	docker build -t ${IMAGE_NAME}:${IMAGE_VESION} .
run:
	docker run -d  -p 80:80 --name ${NAME} ${IMAGE_NAME}:${IMAGE_VESION}
rm:
	docker stop ${NAME} && docker rm ${NAME}
exec:
	docker exec -ti ${NAME} bash
