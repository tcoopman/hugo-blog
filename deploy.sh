#! /usr/bin/env bash

set -ex

rm -rf public
mkdir -p public
hugo --buildDrafts
chmod -R 755 public
docker build . -t eu.gcr.io/infinitetree/hugo
docker push eu.gcr.io/infinitetree/hugo

ssh infinitetree.eu << EOF
set -ex
cd traefik
docker-compose pull blog
docker-compose up -d --build blog
EOF
