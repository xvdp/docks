
NAME="xvdp/cudagl10.0_conda"
DATA=data
WORK=work
MEDIA=Malatesta
PORT=8888

while getopts u:m:w:d:p: option; do case ${option} in
n) NAME=${OPTARG};;
u) USER=${OPTARG};;
m) MEDIA=${OPTARG};;
w) WORK=${OPTARG};;
d) DATA=${OPTARG};;
p) PORT=${OPTARG};;
esac; done

WORK=$HOME"/"$WORK
DATA=$HOME"/"$DATA
PYHIST=$HOME"/.python_history"

# if [ ! -f ".abh1_bash_history" ]; then
#     " " > .abh1_bash_history
# fi
#  -v ".abh1_bash_history":/root/".bash_history"

docker run --gpus all --publish $PORT:$PORT -it -v $DATA:$DATA -v $WORK:$WORK  \
 -v /media/$USER/$MEDIA:/$MEDIA -v $PYHIST:$PYHIST --rm $NAME

