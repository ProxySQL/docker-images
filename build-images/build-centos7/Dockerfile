FROM centos:centos7
MAINTAINER Miro Stauder <miro@sysown.com>

# fix keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

RUN yum update -y

# gcc & build tools
RUN yum install -y\
	make automake\
	git patch\
	bzip2 tar wget\
	gcc gcc-c++\
	libtool\
	rpm-build\
	python2 python3

# proxysql build dependencies
RUN yum install -y\
	openssl openssl-devel\
	gnutls gnutls-devel\
	libunwind libunwind-devel\
	perl-IPC-Cmd\
	libuuid-devel

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
