#!/bin/bash
#
# Program: Setup local apt-get repository
# History: 2017/4/26 Kyle Bai Release

set -xe

HOME_DIR="/var/www/html"
DOWNLOAD_DIR="/var/cache/apt/archives"
ARCHS="amd64"

# Add docker repository packages
apt-key adv --keyserver "hkp://p80.pool.sks-keyservers.net:80" \
            --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

cat <<EOF > /etc/apt/sources.list.d/docker.list
deb https://apt.dockerproject.org/repo ubuntu-xenial main
EOF

# Add kubernetes repository packages
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Initial clean directory files
rm -rf ${HOME_DIR}/*
rm -rf  ${DOWNLOAD_DIR}/*.deb

# Generate GPG key and get gpg id
gpg --batch --gen-key gpg-gen.key
GPG_ID=$(gpg --list-key | grep -o '\/\w* ' | sed 's/\///g')

# Setup local repository
mkdir -p ${HOME_DIR}/${ARCHS}
cd ${HOME_DIR}

gpg -a --export ${GPG_ID} > repos.public.key

apt-get update
apt-get -d install -y \
           vim curl docker-engine kubelet kubectl kubernetes-cni
mv ${DOWNLOAD_DIR}/*.deb ${HOME_DIR}/${ARCHS}

apt-ftparchive packages ${ARCHS} | gzip -9c > ${ARCHS}/Packages.gz
gunzip -k ${ARCHS}/Packages.gz

apt-ftparchive release ${ARCHS} > ${ARCHS}/Release
gpg -abs --default-key ${GPG_ID} -o ${ARCHS}/Release.gpg ${ARCHS}/Release
