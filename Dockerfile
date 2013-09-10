FROM cduez/squeeze:squeeze
MAINTAINER Allard Hoeve <allard@byte.nl>

# make sure the package repository is up to date
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/99assumeyes
RUN perl -pi -e 's/ftp.us.debian.org/ftp.nl.debian.org/g;' /etc/apt/sources.list

RUN apt-get update
RUN apt-get install curl

RUN echo "deb http://debian.byte.nl/repository/ squeeze main testing" >> /etc/apt/sources.list
RUN (echo "Package: *"; echo "Pin: release a=byte-squeeze, c=main"; echo "Pin-Priority: 700";) >> /etc/apt/preferences
RUN curl -s http://debian.byte.nl/repository/dists/Release.key | apt-key add -

RUN apt-get update
RUN apt-get dist-upgrade
RUN apt-get clean

RUN apt-get install build-essential fakeroot cowbuilder
RUN apt-get install vim-nox git ack-grep procps net-tools
