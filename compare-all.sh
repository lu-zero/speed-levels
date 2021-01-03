. speed-level.sh

for enc in aom svt rav1e; do
    $enc ${1} ${2} ${3}
done
