# jupyter entrypoint
NAME="xvdp/pt1.5_tf2.2_cudagl10.1:latest"

DATA=data
WORK=work
MEDIA=Malatesta
MEDIA2=Elements

while getopts u:m:w:d: option; do case ${option} in
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

EXPOSED_PORT=9999
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

docker run --gpus all --shm-size=16G --publish $PORT:$EXPOSED_PORT -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $PYHIST:$PYHIST -it --rm $NAME
# --network=host
