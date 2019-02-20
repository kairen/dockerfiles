#!/bin/bash

if [ -z $1 ]; then
	echo "Input a Docker Image id or name ..."
	exit 1
fi
docker run --name calamari  -ti \
-p 80:80 \
$1 $2
