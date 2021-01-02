function aom {
    INFILE="${1}"
    CPU="${2}"
    LIMIT=${3}
    ENC="aom"
    LEVELS="0 8"
    NAME=`basename ${1} | cut -d . -f 1`
    OUTFILE="~/Encoded/${NAME}_${ENC}_{ss}_l${3}.ivf"
    OUT="${CPU}-${ENC}-speed-levels-${NAME}"

    BIN=${BIN_aom:-aomenc}

    RUN="${NUMACMD} ${BIN} --tile-rows=2 --tile-columns=2 --cpu-used={ss} --threads=16 --limit=${LIMIT} -o ${OUTFILE} ${INFILE}"

    hyperfine -r 2 -P ss ${LEVELS} "$RUN" --export-csv ${OUT}.csv --export-markdown ${OUT}.md
}

function svt {
    INFILE="${1}"
    CPU="${2}"
    LIMIT=${3}
    ENC="svt_av1"
    LEVELS="0 8"
    NAME=`basename ${1} | cut -d . -f 1`
    OUTFILE="~/Encoded/${NAME}_${ENC}_{ss}_l${3}.ivf"
    OUT="${CPU}-${ENC}-speed-levels-${NAME}"

    BIN=${BIN_svt:-SvtAv1EncApp}

    RUN="${NUMACMD} ${BIN} --preset {ss} --tile-rows 2 --tile-columns 2 --lp 16 -n ${LIMIT}  -b ${OUTFILE} -i ${INFILE}"

    hyperfine -r 2 -P ss ${LEVELS} "$RUN" --export-csv ${OUT}.csv --export-markdown ${OUT}.md
}

function rav1e {
    INFILE="${1}"
    CPU="${2}"
    LIMIT=${3}
    ENC="rav1e"
    LEVELS="0 10"
    NAME=`basename ${1} | cut -d . -f 1`
    OUTFILE="~/Encoded/${NAME}_${ENC}_{ss}_l${3}.ivf"
    OUT="${CPU}-${ENC}-speed-levels-${NAME}"

    BIN=${BIN_rav1e:-rav1e}

    RUN="${NUMACMD} ${BIN} --threads 16 --tiles 16 -l ${LIMIT} -s {ss} -o ${OUTFILE} ${INFILE} -y"

    hyperfine -r 2 -P ss $LEVELS "$RUN" --export-csv ${OUT}.csv --export-markdown ${OUT}.md
}

mkdir -p ~/Encoded

for enc in aom svt rav1e; do
    $enc ${1} ${2} ${3}
done

python merge_all.py ${1} ${2} ${3}
