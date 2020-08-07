# bash entry point
NAME="xvdp/pt1.3_tf1.14_cudagl10.0:latest"

DATA=data
WORK=work
MEDIA=Malatesta
MEDIA2=Elements
SHARE=share

while getopts u:m:w:d: option; do case ${option} in
u) USER=${OPTARG};;
m) MEDIA=${OPTARG};;
w) WORK=${OPTARG};;
d) DATA=${OPTARG};;
esac; done

WORK=$HOME"/"$WORK
DATA=$HOME"/"$DATA
SHARE=$HOME"/"$SHARE
PYHIST=$HOME"/.python_history"
MEDIA=/media/$USER/$MEDIA
MEDIA2=/media/$USER/$MEDIA2

docker run --gpus all --shm-size=16G -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $SHARE:$SHARE -v $PYHIST:$PYHIST -it --entrypoint /bin/bash --rm $NAME
# --network=host