. speed-level.sh

input=${1}
cpu=${2}
limit=${3}

shift 3

for enc in ${@}; do
    BIN_aom=$enc
    run_aom $input $cpu $limit
done
