FROM centos:centos6
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN cat /etc/redhat-release >&2

RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i 's/mirror./vault./' /etc/yum.repos.d/CentOS-Base.repo
RUN yum -y update

RUN yum -y install yum-plugin-ovl yum-utils
RUN yum -y install\
	make rpm-build\
	bzip2 tar wget\
	git patch\
	openssl openssl-devel\
	gnutls libgnutls gnutls-devel\
	libtool\
	perl-IPC-Cmd

RUN wget --no-check-certificate http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum -y install devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ cmake openssl-devel patch
RUN ln -fs /opt/rh/devtoolset-2/root/usr/bin/gcc /usr/bin/cc
RUN ln -fs /opt/rh/devtoolset-2/root/usr/bin/g++ /usr/bin/g++
RUN echo "export CC=/opt/rh/devtoolset-2/root/usr/bin/gcc" >> /root/.bashrc
RUN echo "export CPP=/opt/rh/devtoolset-2/root/usr/bin/cpp" >> /root/.bashrc
RUN echo "export CXX=/opt/rh/devtoolset-2/root/usr/bin/c++" >> /root/.bashrc

RUN yum -y install epel-release
RUN yum -y install http://repo.okay.com.mx/centos/6/x86_64/release/okay-release-1-1.noarch.rpm
RUN yum -y install automake autoconf

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
