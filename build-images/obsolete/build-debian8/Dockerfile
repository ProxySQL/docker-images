FROM debian:8
MAINTAINER Miro Stauder <miro@sysown.com>

RUN chmod 777 /tmp

# fix repos
RUN sed -i '/jessie-updates/d' /etc/apt/sources.list; \
	sed -i 's/deb.debian/archive.debian/' /etc/apt/sources.list; \
	sed -i 's/security.debian/archive.debian/' /etc/apt/sources.list; \
	sed -i 's/deb /deb [trusted=yes] /' /etc/apt/sources.list

# gcc & build tools
RUN apt-get update && apt-get install -y\
	make automake\
	git wget\
	gcc g++\
	libtool\
	gdb gdbserver\
	equivs\
	python python3

# proxysql build dependencies
RUN apt-get install -y\
	libssl-dev gnutls-dev libgnutls28-dev\
	libmysqlclient-dev\
	libunwind8 libunwind-dev\
	uuid-dev

# debug images need valgrind
RUN apt-get update && apt-get install -y \
	valgrind

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN ln -s /usr/bin/make /usr/bin/gmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
