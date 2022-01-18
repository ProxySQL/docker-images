FROM debian:11
MAINTAINER Miro Stauder <miro@sysown.com>

#RUN chmod 777 /tmp

# clang build tools
RUN apt-get update && apt-get install -y\
	make automake gawk\
	git wget\
	clang lld\
	python python3

# libtool needs to installed separately
# otherwise it pulls in gcc
RUN apt-get install -y\
	libtool

# proxysql build dependencies
RUN apt-get install -y\
	gnutls-dev libgnutls28-dev libssl-dev\
	libmariadb-dev\
	libunwind8 libunwind-dev
#	libc-dev libc++-dev libc++abi-dev

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
