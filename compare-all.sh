. speed-level.sh

for enc in run_aom run_rav1e run_svt; do
    $enc ${1} ${2} ${3} ${4}
done
