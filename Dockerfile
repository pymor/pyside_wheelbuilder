FROM quay.io/pypa/manylinux1_x86_64

MAINTAINER René Milk <rene.milk@wwu.de>

ADD entrypoint.sh /usr/local/bin/

RUN yum install -y atlas-devel openmpi-devel sudo \
        fltk freeglut libpng libjpeg \
        tk tcl xorg-x11-server-Xvfb xauth \
        cmake

ENV MPICC /usr/lib64/openmpi/1.4-gcc/bin/mpicc

RUN yum install -y gpg && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64.asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && rm -r /root/.gnupg/ \
    && chmod +x /usr/local/bin/gosu

RUN cd /tmp && wget --no-check-certificate https://download.qt.io/archive/qt/4.8/4.8.6/qt-everywhere-opensource-src-4.8.6.tar.gz && \
    tar xfz qt-everywhere-opensource-src-4.8.6.tar.gz && \
    cd qt-everywhere-opensource-src-4.8.6 && \
    ./configure -confirm-license -opensource -prefix /usr/local -release -shared -nomake examples && \
    gmake -j 6 && gmake install
#
RUN yum -y install libxml2-python.x86_64 libxml2-devel.x86_64 libxslt-python.x86_64 \
            libxslt-devel.x86_64
ADD build-wheels.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/local/bin/build-wheels.sh"]
