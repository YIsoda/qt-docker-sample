FROM ubuntu:18.04

RUN apt update \
	&& apt install -y mingw-w64 \
	&& apt install -y git
        && apt install -y build-essential
RUN git clone https://code.qt.io/qt/qt5.git
WORKDIR /qt5/
RUN git status
RUN git checkout 5.14
RUN ./init-repository
RUN ./configure
RUN make
RUN make install
RUN /usr/local/Qt-5.14.1/bin/qmake --version
