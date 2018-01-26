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

RUN rm -f /tmp/requirements.txt \
    && apk del .build-dependencies


# Create ipykernels
RUN python -m ipykernel install --name py2 --display-name "Python2" \
    && source activate py3 \
    && python -m ipykernel install --name py3 --display-name "Python3"

RUN adduser -D -u 1000 blue

USER blue

WORKDIR /home/blue

