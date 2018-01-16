FROM debian:7.8
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN apt-get update && apt-get install -y\
    automake\
    equivs\
    make\
    g++\
    gcc\
    gdb\
    gdbserver\
    git\
    python\
    libmysqlclient-dev\
    libssl-dev\
    libtool\
    libboost1.49-all-dev\
    wget\
    lsb-release
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.9-1_all.deb -O mysql-apt-config_0.8.9-1_all.deb -q
RUN DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.9-1_all.deb
RUN apt-get update
RUN apt-get -y install libmysqlclient20 libmysqlclient-dev
RUN wget -q -O /usr/include/mysql/hash.h https://raw.githubusercontent.com/mysql/mysql-server/5.7/include/hash.h
RUN wget -q https://cmake.org/files/v3.9/cmake-3.9.6.tar.gz
RUN tar -zxf cmake-3.9.6.tar.gz && cd cmake-3.9.6 && ./bootstrap && make && make install
RUN rm -rf cmake-3.9.6.tar.gz && rm -rf cmake-3.9.6
