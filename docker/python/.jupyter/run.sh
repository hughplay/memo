#!/bin/sh

DATA_DIR=/home/blue/data
if ! [ -d ${DATA_DIR} ]; then
    mkdir ${DATA_DIR}
fi

jupyter notebook
