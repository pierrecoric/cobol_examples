#!/bin/bash

set -a
source "$(dirname "$0")/.env"
set +a

DS="$ZOWE_USER.COVID.CSV"
JCL="$ZOWE_USER.JCL(COVIDJ)"

spinner() {
    local pid=$1
    local frames='.*oO080Oo*'
    local i=0
    echo "Running job"
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r%s" "${frames:i++%${#frames}:1}"
        sleep 0.05
    done
    printf "\r  Job finished.        \n"
}

echo "Hello, this is my answer to the covid challenge."
echo "Do you wish to do that all thing? (y/n)"

read ans

if [ "$ans" = "y" ]; then
    echo "oh nice"
    rm 8_COVID/output.txt
    touch 8_COVID/output.txt
    zowe zos-files delete data-set -f "$DS"
    zowe zos-files create data-set-sequential "$DS" --record-format FB --record-length 150 --block-size 30000 --size 10TRK
    zowe files ul ftds "8_COVID/covidReport.csv" "$DS"

    tmp=$(mktemp)
    zowe zos-jobs submit data-set "$JCL" --wfo --rff jobid --rft string > "$tmp" &
    spinner $!
    jobid=$(cat "$tmp")
    rm "$tmp"

    echo "Job ID: $jobid"
    zowe zos-jobs view spool-file-by-id "$jobid" 104 > 8_COVID/output.txt

elif [ "$ans" = "n" ]; then
    echo "oh bugger!"
else
    echo "???"
fi