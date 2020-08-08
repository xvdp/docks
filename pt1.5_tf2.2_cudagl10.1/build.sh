#!/bin/bash
#
# ./build.sh will result in image   xvdp/<foldername>:latest
# ./build sh -n THiS -s AU -t 0.1   au/this:0.1
#
NAME=`pwd`
NAME=`basename $NAME`
AUTHOR=xvdp
TAG=latest

while getopts n:t:p: option
do
case "${option}"
in
n) NAME=${OPTARG};;
t) TAG=${OPTARG};;
a) AUTHOR=${OPTARG};;
esac
done

#lower case all
NAME=`echo "$NAME" | tr '[:upper:]' '[:lower:]'`
AUTHOR=`echo "$AUTHOR" | tr '[:upper:]' '[:lower:]'`
TAG=`echo "$TAG" | tr '[:upper:]' '[:lower:]'`

NAME=$AUTHOR"/"$NAME":"$TAG
docker build -t $NAME .



