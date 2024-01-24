FROM opensuse/leap:15
MAINTAINER Miro Stauder <miro@sysown.com>

RUN zypper update -y

# clang & build tools
RUN zypper install -y \
	clang lld

RUN zypper install -y \
	make automake \
	git patch \
	bzip2 gzip tar wget \
	rpm-build \
	python python3 \
	libtool

# proxysql build dependencies
RUN zypper install -y \
	openssl libopenssl-devel \
	gnutls libgnutls-devel \
	libunwind libunwind-devel \
	libcurl-devel \
	zlib-devel \
	libc++-devel libstdc++-devel \
	libuuid-devel

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-15 50
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-15 50

# https://forums.opensuse.org/showthread.php/530520-Clang-and-LLVM-6-0?p=2861482#post2861482
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 50 \
	--slave /usr/bin/clang++ clang++ /usr/bin/clang++-15

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=clang
ENV CXX=clang++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
