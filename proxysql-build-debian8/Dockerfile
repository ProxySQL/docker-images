FROM debian:8.2
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

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
    libtool
RUN cd /root && wget https://cmake.org/files/v3.9/cmake-3.9.2.tar.gz && tar -zxf cmake-3.9.2.tar.gz && cd cmake-3.9.2 && ./configure && make && make install && cd .. && rm -rf cmake-3.9.2.tar.gz && rm -rf cmake-3.9.2
