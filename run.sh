#\bin\bash
# required
# -n docker_image_name
# -p exposed port

DATA=data
WORK=work
MEDIA=Malatesta
MEDIA2=Elements
SHM=16G
BASH=0

while getopts n:p:b:m:e:w:d:s: option; do case ${option} in
n) NAME=${OPTARG};;
p) EXPOSED_PORT=${OPTARG};;
b) BASH=${OPTARG};;
m) MEDIA=${OPTARG};;
e) MEDIA2=${OPTARG};;
w) WORK=${OPTARG};;
d) DATA=${OPTARG};;
s) SHM=${OPTARG};;
esac; done

if [ -z "$NAME" ] | [ -z "$EXPOSED_PORT" ]; then
    echo "required arguments usage ./run.sh -n <docker_image_name> -p <docker_exposed_port> [-b -m -m2 -w -d ]"
    echo "  -n $NAME (valid docker image name)"
    echo "  -p $EXPOSED_PORT (port exposed in Dockerfile)"
    echo "  [-b $BASH ([0: jupyter notebook], 1: \bin\bash)"]
    echo "  [-w $WORK (work folder [$HOME/work])"]
    echo "  [-d $DATA (data folder [$HOME/data])"]
    echo "  [-m $MEDIA (media folder [/media/$USER/Malatesta])"]
    echo "  [-e $MEDIA2 (media folder [/media/$USER/Elements] )"]
    echo "  [-s $SHM (shared memory df -h /dev/shm [16G])"]
   exit
fi

WORK=$HOME"/"$WORK
DATA=$HOME"/"$DATA
PYHIST=$HOME"/.python_history"
MEDIA=/media/$USER/$MEDIA
MEDIA2=/media/$USER/$MEDIA2

PORT=$EXPOSED_PORT

while :
do
    if [[ -z  `sudo lsof -i:$PORT` ]]; then
        break
    else
        ((PORT+=1))
    fi
done
# --network=host

if [ $BASH = 0 ]; then
    docker run --gpus all --shm-size=$SHM --publish $PORT:$EXPOSED_PORT -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $PYHIST:$PYHIST -it --rm $NAME
else
    echo "using port $PORT"
    docker run --gpus all --shm-size=$SHM --publish $PORT:$EXPOSED_PORT -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $PYHIST:$PYHIST -it --entrypoint /bin/bash --rm $NAME
fi
