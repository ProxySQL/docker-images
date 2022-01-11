FROM proxysql/packaging:build-centos6.7
MAINTAINER Rene Cannao <rene.cannao@gmail.com>


# workaroud for yum issues - [Errno 14] problem making ssl connection

# install pre-requisites for OpenSSL 3.0 build
RUN wget --no-check-certificate https://vault.centos.org/6.7/updates/x86_64/Packages/perl-Locale-Maketext-Simple-0.18-141.el6_7.1.x86_64.rpm && rpm -i perl-Locale-Maketext-Simple-0.18-141.el6_7.1.x86_64.rpm && rm -f perl-Locale-Maketext-Simple-0.18-141.el6_7.1.x86_64.rpm
RUN wget --no-check-certificate https://vault.centos.org/6.7/updates/x86_64/Packages/perl-Module-Load-0.16-141.el6_7.1.x86_64.rpm && rpm -i perl-Module-Load-0.16-141.el6_7.1.x86_64.rpm && rm -f perl-Module-Load-0.16-141.el6_7.1.x86_64.rpm
RUN wget --no-check-certificate https://vault.centos.org/6.7/updates/x86_64/Packages/perl-Params-Check-0.26-141.el6_7.1.x86_64.rpm && rpm -i perl-Params-Check-0.26-141.el6_7.1.x86_64.rpm && rm -f perl-Params-Check-0.26-141.el6_7.1.x86_64.rpm
RUN wget --no-check-certificate https://vault.centos.org/6.7/updates/x86_64/Packages/perl-Module-Load-Conditional-0.30-141.el6_7.1.x86_64.rpm && rpm -i perl-Module-Load-Conditional-0.30-141.el6_7.1.x86_64.rpm && rm -f perl-Module-Load-Conditional-0.30-141.el6_7.1.x86_64.rpm
RUN wget --no-check-certificate https://vault.centos.org/6.7/updates/x86_64/Packages/perl-IPC-Cmd-0.56-141.el6_7.1.x86_64.rpm && rpm -i perl-IPC-Cmd-0.56-141.el6_7.1.x86_64.rpm && rm -f perl-IPC-Cmd-0.56-141.el6_7.1.x86_64.rpm

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
