# Version: 0.0.1 - Certified Asterisk 13.1-cert2 with sip and pjsip
FROM debian:latest
MAINTAINER David Muñoz "david@quaip.com" & Enrique Morón "enrique@quaip.com"
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential openssl libjansson-dev sqlite \
                       libxml2-dev libncurses5-dev uuid-dev sqlite3 libsqlite3-dev pkg-config \
                       wget vim subversion git aptitude libreadline-dev libreadline6-dev \
                       libiksemel-dev libvorbis-dev libssl-dev libspeex-dev libspeexdsp-dev \ 
                       mpg123 libmpg123-0 sox libsrtp0-dev \
                   && apt-get autoclean \
                   && apt-get autoremove \
                   && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src
RUN git clone https://github.com/asterisk/pjproject pjproject
WORKDIR pjproject
RUN ./configure --prefix=/usr --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr CFLAGS='-O2 -DNDEBUG'
RUN make dep &&  make && make install && ldconfig
WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/certified-asterisk-13.1-current.tar.gz \
&& tar -zxvf certified-asterisk-13.1-current.tar.gz
WORKDIR /usr/src/certified-asterisk-13.1-cert2
RUN sh contrib/scripts/get_mp3_source.sh
RUN ./configure CFLAGS='-g -O2 -mtune=native' --libdir=/usr/lib
COPY menuselect.makeopts /usr/src/certified-asterisk-13.1-cert2/menuselect.makeopts
RUN sed -i '/NATIVE_ARCH=/c \NATIVE_ARCH=0' /usr/src/certified-asterisk-13.1-cert2/build_tools/menuselect-deps
RUN make && make install && make samples
WORKDIR /root

EXPOSE 5060/udp
EXPOSE 10000:10010/udp
CMD ["/usr/sbin/asterisk", "-vvvvvvv"]
