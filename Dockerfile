FROM ubuntu:14.04.2
MAINTAINER Owen Ouyang "owen.ouyang@live.com"

RUN dpkg --add-architecture i386 && \
#RUN dpkg -S add-apt-repository
    apt-get update && \
    apt-get install -y nano 
                       curl \
                       git \
                       xvfb \
                       x11vnc \
                       dbus \
                       python \ 
                       python-setuptools \
                       python-pip \
                       gdebi-core \
                       iso-codes \
                       fluxbox \
                       libpython2.7 \
                       python-gobject-2

RUN git clone git://github.com/jmandel/sevabot.git
RUN cd sevabot && git checkout custom && python setup.py develop

RUN apt-get update
RUN add-apt-repository "deb http://archive.canonical.com/ trusty partner"
RUN apt-get install -y skype

# Clean up any files used by apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD start.sh /usr/bin/start
ADD configure.sh /usr/bin/configure
RUN chmod +x /usr/bin/start /usr/bin/configure
CMD /usr/bin/configure
