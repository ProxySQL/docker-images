FROM centos:centos8
MAINTAINER Miro Stauder <miro@sysown.com>

RUN cat /etc/redhat-release >&2

# fix keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

# fix repos
RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-*.repo
RUN sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-*.repo
RUN sed -i 's/mirror./vault./' /etc/yum.repos.d/CentOS-*.repo

RUN yum -y update

# proxysql dependencies
RUN yum -y install\
	groff-base\
	ncurses\
	perl-Carp\
	perl-Data-Dumper\
	perl-Digest\
	perl-Digest-MD5\
	perl-Encode\
	perl-Errno\
	perl-Exporter\
	perl-File-Path\
	perl-File-Temp\
	perl-Getopt-Long\
	perl-HTTP-Tiny\
	perl-IO\
	perl-MIME-Base64\
	perl-Net-SSLeay\
	perl-PathTools\
	perl-Pod-Escapes\
	perl-Pod-Perldoc\
	perl-Pod-Simple\
	perl-Pod-Usage\
	perl-Scalar-List-Utils\
	perl-Socket\
	perl-Storable\
	perl-Term-ANSIColor\
	perl-Term-Cap\
	perl-Text-ParseWords\
	perl-Text-Tabs+Wrap\
	perl-Time-Local\
	perl-URI\
	perl-Unicode-Normalize\
	perl-constant\
	perl-interpreter\
	perl-libnet\
	perl-libs\
	perl-macros\
	perl-parent\
	perl-podlators\
	perl-threads\
	perl-threads-shared
