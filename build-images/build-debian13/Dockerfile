FROM debian:13
LABEL authors="Miro Stauder <miro@sysown.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
	apt full-upgrade -y

# gcc & build tools
RUN apt install -y \
	make cmake automake bison flex \
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
	libmariadb-dev \
	libunwind8 libunwind-dev \
	uuid-dev \
	libncurses-dev \
	libicu-dev \
	libevent-dev \
	libtirpc-dev

# debug images need valgrind
RUN apt install -y \
	valgrind

# clean apt cache
RUN apt clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

