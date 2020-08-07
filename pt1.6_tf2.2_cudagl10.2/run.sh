#\bin\bash
# option if bash=1 run bash else jupyter
BASH=0
EXPOSED_PORT=7777

NAME=`pwd`
NAME=`basename $NAME`
AUTHOR=xvdp
TAG=latest

#lower case all
NAME=`echo "$NAME" | tr '[:upper:]' '[:lower:]'`
AUTHOR=`echo "$AUTHOR" | tr '[:upper:]' '[:lower:]'`
TAG=`echo "$TAG" | tr '[:upper:]' '[:lower:]'`
NAME=$AUTHOR"/"$NAME":"$TAG

DATA=data
WORK=work
MEDIA=Malatesta
MEDIA2=Elements

while getopts b:u:m:w:d: option; do case ${option} in
b) BASH=${OPTARG};;
u) USER=${OPTARG};;
m) MEDIA=${OPTARG};;
w) WORK=${OPTARG};;
d) DATA=${OPTARG};;
esac; done

WORK=$HOME"/"$WORK
DATA=$HOME"/"$DATA
PYHIST=$HOME"/.python_history"
MEDIA=/media/$USER/$MEDIA
MEDIA2=/media/$USER/$MEDIA2


# if [ ! -f ".abh1_bash_history" ]; then
#     " " > .abh1_bash_history
# fi
#  -v ".abh1_bash_history":/root/".bash_history"

if [ $BASH = 0 ]; then
    PORT=$EXPOSED_PORT
    while :
    do
        if [[ -z  `sudo lsof -i:$PORT` ]]; then
            break
        else
            ((PORT-=1))
        fi
    done
    echo "Using Port: $PORT"
    unset BASH
    docker run --gpus all --shm-size=16G --publish $PORT:$EXPOSED_PORT -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $PYHIST:$PYHIST -it --rm $NAME
else
    unset BASH
    docker run --gpus all --shm-size=16G -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $PYHIST:$PYHIST -it --entrypoint /bin/bash --rm $NAME
fi