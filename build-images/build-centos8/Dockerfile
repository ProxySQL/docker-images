FROM centos:centos8
MAINTAINER Miro Stauder <miro@sysown.com>

RUN cat /etc/redhat-release >&2

# fix keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

# fix repos
RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-*.repo
RUN sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-*.repo
RUN sed -i 's/mirror./vault./' /etc/yum.repos.d/CentOS-*.repo

# install epel
RUN yum -y install epel-release
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8

RUN yum -y update

# gcc & build tools
RUN yum install -y\
	make automake\
	git patch which\
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

# debug images need valgrind
RUN yum install -y \
	valgrind valgrind-devel

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
