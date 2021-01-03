. speed-level.sh

input=${1}
cpu=${2}
limit=${3}

shift 3

for enc in ${@}; do
    ENC_svt=svt-`$enc 2>&1| grep version | cut -d " " -f 5`
    BIN_svt=$enc
    svt $input $cpu $limit
done
