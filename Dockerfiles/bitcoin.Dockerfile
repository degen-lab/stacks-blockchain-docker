FROM debian:stretch-slim

ARG BTC_VERSION=0.21.1
ENV BTC_VERSION=${BTC_VERSION}
WORKDIR /
COPY ./make_binary_dist.sh /make_binary_dist.sh
# COPY ./docker-entrypoint.sh /docker-entrypoint.sh
# RUN chmod 755 /docker-entrypoint.sh /make_binary_dist.sh && mkdir -p /root/.bitcoin
RUN chmod 755 /make_binary_dist.sh && mkdir -p /root/.bitcoin
RUN apt-get update && apt-get install -y \
    autoconf \
    build-essential \
    libtool \
    pkg-config \
    python3 \
    libboost-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-thread-dev \
    libboost-chrono-dev \
    libssl-dev \
    libevent-dev \
    git \
    libczmq-dev \
    libzmq5 \
    curl \
    vim-common \
    procps \
    net-tools \
    netcat \
    && /sbin/ldconfig /usr/lib /lib \
    && sh /make_binary_dist.sh
CMD ["/usr/local/bin/bitcoind", "-conf=/etc/bitcoin/bitcoin.conf", "-nodebuglogfile", "-pid=/run/bitcoind.pid", "-datadir=/root/.bitcoin"]