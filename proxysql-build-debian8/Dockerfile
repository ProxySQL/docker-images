FROM debian:8
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN chmod 777 /tmp
RUN apt-get update && apt-get install -y\
    automake\
    wget\
    equivs\
    make\
    g++\
    gcc\
    gdb\
    gdbserver\
    git\
    gnutls-dev\
    python\
    libgnutls28-dev\
    libmysqlclient-dev\
    libssl-dev\
    libunwind8\
    libunwind-dev\
    libtool\
    vim\
    python3

# build && install current cmake
RUN ln -s /usr/bin/make /usr/bin/gmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
