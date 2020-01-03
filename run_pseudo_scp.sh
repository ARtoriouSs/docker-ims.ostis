#!/bin/bash

printHelp() {
  cat << EOM

Usage: ./run.sh PATH [OPTIONS]

PATH: Absolute or relative path to directory with pseudo-scp code and tests.

OPTIONS:
  --help -h       Shows this message.
  --noupdate -n   Prevents container from updating repositories.

EOM
}

cleanDockerIndex() {
  docker rm -f $(docker ps -aq) > /dev/null 2>&1
  docker rmi -f $(docker images -a | grep "^<none>" | awk "{print $3}") > /dev/null 2>&1
  docker rmi -f ostis > /dev/null 2>&1
}

if [ -z "$1" ]; then
  echo "Error: script requires code path argument"
  printHelp
  exit 1
fi

if [[ -d "$1" ]]; then
  path_to_code=$1
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

executable="wave"
tests_dir="graph"

while [ $# -gt 0 ]; do
  case "$1" in
    --noupdate*)    noupdate="true" ;;
    -n*)            noupdate="true" ;;
    --executable*)  executable="${1#*=}" ;;
    -e*)            executable="${1#*=}" ;;
    --tests-dir*)   tests_dir="${1#*=}" ;;
    -t*)            tests_dir="${1#*=}" ;;
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

if ! [[ -f "$path_to_code/CMakeLists.txt" ]]; then
  echo "The code directory $path_to_code should contain CMakeLists.txt file. Aborting..."
  exit 1
fi

if ! [[ -d "$path_to_code/$tests_dir" ]]; then
  echo "The code directory $path_to_code should contain graph directory with tests. Aborting..."
  exit 1
fi

cleanDockerIndex

if [ -z "$noupdate" ]
then
  docker build --pull --tag ostis --file Dockerfile.pseudo-scp $path_to_code
else
  docker build --pull --tag ostis --file Dockerfile.pseudo-scp.noupdate $path_to_code
fi

docker run -e "EXECUTABLE_NAME=$executable" -e "TESTS_DIR=$tests_dir" ostis bash -c "./run_pseudo_scp.sh"

cleanDockerIndex
