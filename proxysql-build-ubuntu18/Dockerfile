FROM ubuntu:18.04
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN chmod 777 /tmp
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
    gnutls-dev\
    python\
    libgnutls28-dev\
    libmysqlclient-dev\
    libssl-dev\
    libtool\
    libboost1.62-all-dev\
    libunwind8\
    libunwind-dev\
    wget
RUN ln -s /usr/bin/make /usr/bin/gmake
RUN wget -q -O /usr/include/mysql/hash.h https://raw.githubusercontent.com/mysql/mysql-server/5.7/include/hash.h
RUN cd /root && wget https://cmake.org/files/v3.17/cmake-3.17.0.tar.gz && tar -zxf cmake-3.17.0.tar.gz && cd cmake-3.17.0 && ./configure && gmake && gmake install && cd .. && rm -rf cmake-3.17.0.tar.gz cmake-3.9.2

