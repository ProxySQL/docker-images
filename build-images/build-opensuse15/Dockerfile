FROM opensuse/leap:15
MAINTAINER Miro Stauder <miro@sysown.com>

RUN zypper update -y

# gcc & build tools
#RUN zypper install -y\
#	gcc10 gcc10-c++

RUN zypper install -y\
	make automake\
	git patch\
	bzip2 gzip tar wget\
	gcc gcc-c++\
	rpm-build\
	python python3\
	libtool

# proxysql build dependencies
RUN zypper install -y\
	openssl libopenssl-devel\
	gnutls libgnutls-devel\
	libunwind libunwind-devel\
	zlib-devel\
	libuuid-devel

#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 50
#RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 50

# debug images need valgrind
RUN zypper install -y \
	valgrind valgrind-devel

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
