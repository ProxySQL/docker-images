FROM fedora:24
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN dnf install -y automake bzip2 cmake make gcc-c++ gcc git openssl openssl-devel patch tar wget rpm-build python2 gnutls gnutls-devel libtool libunwind libunwind-devel
RUN cd /root && wget https://cmake.org/files/v3.17/cmake-3.17.0.tar.gz && tar -zxf cmake-3.17.0.tar.gz && cd cmake-3.17.0 && ./configure && gmake && gmake install && cd .. && rm -rf cmake-3.17.0.tar.gz cmake-3.9.2

