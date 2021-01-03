. speed-level.sh

input=${1}
cpu=${2}
limit=${3}

shift 3

for enc in ${@}; do
    BIN_svt=$enc
    run_svt $input $cpu $limit
done
