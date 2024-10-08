FROM ubuntu:16.04
LABEL authors="Miro Stauder <miro@sysown.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
	apt full-upgrade -y

# gcc & build tools
RUN apt install -y \
	make automake \
	git wget \
	gcc g++ \
	libtool \
	gdb gdbserver \
	equivs \
	python3 \
	pkg-config

# proxysql build dependencies
RUN apt install -y \
	libssl-dev gnutls-dev libgnutls28-dev \
	libmysqlclient-dev \
	libunwind8 libunwind-dev \
	uuid-dev \
	libicu-dev \
	libevent-dev

# debug images need valgrind
RUN apt install -y \
	valgrind

# clean apt cache
RUN apt clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

# configure git safe dir
RUN git config --global --add safe.directory '*'

# we need gcc8 for new clickhouse
#RUN apt-get update -y && \
#	apt-get install build-essential software-properties-common -y && \
#	add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
#	apt-get update -y && \
#	apt-get install gcc-8 g++-8 -y && \
#	update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-8


ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN ln -s /usr/bin/make /usr/bin/gmake
RUN wget -q -O /usr/include/mysql/hash.h https://raw.githubusercontent.com/mysql/mysql-server/5.7/include/hash.h
RUN cd /root && \
	wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && \
	tar -zxf cmake-3.22.1.tar.gz && \
	cd cmake-3.22.1 && \
	./configure && \
	gmake -j$(nproc) && \
	gmake install && \
	cd .. && \
	rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
