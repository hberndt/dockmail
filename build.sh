#!/bin/bash
cd mailserver
IMAGE=dockmail
ACCOUNT=hberndt
TAG_SHORT=1.0
docker build --rm=true -t="${ACCOUNT}/$IMAGE" .
DATE=`date +'%Y%m%d%H%M'`
IID=$(docker inspect -f "{{.Id}}" ${ACCOUNT}/$IMAGE)
docker tag $IID ${ACCOUNT}/$IMAGE:$DATE
docker tag $IID ${ACCOUNT}/$IMAGE:$TAG_SHORT

cd ../mailpile
IMAGE=mailpile
ACCOUNT=hberndt
TAG_SHORT=1.0
docker build --rm=true -t="${ACCOUNT}/$IMAGE" .
DATE=`date +'%Y%m%d%H%M'`
IID=$(docker inspect -f "{{.Id}}" ${ACCOUNT}/$IMAGE)
docker tag $IID ${ACCOUNT}/$IMAGE:$DATE
docker tag $IID ${ACCOUNT}/$IMAGE:$TAG_SHORT

cd ..
