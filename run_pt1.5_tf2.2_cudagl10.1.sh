# bash entry point
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

docker run --gpus all --shm-size=16G -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $PYHIST:$PYHIST -it --entrypoint /bin/bash --rm $NAME
# --network=host