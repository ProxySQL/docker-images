FROM opensuse/leap:15
MAINTAINER Miro Stauder <miro@sysown.com>

RUN zypper update -y

# install systemd
RUN zypper install -y dbus-1 systemd-sysvinit
RUN cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/; \
    sed -i 's/OOMScoreAdjust=-900//' /etc/systemd/system/dbus.service

# runtime dependencies
RUN zypper install -y\
	gnutls
