. speed-level.sh

input=${1}
cpu=${2}
limit=${3}

shift 3

for enc in ${@}; do
    ENC_rav1e=rav1e-`$enc --version | cut -d ' ' -f 2`
    BIN_rav1e=$enc
    run_rav1e $input $cpu $limit
done
