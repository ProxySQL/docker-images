FROM almalinux:8
LABEL authors="Miro Stauder <miro@sysown.com>"

# update packages
RUN yum update -y

# install from epel
RUN yum install -y epel-release && \
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8

# gcc & build tools
RUN yum install -y \
	make automake bison flex \
	git patch \
	bzip2 tar wget \
	gcc gcc-c++ \
	libtool \
	rpm-build \
	python3 \
	pkg-config

# proxysql build dependencies
RUN yum install -y \
	openssl openssl-devel \
	openssl3 openssl3-devel \
	gnutls gnutls-devel \
	libunwind libunwind-devel \
	perl-IPC-Cmd \
	libuuid-devel \
	libicu-devel \
	libevent-devel \
	ncurses-devel

# install from CRB repo
RUN yum install -y --enablerepo=powertools \
	libtirpc-devel \
	rpcgen

# debug images need valgrind
RUN yum install -y \
	valgrind valgrind-devel

# cleanup rpm cache
RUN yum clean all && \
	rm -rf /var/cache/yum

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && \
	wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && \
	tar -zxf cmake-3.22.1.tar.gz && \
	cd cmake-3.22.1 && \
	./configure && \
	gmake -j$(nproc) && \
	gmake install && \
	cd .. && \
	rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
