FROM fedora:28
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN dnf install -y\
	automake\
	bzip2\
	cmake\
	make\
	gcc-c++\
	gcc\
	git\
	openssl\
	openssl-devel\
	patch\
	tar\
	wget\
	rpm-build\
	gnutls\
	python2 python3\
	gnutls-devel\
	libtool\
	libunwind\
	libunwind-devel\
	perl-IPC-Cmd

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
