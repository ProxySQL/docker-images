FROM fedora:38
MAINTAINER Miro Stauder <miro@sysown.com>

RUN cat /etc/redhat-release >&2

RUN dnf makecache && dnf -y update

# proxysql dependencies
RUN dnf -y install\
	groff-base\
	ncurses\
	perl-AutoLoader\
	perl-B\
	perl-Carp\
	perl-Class-Struct\
	perl-Data-Dumper\
	perl-Digest\
	perl-Digest-MD5\
	perl-DynaLoader\
	perl-Encode\
	perl-Errno\
	perl-Exporter\
	perl-Fcntl\
	perl-File-Basename\
	perl-File-Path\
	perl-File-Temp\
	perl-File-stat\
	perl-FileHandle\
	perl-Getopt-Long\
	perl-Getopt-Std\
	perl-HTTP-Tiny\
	perl-IO\
	perl-IO-Socket-IP\
	perl-IPC-Open3\
	perl-MIME-Base64\
	perl-Net-SSLeay\
	perl-POSIX\
	perl-PathTools\
	perl-Pod-Escapes\
	perl-Pod-Perldoc\
	perl-Pod-Simple\
	perl-Pod-Usage\
	perl-Scalar-List-Utils\
	perl-SelectSaver\
	perl-Socket\
	perl-Storable\
	perl-Symbol\
	perl-Term-ANSIColor\
	perl-Term-Cap\
	perl-Text-ParseWords\
	perl-Text-Tabs+Wrap\
	perl-Time-Local\
	perl-URI\
	perl-base\
	perl-constant\
	perl-if\
	perl-interpreter\
	perl-libnet\
	perl-libs\
	perl-mro\
	perl-overload\
	perl-overloading\
	perl-parent\
	perl-podlators\
	perl-subs\
	perl-vars
