FROM fedora:42
LABEL authors="Miro Stauder <miro@sysown.com>"

# update packages
RUN dnf update -y

# gcc & build tools
RUN dnf install -y \
	make cmake automake bison flex \
	git patch \
	bzip2 tar wget \
	gcc gcc-c++ \
	libtool \
	rpm-build \
	python3 \
	pkg-config

# proxysql build dependencies
RUN dnf install -y \
	openssl openssl-devel openssl-devel-engine \
	gnutls gnutls-devel \
	libunwind libunwind-devel \
	zlib-devel \
	perl-FindBin \
	perl-IPC-Cmd \
	perl-Time-Piece \
	libuuid-devel \
	libicu-devel \
	libevent-devel \
	ncurses-devel

# install from CRB repo on CentOS
RUN yum install -y \
	libtirpc-devel \
	rpcgen

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
