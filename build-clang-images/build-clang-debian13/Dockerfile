FROM debian:trixie
LABEL authors="Miro Stauder <miro@sysown.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
	apt full-upgrade -y

# clang & build tools
RUN apt install -y \
	make cmake automake bison flex \
	git wget gawk \
	clang lld \
	python3 \
	pkg-config

# libtool needs to be installed separately
# depends on c-compiler provided by clang otherwise it pulls in gcc
RUN apt install -y \
	libtool

# equivs needs to install with --no-install-recommends
# otherwise it pulls in gcc
RUN apt install -y --no-install-recommends \
	equivs

# proxysql build dependencies
RUN apt install -y \
	gnutls-dev libgnutls28-dev libssl-dev \
	libmariadb-dev \
	libunwind8 libunwind-dev \
	uuid-dev \
	libicu-dev \
	libevent-dev \
	libtirpc-dev

# clean apt cache
RUN apt clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=clang
ENV CXX=clang++

RUN ${CXX} --version
