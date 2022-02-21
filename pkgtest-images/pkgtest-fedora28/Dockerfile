FROM fedora:28
MAINTAINER Miro Stauder <miro@sysown.com>

RUN cat /etc/redhat-release >&2

RUN dnf makecache && dnf -y update

# proxysql dependencies
RUN dnf -y install\
	libstdc++\
	perl-Carp\
	perl-Errno\
	perl-Exporter\
	perl-File-Path\
	perl-IO\
	perl-PathTools\
	perl-Scalar-List-Utils\
	perl-Socket\
	perl-Text-Tabs+Wrap\
	perl-Unicode-Normalize\
	perl-constant\
	perl-interpreter\
	perl-libs\
	perl-macros\
	perl-parent\
	perl-threads\
	perl-threads-shared
