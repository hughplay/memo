From silverhugh/alpine-miniconda2

COPY requirements.txt /tmp/requirements.txt

RUN apk add --no-cache --virtual .build-dependencies \
        g++

# Install packages for Python 2
RUN pip install -r /tmp/requirements.txt --no-cache-dir

# Install packages for Python 3
RUN conda create -n py3 python=3.5 \
    && source activate py3 \
    && pip install -r /tmp/requirements.txt --no-cache-dir \
    && source deactivate

# Create ipykernels
# Python 2 has been set by conda already
RUN source activate py3 \
    && python -m ipykernel install --name py3 --display-name "Python 3"

RUN apk add --no-cache --virtual .build-dependencies \
        git

RUN jupyter contrib nbextension install --system \
    && cd /usr/local/share/jupyter/nbextensions \
    && git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding

RUN rm -f /tmp/requirements.txt \
    && apk del .build-dependencies

# Run app with non-root user
RUN UID=1014 \
    && adduser -D -u $UID blue

USER blue

WORKDIR /home/blue

COPY .jupyter .jupyter
