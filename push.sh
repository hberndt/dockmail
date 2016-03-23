#!/bin/bash

IMAGE=dockmail
ACCOUNT=hberndt
TAG_SHORT=1.0
docker push ${ACCOUNT}/$IMAGE:latest
docker push ${ACCOUNT}/$IMAGE:$TAG_SHORT

IMAGE=mailpile
ACCOUNT=hberndt
TAG_SHORT=1.0
docker push ${ACCOUNT}/$IMAGE:latest
docker push ${ACCOUNT}/$IMAGE:$TAG_SHORT
