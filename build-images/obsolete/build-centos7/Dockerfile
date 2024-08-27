FROM centos:centos7
LABEL authors="Miro Stauder <miro@sysown.com>"

# fix keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

# fix repos
RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-*.repo
RUN sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-*.repo
RUN sed -i 's/mirror./vault./' /etc/yum.repos.d/CentOS-*.repo

# update packages
RUN yum update -y

# install epel
RUN yum install -y epel-release && \
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

# gcc & build tools
RUN yum install -y \
	make automake \
	git patch which \
	bzip2 tar wget \
	gcc gcc-c++ \
	libtool \
	rpm-build \
	python3 \
	pkg-config

# proxysql build dependencies
RUN yum install -y \
	openssl openssl-devel \
	gnutls gnutls-devel \
	libunwind libunwind-devel \
	perl-IPC-Cmd \
	libuuid-devel \
	libicu-devel \
	libevent-devel

# debug images need valgrind
RUN yum install -y \
	valgrind valgrind-devel

# we need gcc8 for new clickhouse
#RUN yum install -y centos-release-scl && \
#	yum install -y devtoolset-8-gcc devtoolset-8-gcc-c++ && \
#	echo 'source scl_source enable devtoolset-8' >> /etc/bashrc

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
