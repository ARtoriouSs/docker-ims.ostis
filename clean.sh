#!/bin/bash

echo "Cleaning..."

kill -9 $(pgrep "run.sh") > /dev/null 2>&1

docker rm -f $(docker ps -aq) > /dev/null 2>&1
docker rmi -f $(docker images -a | grep "^<none>" | awk "{print $3}") > /dev/null 2>&1
docker rmi -f ostis > /dev/null 2>&1

echo "Done!"
