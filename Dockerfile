FROM ubuntu:18.04

RUN apt update \
	&& apt install -y mingw-w64 \
	&& apt install -y git

RUN git clone https://code.qt.io/qt/qt5.git
RUN cd qt5
RUN git checkout v5.14.1
RUN ./init-repository
RUN ./configure
RUN make
RUN make install
RUN /usr/local/Qt-5.14.1/bin/qmake --version