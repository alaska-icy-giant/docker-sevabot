FROM quay.io/oouyang/skype
MAINTAINER Owen Ouyang "owen.ouyang@live.com"

#RUN dpkg -S add-apt-repository
RUN apt-get update && \
    apt-get install -y nano \
                       curl \
                       git \
                       xvfb \
                       x11vnc \
                       dbus \
                       python \ 
                       python-setuptools \
                       python-pip \
                       iso-codes \
                       fluxbox \
                       libpython2.7 \
                       python-gobject-2

# Clean up any files used by apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD start.sh /usr/bin/start
ADD configure.sh /usr/bin/configure
RUN chmod +x /usr/bin/start /usr/bin/configure

RUN groupadd -r skype -g 1000 && useradd -r -u 1000 -s /bin/bash -m -g skype skype
RUN echo "skype ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER skype
WORKDIR /home/skype

RUN git clone git://github.com/jmandel/sevabot.git
RUN cd sevabot && git checkout custom && python setup.py develop

CMD /usr/bin/configure
