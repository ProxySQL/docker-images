FROM debian:13
LABEL authors="Miro Stauder <miro@sysown.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
	apt full-upgrade -y

# gcc & build tools
RUN apt install -y \
	make cmake automake bison flex \
	git wget curl \
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

# rust needs to link to libclang.so
RUN apt install -y \
	libclang-dev

RUN export RUST_VERSION="1.92.0" && \
	export RUST_ARCH="$(uname -m)" && \
	curl -sLf "https://static.rust-lang.org/dist/rust-${RUST_VERSION}-${RUST_ARCH}-unknown-linux-gnu.tar.gz" | tar xzf - && \
	./rust-${RUST_VERSION}-${RUST_ARCH}-unknown-linux-gnu/install.sh --prefix=/usr/local && \
	rm -rf ./rust-${RUST_VERSION}-${RUST_ARCH}-unknown-linux-gnu/
RUN	rustc --version  && \
	cargo --version

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

