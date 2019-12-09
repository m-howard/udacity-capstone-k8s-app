#!/usr/bin/env bash

usage="usage $(basename "$0") path [aws-cli-opts]

where:
  path - path to cloudformation file or directory relative to the root of the repository. Do not include a \"./\".
"

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$1" == "help" ] || [ "$1" == "usage" ] ; then
  echo "$usage"
  exit -1
fi

if [ -z "$1" ] ; then
  echo "$usage"
  exit -1
fi

shopt -s failglob
set -eu -o pipefail

echo "Checking if argument is a directory or file..."

if [[ -f "$1" ]] ; then 

  echo -e "\nFile argement detected..."
  if [[ $1 == *.template ]] || [[ $1 == *.yaml ]] ; then

    aws cloudformation validate-template \
      --template-body file://${1} ${@:2}

  else

    echo -e "\nFile mast have the \".tamplate\" or \".yaml\" extention"

  fi
elif [[ -d "$1" ]] ; then

  echo -e "\nDirectory argument detected"
  find ./$1 \( -name "*.template" -or -name "*.yaml" \) -print | \
    cut -c3- | \
    xargs -I{} \
    aws cloudformation validate-template \
      --template-body file://{} ${@:2}

else

  echo -e "\nPath provided is invalid or does not exist."
  exit 1

fi

echo "Finished valdiating successfully!"