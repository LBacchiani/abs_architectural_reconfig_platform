#!/bin/bash

# Usage: ./run_abs.sh <path_to_adaptation_technique> <path_to_system> <target_language>

# Check for required arguments
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <path_to_adaptation_technique> <path_to_system> <target_language>"
  exit 1
fi

ADAPTATION="$1"
SYS="$2"
LANG="$3"

# Validate language argument
if [[ "$LANG" != "java" && "$LANG" != "erlang" ]]; then
  echo "Unrecognized language: supported languages are 'java' and 'erlang'"
  exit 1
fi

# Run the command
if [ "$LANG" = "java" ]; then
  java -jar absfrontend.jar --java ./*.abs "$ADAPTATION"/*.abs "$ADAPTATION/$SYS"/*.abs "$ADAPTATION/$SYS"/orchestrations/*.abs -o model.jar
else
  java -jar absfrontend.jar --"$LANG" ./*.abs "$ADAPTATION"/*.abs "$ADAPTATION/$SYS"/*.abs "$ADAPTATION/$SYS"/orchestrations/*.abs
fi
