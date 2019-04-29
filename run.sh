#!/bin/bash

printHelp() {
    cat << EOM

Usage: ./run.sh PATH [OPTIONS]

PATH: Absolute or relative path to directory with kb files.

OPTIONS:
    --help -h       Shows this message.
    --noupdate -n   Prevents container from updating repositories.
    --port= -p=     Sets the server port equal to given value.

EOM
}

cleanDockerIndex() {
    docker rm -f $(docker ps -aq) > /dev/null 2>&1
    docker rmi -f $(docker images -a | grep "^<none>" | awk "{print $3}") > /dev/null 2>&1
    docker rmi -f ostis > /dev/null 2>&1
}

if [ -z "$1" ]
then
    echo "Error: script requires path argument"
    printHelp
    exit 1
fi

if [[ -d "$1" ]]; then
    path=$1
    shift
else
    if [[ $1 = "-h" || $1 = "--help" ]]; then
        printHelp
        exit 0
    else
        echo "Error: $1 is not a directory"
        printHelp
        exit 1
    fi
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
        echo "Error: invalid argument: $1"
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
