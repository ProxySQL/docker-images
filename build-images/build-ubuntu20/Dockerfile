FROM ubuntu:20.04
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
	zstd \
	pkg-config \
	sudo

# proxysql build dependencies
RUN apt install -y \
	libssl-dev gnutls-dev libgnutls28-dev \
	libmysqlclient-dev \
	libunwind8 libunwind-dev \
	uuid-dev \
	libncurses-dev \
	libicu-dev \
	libevent-dev

# debug images need valgrind
RUN apt install -y \
	valgrind

# clean apt cache
RUN apt clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

# fetch needed include
RUN wget -q -O /usr/include/mysql/hash.h https://raw.githubusercontent.com/mysql/mysql-server/5.7/include/hash.h

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN ln -fs /usr/bin/make /usr/bin/gmake
RUN cd /root && \
	wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && \
	tar -zxf cmake-3.22.1.tar.gz && \
	cd cmake-3.22.1 && \
	./configure && \
	gmake -j$(nproc) && \
	gmake install && \
	cd .. && \
	rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
