FROM centos:centos6
MAINTAINER Miro Stauder <miro@sysown.com>

RUN cat /etc/redhat-release >&2

# fix keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

# fix repos
RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-*.repo
RUN sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-*.repo
RUN sed -i 's/mirror./vault./' /etc/yum.repos.d/CentOS-*.repo

# install epel
RUN yum -y install epel-release
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

RUN yum -y update

RUN yum -y install yum-plugin-ovl yum-utils pyliblzma
RUN yum -y install\
	make rpm-build\
	bzip2 tar wget xz\
	git patch which\
	openssl openssl-devel\
	gnutls libgnutls gnutls-devel\
	libtool\
	perl-IPC-Cmd\
	libuuid-devel

RUN wget --no-check-certificate http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum -y install devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ cmake openssl-devel patch
RUN ln -fs /opt/rh/devtoolset-2/root/usr/bin/gcc /usr/bin/cc
RUN ln -fs /opt/rh/devtoolset-2/root/usr/bin/g++ /usr/bin/g++
RUN echo "export CC=/opt/rh/devtoolset-2/root/usr/bin/gcc" >> /root/.bashrc
RUN echo "export CPP=/opt/rh/devtoolset-2/root/usr/bin/cpp" >> /root/.bashrc
RUN echo "export CXX=/opt/rh/devtoolset-2/root/usr/bin/c++" >> /root/.bashrc


RUN yum -y install http://repo.okay.com.mx/centos/6/x86_64/release/okay-release-1-1.noarch.rpm
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-OKAY
RUN yum -y install --nogpgcheck automake autoconf

# debug images need valgrind
RUN yum install -y \
	valgrind valgrind-devel

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
