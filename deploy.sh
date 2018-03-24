#! /usr/bin/env bash
rm -rf public
hugo
chmod -R 755 public
rsync -avzp -e ssh public/ thomascoopman.eu:/home/thomas/hugo
