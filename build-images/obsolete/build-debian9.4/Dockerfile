FROM debian:9.4
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
    libmariadbclient-dev\
    libssl-dev\
    libtool\
    libunwind8\
    libunwind-dev\
    vim\
    wget
RUN ln -s /usr/bin/make /usr/bin/gmake
RUN cd /root && wget https://cmake.org/files/v3.17/cmake-3.17.0.tar.gz && tar -zxf cmake-3.17.0.tar.gz && cd cmake-3.17.0 && ./configure && gmake && gmake install && cd .. && rm -rf cmake-3.17.0.tar.gz cmake-3.9.2

