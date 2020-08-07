
# TODO add EXPOSED_PORT by name 
# TPDP pass --build-arg EXPOSED_PORT=<> --build-arg WORK=$WORK
# main working folder
WORK="$HOME/work"
# main data folder
DATA="$HOME/data"
# other folders
MEDIA="/media/$USER/Malatesta"
MEDIA2="/media/$USER/Elements"
SHARE="$HOME/share"
# shared memory
SHM=`df -h /dev/shm | awk '{print $2}' | sed -n 2p`
# histories
PYHIST=$HOME"/.python_history"