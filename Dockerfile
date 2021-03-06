FROM ubuntu:18.04

# RUN apt install sudo

RUN grep '^deb ' /etc/apt/sources.list | \
	sed 's/^deb /deb-src /g' | \
	tee /etc/apt/sources.list.d/deb-src.list

RUN apt update -qq \
	&& apt install -y tzdata \
	&& apt install -y software-properties-common
RUN apt update -qq \
	&& apt-get -y build-dep qt5-default \
	&& apt install -y libxcb-xinerama0-dev \
	&& apt install -qq -y mingw-w64 \
	&& apt install -y build-essential perl python git \
	&& apt install -y expect

RUN git clone https://code.qt.io/qt/qt5.git
WORKDIR /qt5/
RUN git status
RUN git checkout 5.14
RUN ./init-repository
WORKDIR /
RUN mkdir build
WORKDIR /build/
RUN ../qt5/configure -confirm-license -v -opensource -nomake examples -nomake tests
RUN make
RUN make install
RUN /usr/local/Qt-5.14.1/bin/qmake --version
