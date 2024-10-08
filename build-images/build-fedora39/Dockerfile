FROM fedora:39
LABEL authors="Miro Stauder <miro@sysown.com>"

# update packages
RUN yum update -y

# gcc & build tools
RUN dnf install -y \
	make automake \
	git patch \
	bzip2 tar wget \
	gcc gcc-c++ \
	libtool \
	rpm-build \
	python3 \
	pkg-config

# proxysql build dependencies
RUN dnf install -y \
	openssl openssl-devel \
	gnutls gnutls-devel \
	libunwind libunwind-devel \
	zlib-devel \
	perl-FindBin \
	perl-IPC-Cmd \
	libuuid-devel \
	libicu-devel \
	libevent-devel


# debug images need valgrind
RUN dnf install -y \
	valgrind valgrind-devel

# cleanup rpm cache
RUN dnf clean all && \
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
