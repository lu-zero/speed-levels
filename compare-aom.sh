. speed-level.sh

input=${1}
cpu=${2}
limit=${3}

shift 3

for enc in ${@}; do
    ENC_aom=aom-`$enc --help | grep av1 | cut -d ' ' -f 14`
    BIN_aom=$enc
    aom $input $cpu $limit
done
