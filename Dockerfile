FROM ubuntu:14.04.2
MAINTAINER Owen Ouyang "owen.ouyang@live.com"

RUN dpkg --add-architecture i386 
RUN dpkg -S add-apt-repository
RUN add-apt-repository "deb http://archive.canonical.com/ trusty partner"
RUN apt-get update
RUN apt-get install -y nano 
RUN apt-get install -y curl 
RUN apt-get install -y git 
RUN apt-get install -y xvfb
RUN apt-get install -y x11vnc
RUN apt-get install -y dbus
RUN apt-get install -y python 
RUN apt-get install -y python-setuptools 
RUN apt-get install -y python-pip gdebi-core
RUN apt-get install -y iso-codes
RUN apt-get install -y fluxbox
RUN apt-get install -y libpython2.7
RUN apt-get install -y python-gobject-2
RUN apt-get install -y skype

# Clean up any files used by apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone git://github.com/jmandel/sevabot.git
RUN cd sevabot && git checkout custom && python setup.py develop

ADD start.sh /usr/bin/start
ADD configure.sh /usr/bin/configure
RUN chmod +x /usr/bin/start /usr/bin/configure
CMD /usr/bin/configure
