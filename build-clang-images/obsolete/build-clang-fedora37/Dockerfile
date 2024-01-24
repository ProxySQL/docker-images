FROM fedora:37
MAINTAINER Miro Stauder <miro@sysown.com>

# clang & build tools
RUN dnf install -y\
	make automake\
	git patch which\
	bzip2 tar wget

# try avoiding pulling gcc as dependency
RUN dnf install -y --setopt=install_weak_deps=False --best\
	clang lld compiler-rt\
	rpm-build\
	python2 python3\
	libtool

# proxysql build dependencies
RUN dnf install -y\
	openssl openssl-devel\
	gnutls gnutls-devel\
	libunwind libunwind-devel\
	zlib-devel\
	perl-FindBin\
	perl-IPC-Cmd\
	libuuid-devel

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=clang
ENV CXX=clang++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1

# remove gcc pulled in as clang dependency
#RUN rpm -e --nodeps gcc gcc-c++
