FROM ubuntu:12.04
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN apt-get update && apt-get install -y\
    automake\
    cmake\
    equivs\
    make\
    g++\
    gcc\
    gdb\
    gdbserver\
    git\
    libgnutls28-dev\
    libmysqlclient-dev\
    libssl-dev\
    libtool\
    wget
RUN cd /root && wget https://cmake.org/files/v3.17/cmake-3.17.0.tar.gz && tar -zxf cmake-3.17.0.tar.gz && cd cmake-3.17.0 && ./configure && gmake && gmake install && cd .. && rm -rf cmake-3.17.0.tar.gz cmake-3.9.2

