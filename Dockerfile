FROM ubuntu:14.04.2
MAINTAINER Owen Ouyang "owen.ouyang@live.com"

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y nano curl git xvfb x11vnc dbus \
        python python-setuptools python-pip gdebi-core \
        gcc-4.6-base:i386 iso-codes fluxbox \
        libpython2.7 python-gobject-2 && \
    curl -L http://www.skype.com/go/getskype-linux-beta-ubuntu-64 -o skype-linux-beta.deb && \
    git clone git://github.com/jmandel/sevabot.git && \
    cd sevabot && git checkout custom && python setup.py develop && \
    gdebi --non-interactive skype-linux-beta.deb
ADD start.sh /usr/bin/start
ADD configure.sh /usr/bin/configure
RUN chmod +x /usr/bin/start /usr/bin/configure
CMD /usr/bin/configure
