#!/bin/bash
#
# Start build OC script.
#

export JOBS=${JOBS:-"1"}
export CONTRAIL_VNC_REPO=${CONTRAIL_VNC_REPO:-"git@github.com:Juniper/contrail-vnc.git"}
export CONTRAIL_BRANCH=${CONTRAIL_BRANCH:-"R3.2.3.x"}
export VERSION=${VERSION:-"3.2.3.x"}
export GIT_ACCOUNT=${GIT_ACCOUNT:-"root@github.com"}
export USER=root

# configure ssh agent
git config --global user.email ${GIT_ACCOUNT}
git config --global user.name ${USER}

ssh-agent|grep -v "Agent pid" > ~/.ssh/ssh-agent.sh
chmod +x ~/.ssh/ssh-agent.sh
. ~/.ssh/ssh-agent.sh
eval "$(ssh-agent -s)"
ssh-add ${SSH_KEY:-"$HOME/.ssh/id_rsa"}
touch /root/.ssh/known_hosts
grep github ~/.ssh/known_hosts || ssh-keyscan github.com >> ~/.ssh/known_hosts

# repo init and sync
[ ! -d build ] && mkdir build
cd build
repo init -u $CONTRAIL_VNC_REPO -b $CONTRAIL_BRANCH
repo sync

# fetch packages
python third_party/fetch_packages.py
chmod +w packages.make

if [ -n "$VERSION" ]; then
  grep $VERSION packages.make
  if [ $? -eq 1 ]; then
    echo -e "VERSION=$VERSION\n$(cat packages.make)" > packages.make
  fi
fi

grep '^source-package-.*:' packages.make |grep -v ceilometer| cut -d : -f 1 | while read i; do
    make -f packages.make $i
done

cd build/packages
for i in *.dsc; do pkgname=$(echo $i|cut -d "_" -f 1); mv ${pkgname}_*.gz ${pkgname}_*.dsc ${pkgname}/; done
for i in `echo */`; do
  cd $i
  SCONSFLAGS="-j ${JOBS} -Q debug=1" dpkg-buildpackage -b -rfakeroot -k${KEY}
  if [ $? -ne 0 ]; then
    SCONSFLAGS="-j ${JOBS} -Q debug=1" dpkg-buildpackage -b -rfakeroot -k${KEY}
  fi
  cd ..
done
if [ ! -d /tmp/packages ]; then
  mkdir /tmp/packages
fi
cp *.deb /tmp/packages
