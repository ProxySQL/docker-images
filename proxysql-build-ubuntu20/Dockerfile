FROM ubuntu:20.04
MAINTAINER Nick Vyzas <nick@proxysql.com>

RUN chmod 777 /tmp
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
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
    python python3\
    libgnutls28-dev\
    libmysqlclient-dev\
    libssl-dev\
    libtool\
    libboost-all-dev\
    libunwind8\
    libunwind-dev\
    wget

# build && install current cmake
RUN ln -s /usr/bin/make /usr/bin/gmake
RUN wget -q -O /usr/include/mysql/hash.h https://raw.githubusercontent.com/mysql/mysql-server/5.7/include/hash.h
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
