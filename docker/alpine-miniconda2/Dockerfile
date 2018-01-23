From silverhugh/env:alpine-glibc

ENV MINICONDA_VERSION latest
ENV MINICONDA_INSTALL Miniconda2-$MINICONDA_VERSION-Linux-x86_64.sh
ENV MINICONDA_URL https://repo.continuum.io/miniconda/$MINICONDA_INSTALL

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apk --no-cache add curl \
        bash

RUN curl $MINICONDA_URL -L -o /tmp/miniconda.sh \
    && sh /tmp/miniconda.sh -f -b -p $CONDA_DIR \
    && rm -f /tmp/miniconda.sh \
    && conda install --yes conda
