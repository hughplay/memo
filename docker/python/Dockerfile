From silverhugh/env:alpine-miniconda2

User root

RUN sudo apk add --virtual .build-dependencies gcc

COPY requirements.txt /tmp/requirements.txt

    && pip install -r /tmp/requirements.txt --no-cache-dir \
    && rm -f /tmp/requirements.txt \

User root

RUN apk del .build-dependencies
