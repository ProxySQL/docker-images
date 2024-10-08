FROM ubuntu:24.04
LABEL authors="Miro Stauder <miro@sysown.com>"

RUN chmod 777 /tmp
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# clang & build tools
RUN apt-get update && apt-get install -y \
	make automake cmake \
	git wget \
	clang lld \
	python3 \
	zstd \
	pkg-config \
	sudo

# libtool needs to be installed separately
# depends on c-compiler provided by clang otherwise it pulls in gcc
RUN apt-get install -y \
	libtool

# equivs needs to install with --no-install-recommends
# otherwise it pulls in gcc
RUN apt-get install -y --no-install-recommends \
	equivs \
	cmake

# proxysql build dependencies
RUN apt-get install -y \
	gnutls-dev libgnutls28-dev libssl-dev \
	libmysqlclient-dev \
	libunwind8 libunwind-dev \
	uuid-dev \
	libicu-dev \
	libevent-dev

# debug images need valgrind
RUN apt-get install -y \
	valgrind

# clean apt cache
RUN apt clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

# fetch needed include
RUN wget -q -O /usr/include/mysql/hash.h https://raw.githubusercontent.com/mysql/mysql-server/5.7/include/hash.h

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=clang
ENV CXX=clang++

RUN ${CXX} --version

# build && install current cmake
#RUN ln -s /usr/bin/make /usr/bin/gmake
#RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
# better version already present
