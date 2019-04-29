#!/bin/bash

printHelp() {
    echo "help"
}

cleanDockerIndex() {
    docker rm -f $(docker ps -aq) > /dev/null 2>&1
    docker rmi -f $(docker images -a | grep "^<none>" | awk "{print $3}") > /dev/null 2>&1
    docker rmi -f ostis > /dev/null 2>&1
}

if [ -z "$1" ]
then
    echo "Error! Script requires path argument"
    printHelp
    exit 1
else
    path=$1
    shift
fi

port="8000"

while [ $# -gt 0 ]; do
  case "$1" in
    --noupdate*)    noupdate="true" ;;
    -n*)            noupdate="true" ;;
    --port=*)       port="${1#*=}" ;;
    -p=*)           port="${1#*=}" ;;
    -h*)            printHelp ;;
    --help*)        printHelp ;;
    *)
      echo "Error! invalid argument: $1"
      printHelp
      exit 1
    ;;
  esac
  shift
done

if ! [ "$(ls -A $path)" ]; then
    echo "The target directory $path is empty, creating .keep file"
    touch $path/.keep
fi

cleanDockerIndex

if [ -z "$noupdate" ]
then
    docker build --pull --tag ostis --file Dockerfile $path
else
    docker build --pull --tag ostis --file Dockerfile.noupdate $path
fi

docker run -p $port:8000/tcp ostis bash -c "./run.sh"
