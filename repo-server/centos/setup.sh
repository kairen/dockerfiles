#!/bin/bash
#
# Program: Setup local apt-get repository
# History: 2017/4/26 Kyle Bai Release

set -xe

HOME_DIR="/var/www/html"
PKG_DIR="centos7"
DOWNLOAD_DIR="${HOME_DIR}/${PKG_DIR}"

# Add docker repository packages
cat <<EOF > /etc/yum.repos.d/docker.repo
[Docker]
baseurl = https://yum.dockerproject.org/repo/main/centos/7/
enabled = 1
gpgcheck = 1
gpgkey = https://yum.dockerproject.org/gpg
name = Docker Repository
EOF

# Add kubernetes repository packages
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[Kubernetes]
baseurl = http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
enabled = 1
gpgcheck = 0
name = Kubernetes Repository
EOF

# Initial repos directory file
rm -rf ${HOME_DIR}/*
mkdir -p ${DOWNLOAD_DIR}

yumdownloader --resolve \
              --destdir=${DOWNLOAD_DIR} \
              vim curl docker-engine kubelet kubectl kubernetes-cni

# yum install --downloadonly \
#             --downloaddir=${DOWNLOAD_DIR} \
#             vim curl docker-engine kubelet kubectl kubernetes-cni

createrepo ${DOWNLOAD_DIR}
