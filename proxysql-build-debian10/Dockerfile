FROM debian:10
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN chmod 777 /tmp
RUN apt-get update && apt-get install -y\
    automake\
    cmake\
    equivs\
    gmake\
    make\
    g++\
    gcc\
    gdb\
    gdbserver\
    git\
    gnutls-dev\
    libgnutls28-dev\
    libunwind8\
    libunwind-dev\
    python\
    libmariadbclient-dev\
    libssl-dev\
    libtool\
    vim\
    wget
RUN cd /root && wget https://cmake.org/files/v3.17/cmake-3.17.0.tar.gz && tar -zxf cmake-3.17.0.tar.gz && cd cmake-3.17.0 && ./configure && gmake && gmake install && cd .. && rm -rf cmake-3.17.0.tar.gz cmake-3.9.2

