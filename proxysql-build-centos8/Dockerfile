FROM centos:centos8
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN yum install epel-release -y
RUN yum install -y\
	bzip2 tar wget\
	make cmake automake\
	gcc gcc-c++\
	git patch\
	rpm-build\
	python2 python3\
	openssl openssl-devel\
	gnutls gnutls-devel\
	libunwind libunwind-devel\
	libtool\
	perl-IPC-Cmd

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
