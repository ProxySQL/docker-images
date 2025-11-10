FROM opensuse/leap:16.0
LABEL authors="Miro Stauder <miro@sysown.com>"

ENV ZYPP_PCK_PRELOAD='1 zypper dup'
ENV ZYPP_CURL2='1 zypper ref'

RUN zypper update -y

# gcc & build tools
#RUN zypper install -y \
#	gcc10 gcc10-c++

RUN zypper install -y \
	make cmake automake bison flex \
	git patch \
	bzip2 gzip tar wget \
	gcc gcc-c++ \
	rpm-build \
	python3 \
	libtool \
	pkg-config

# proxysql build dependencies
RUN zypper install -y \
	openssl libopenssl-devel \
	gnutls libgnutls-devel \
	zlib-devel \
	libuuid-devel \
	libicu-devel \
	libevent-devel \
	ncurses-devel

#RUN zypper addrepo -f 'http://download.opensuse.org/tumbleweed/repo/oss/' tumbleweed-oss
RUN zypper addrepo -f 'http://download.opensuse.org/distribution/leap/16.0/repo/oss/' leap-16.0-oss
RUN zypper install -y \
	libtirpc-devel \
	libtirpc3 \
	libtirpc-netconfig \
	rpcgen rpcbind \
	libunwind8 libunwind-devel

#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 50
#RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 50

# debug images need valgrind
RUN zypper install -y \
	valgrind valgrind-devel

# cleanup rpm cache
RUN zypper clean --all

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
#RUN cd /root && \
#	wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && \
#	tar -zxf cmake-3.22.1.tar.gz && \
#	cd cmake-3.22.1 && \
#	./configure && \
#	gmake -j$(nproc) && \
#	gmake install && \
#	cd .. && \
#	rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
