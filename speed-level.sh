function run_aom {
    INFILE="${1}"
    CPU="${2}"
    LIMIT=${3}
    IS_VERBOSE=${4}

    BIN=${BIN_aom:-aomenc}
    aom_version=`"$BIN" --help | grep av1 | cut -d ' ' -f 14`
    ENC="${ENC_aom:-aom-$aom_version}"
    LEVELS="0 8"
    NAME=`basename ${1} | cut -d . -f 1`
    OUTFILE="~/Encoded/${NAME}_${ENC}_{ss}_l${3}.ivf"
    OUT="${CPU}-${ENC}-speed-levels-${NAME}-l${3}"


    RUN="${NUMACMD} ${BIN} --tile-rows=2 --tile-columns=2 --cpu-used={ss} --threads=16 --limit=${LIMIT} -o ${OUTFILE} ${INFILE}"

    VERBOSE_ARG=
    if [[ -z ${IS_VERBOSE} ]]; then
        VERBOSE_ARG=--show-output
    fi
    hyperfine -r 2 -P ss ${LEVELS} "$RUN" --export-csv ${OUT}.csv --export-markdown ${OUT}.md ${VERBOSE_ARG}
}

function run_svt {
    INFILE="${1}"
    CPU="${2}"
    LIMIT=${3}

    BIN=${BIN_svt:-SvtAv1EncApp}
    svt_version=`"$BIN" 2>&1| grep version | cut -d " " -f 5`
    ENC="${ENC_svt:-svt_av1-$svt_version}"
    LEVELS="0 8"
    NAME=`basename ${1} | cut -d . -f 1`
    OUTFILE="~/Encoded/${NAME}_${ENC}_{ss}_l${3}.ivf"
    IS_VERBOSE=${4}
    OUT="${CPU}-${ENC}-speed-levels-${NAME}-l${3}"


    RUN="${NUMACMD} ${BIN} --preset {ss} --tile-rows 2 --tile-columns 2 --lp 16 -n ${LIMIT}  -b ${OUTFILE} -i ${INFILE}"

    VERBOSE_ARG=
    if [[ -z ${IS_VERBOSE} ]]; then
        VERBOSE_ARG=--show-output
    fi
    hyperfine -r 2 -P ss ${LEVELS} "$RUN" --export-csv ${OUT}.csv --export-markdown ${OUT}.md ${VERBOSE_ARG}
}

function run_rav1e {
    INFILE="${1}"
    CPU="${2}"
    LIMIT=${3}
    IS_VERBOSE=${4}

    BIN=${BIN_rav1e:-rav1e}
    rav1e_version=`"$BIN" --version | cut -d ' ' -f 2`
    ENC="${ENC_rav1e:-rav1e-${rav1e_version}}"
    LEVELS="0 10"
    NAME=`basename ${1} | cut -d . -f 1`
    OUTFILE="~/Encoded/${NAME}_${ENC}_{ss}_l${3}.ivf"
    OUT="${CPU}-${ENC}-speed-levels-${NAME}-l${3}"


    $BIN --version | grep 0.3 -q || OVERRIDE=-y

    RUN="${NUMACMD} ${BIN} --threads 8 --tiles 16 -l ${LIMIT} -s {ss} -o ${OUTFILE} ${INFILE} ${OVERRIDE}"

    VERBOSE_ARG=
    if [[ -z ${IS_VERBOSE} ]]; then
        VERBOSE_ARG=--show-output
    fi
    hyperfine -r 2 -P ss $LEVELS "$RUN" --export-csv ${OUT}.csv --export-markdown ${OUT}.md ${VERBOSE_ARG}
}
