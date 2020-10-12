FROM centos:centos7.5.1804
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN yum install -y automake bzip2 cmake make gcc-c++ gcc git openssl openssl-devel patch tar wget rpm-build vim gdb
RUN cd /root && wget https://cmake.org/files/v3.9/cmake-3.9.2.tar.gz && tar -zxf cmake-3.9.2.tar.gz && cd cmake-3.9.2 && ./configure && gmake && gmake install
