#!/bin/bash

if [[ $1 = "-h" || $1 = "--help" ]]; then
  printf "\nUsage: ./clean.sh - Removes ALL docker containers and all <none> or 'ostis' taged images\n\n"
  exit 0
fi

echo "Cleaning..."

kill -9 $(pgrep "run.sh") > /dev/null 2>&1

docker rm -f $(docker ps -aq) > /dev/null 2>&1
docker rmi -f $(docker images -a | grep "^<none>" | awk "{print $3}") > /dev/null 2>&1
docker rmi -f ostis > /dev/null 2>&1

echo "Done!"
