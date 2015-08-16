FROM ubuntu:14.04.2
MAINTAINER Owen Ouyang "owen.ouyang@live.com"

RUN dpkg --add-architecture i386 && \
    add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" && \
    apt-get update && \
    apt-get install -y nano curl git xvfb x11vnc dbus \
        python python-setuptools python-pip gdebi-core \
        gcc-4.6-base:i386 iso-codes fluxbox \
        libpython2.7 python-gobject-2 skype && \
    git clone git://github.com/jmandel/sevabot.git && \
    cd sevabot && git checkout custom && python setup.py develop && \

# Clean up any files used by apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD start.sh /usr/bin/start
ADD configure.sh /usr/bin/configure
RUN chmod +x /usr/bin/start /usr/bin/configure
CMD /usr/bin/configure
