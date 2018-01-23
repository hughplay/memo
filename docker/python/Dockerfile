From silverhugh/alpine-miniconda2

COPY requirements.txt /tmp/requirements.txt

RUN apk add --no-cache --virtual .build-dependencies g++ \
    && pip install -r /tmp/requirements.txt --no-cache-dir \
    && rm -f /tmp/requirements.txt \
    && apk del .build-dependencies
