FROM centos:centos8
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
RUN yum install -y automake bzip2 cmake make gcc-c++ gcc git openssl openssl-devel patch tar wget rpm-build gnutls python2 gnutls-devel libtool libunwind libunwind-devel
RUN cd /root && wget https://cmake.org/files/v3.9/cmake-3.9.2.tar.gz && tar -zxf cmake-3.9.2.tar.gz && cd cmake-3.9.2 && ./configure && gmake && gmake install

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
RUN ln -s /usr/bin/python2.7 /usr/bin/python
ENTRYPOINT opt/entrypoint.sh
