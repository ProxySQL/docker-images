FROM alpine:3
MAINTAINER Miro Stauder <miro@sysown.com>


# build tools
RUN apk update && \
	apk add alpine-sdk && \
	apk add bash && \
	apk add perl && \
	apk add gnutls gnutls-dev && \
	apk add cmake && \
	apk add autoconf automake && \
	apk add libtool && \
	apk add python3 && \
	apk add elfutils-dev

# dependencies
RUN	apk add linux-headers && \
	apk add musl-dev && \
	apk add libuuid && \
	apk add util-linux-dev && \
#	apk add gcompat && \
	apk add libstdc++ && \
#	apk add libunwind libunwind-dev && \
	apk add valgrind valgrind-dev && \
	apk add -X https://dl-cdn.alpinelinux.org/alpine/v3.12/main libexecinfo libexecinfo-dev

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
#RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
