#!/bin/bash

if [ -z "$1" ]
then
    echo "Script requires path argument! Usage: './run.sh /path/to/kb [noupdate]'."
    exit
fi

if ! [ "$(ls -A $1)" ]; then
    echo "The target directory $1 is empty, creating .keep file"
    touch $1/.keep
fi

docker rm -f $(docker ps -aq) > /dev/null 2>&1
docker rmi -f $(docker images -a | grep "^<none>" | awk "{print $3}") > /dev/null 2>&1
docker rmi -f ostis > /dev/null 2>&1

if [ "$2" == "noupdate" ]
then
    docker build --pull --tag ostis --file Dockerfile.noupdate $1
else
    docker build --pull --tag ostis --file Dockerfile $1
fi

docker run -p 8000:8000/tcp ostis bash -c "./run.sh"
