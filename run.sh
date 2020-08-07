#\bin\bash
# Args
# required
# -n docker_image_name
# optional
# -b0 jupyter
# -b1 run as bash
# -b2 run as python

# Examples
# jupyter
# ./run.sh -n xvdp/pt1.3_tf1.14_cudagl10.0
# ./run.sh -n xvdp/pt1.5_tf2.2_cudagl10.1
# ./run.sh -n xvdp/pt1.6_tf2.2_cudagl10.2 
# bash
# ./run.sh -n xvdp/pt1.3_tf1.14_cudagl10.0 -b1
# ./run.sh -n xvdp/pt1.5_tf2.2_cudagl10.1 -b1
# ./run.sh -n xvdp/pt1.6_tf2.2_cudagl10.2  -b1
# python
# ./run.sh -n xvdp/pt1.3_tf1.14_cudagl10.0 -b2
# ./run.sh -n xvdp/pt1.5_tf2.2_cudagl10.1 -b2
# ./run.sh -n xvdp/pt1.6_tf2.2_cudagl10.2 -b2
#

BASH=0
source config.sh

while getopts n:b: option; do case ${option} in
n) NAME=${OPTARG};;
b) BASH=${OPTARG};;
esac; done

if [ -z "$NAME" ]; then
    echo "required argument usage ./run.sh -n <docker_image_name> "
    echo "  -n $NAME (valid docker image name)"
    echo "  -b $BASH ([0: jupyter notebook], 1: \bin\bash, 2: python)"
   exit
fi

# --network=host

# jupyter
if [ $BASH = 0 ]; then
    if [ $NAME = "xvdp/pt1.3_tf1.14_cudagl10.0" ]; then
        EXPOSED_PORT=8888
    elif [ $NAME = "xvdp/pt1.5_tf2.2_cudagl10.1" ]; then 
        EXPOSED_PORT=9999
    elif [ $NAME = "xvdp/pt1.6_tf2.2_cudagl10.2" ]; then 
        EXPOSED_PORT=7777
    else
        echo "Validate export port in Dockerfile for $NAME"
        exit
    fi

    PORT=$EXPOSED_PORT
    # find first open port
    while :
    do
        if [[ -z  `sudo lsof -i:$PORT` ]]; then
            break
        else
            ((PORT+=1))
        fi
    done

    echo "using port $PORT"
    docker run --gpus all --shm-size=$SHM -p $PORT:$EXPOSED_PORT -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $SHARE:$SHARE -v $PYHIST:$PYHIST -it --rm $NAME
elif [ $BASH = 2 ]; then
    # python
    docker run --gpus all --shm-size=$SHM -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $SHARE:$SHARE -v $PYHIST:$PYHIST -it --entrypoint python --rm $NAME
else
    # bash
    docker run --gpus all --shm-size=$SHM -v $DATA:$DATA -v $WORK:$WORK -v $MEDIA:$MEDIA -v $MEDIA2:$MEDIA2 -v $SHARE:$SHARE -v $PYHIST:$PYHIST -it --entrypoint /bin/bash --rm $NAME
fi
