FROM opensuse/leap:15.6
LABEL authors="Miro Stauder <miro@sysown.com>"

RUN zypper update -y

# clang & build tools
RUN zypper install -y \
	clang lld

RUN zypper install -y \
	make cmake automake bison flex \
	git patch \
	bzip2 gzip tar wget \
	rpm-build \
	python3 \
	pkg-config \
	libtool

# proxysql build dependencies
RUN zypper install -y \
	openssl libopenssl-devel \
	gnutls libgnutls-devel \
	libunwind libunwind-devel \
	libcurl-devel \
	zlib-devel \
	libc++-devel libstdc++-devel \
	libuuid-devel \
	libicu-devel \
	libevent-devel

RUN zypper addrepo -f 'http://download.opensuse.org/distribution/leap/15.6/repo/oss/' leap-15.6-oss
RUN zypper install -y \
	libtirpc-devel \
	libtirpc3 \
	libtirpc-netconfig \
	rpcgen rpcbind

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-17 50
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-17 50

# https://forums.opensuse.org/showthread.php/530520-Clang-and-LLVM-6-0?p=2861482#post2861482
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 50 \
	--slave /usr/bin/clang++ clang++ /usr/bin/clang++-17

# cleanup rpm cache
RUN zypper clean --all

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=clang
ENV CXX=clang++

RUN ${CXX} --version
