From silverhugh/env:alpine-glibc

ENV MINICONDA_VERSION latest
ENV MINICONDA_INSTALL Miniconda2-$MINICONDA_VERSION-Linux-x86_64.sh
ENV MINICONDA_URL https://repo.continuum.io/miniconda/$MINICONDA_INSTALL

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV NB_UID 1000
ENV NB_USER blue
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apk --no-cache add curl \
        bash

# Create user
RUN adduser -D -u $NB_UID $NB_USER \
    && mkdir -p $CONDA_DIR \
    && chown $NB_USER $CONDA_DIR

USER $NB_USER

RUN curl $MINICONDA_URL -L -o /tmp/miniconda.sh \
    && sh /tmp/miniconda.sh -f -b -p $CONDA_DIR \
    && rm -f /tmp/miniconda.sh \
    && conda install --yes conda
