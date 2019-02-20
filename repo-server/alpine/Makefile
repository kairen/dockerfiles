IMAGE_NAME = kairen/pkg-repos
IMAGE_VESION = 0.1.0
NAME = pkg-repos

.PHONY: build run rm exec

all: build

build:
	docker build -t ${IMAGE_NAME}:${IMAGE_VESION} .
run:
	docker run -d  -p 8080:80 --name ${NAME} ${IMAGE_NAME}:${IMAGE_VESION}
rm:
	docker stop ${NAME} && docker rm ${NAME}
exec:
	docker exec -ti ${NAME} bash
