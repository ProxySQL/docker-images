FROM debian:12
MAINTAINER Miro Stauder <miro@sysown.com>

#RUN chmod 777 /tmp

# clang & build tools
RUN apt-get update && apt-get install -y\
	make automake gawk\
	git wget\
	clang lld\
	python3

# libtool needs to be installed separately
# depends on c-compiler provided by clang otherwise it pulls in gcc
RUN apt-get install -y\
	libtool

# equivs needs to install with --no-install-recommends
# otherwise it pulls in gcc
RUN apt-get install -y --no-install-recommends\
	equivs

# proxysql build dependencies
RUN apt-get install -y\
	gnutls-dev libgnutls28-dev libssl-dev\
	libmariadb-dev\
	libunwind8 libunwind-dev\
	uuid-dev

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=clang
ENV CXX=clang++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
