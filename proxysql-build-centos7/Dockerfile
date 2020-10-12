FROM centos:centos7
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN yum install -y automake bzip2 cmake make gcc-c++ gcc git openssl openssl-devel patch tar wget rpm-build gnutls gnutls-devel libtool libunwind libunwind-devel
RUN cd /root && wget https://cmake.org/files/v3.17/cmake-3.17.0.tar.gz && tar -zxf cmake-3.17.0.tar.gz && cd cmake-3.17.0 && ./configure && gmake && gmake install && cd .. && rm -rf cmake-3.17.0.tar.gz cmake-3.9.2
