#\bin\bash
EXPOSED_PORT=-1
if [ $1 = "xvdp/pt1.3_tf1.14_cudagl10.0" ]; then
    EXPOSED_PORT=8888
elif [ $1 = "xvdp/pt1.5_tf2.2_cudagl10.1" ]; then 
    EXPOSED_PORT=9999
elif [ $1 = "xvdp/pt1.6_tf2.2_cudagl10.2" ]; then 
    EXPOSED_PORT=7777
else
    echo "NO DEFAULT PORT ASSIGNED FOR IMAGE <$1>, EDIT ports.sh"
fi