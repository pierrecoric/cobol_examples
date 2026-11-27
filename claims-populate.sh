#!/bin/bash

set -a
source "$(dirname "$0")/.env"
set +a

#The different sets that we need:
#1.Age
#2.Ethnicity
#3.Industry
#4.Race
#5.Sex

#Variables to hold the different sets names.
DSAGE="$ZOWE_USER.UCAGE.CSV"
DSETH="$ZOWE_USER.UCETH.CSV"
DSIND="$ZOWE_USER.UCIND.CSV"
DSRAC="$ZOWE_USER.UCRAC.CSV"
DSSEX="$ZOWE_USER.UCSEX.CSV"

#The spinner
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

echo "Populate the unemployment claims files? (y/n)"
read ans

if [ "$ans" = "y" ]; then
    echo "populating"
    #zowe zos-files delete data-set -f "$DSAGE"
    #zowe zos-files delete data-set -f "$DSETH"
    #zowe zos-files delete data-set -f "$DSIND"
    #zowe zos-files delete data-set -f "$DSRAC"
    #zowe zos-files delete data-set -f "$DSSEX"

    zowe zos-files create data-set-sequential "$DSAGE" --record-format FB --record-length 150 --block-size 30000 --size 10TRK
    #zowe zos-files create data-set-sequential "$DSETH" --record-format FB --record-length 150 --block-size 30000 --size 10TRK
    #zowe zos-files create data-set-sequential "$DSIND" --record-format FB --record-length 150 --block-size 30000 --size 10TRK
    #zowe zos-files create data-set-sequential "$DSRAC" --record-format FB --record-length 150 --block-size 30000 --size 10TRK
    #zowe zos-files create data-set-sequential "$DSSEX" --record-format FB --record-length 150 --block-size 30000 --size 10TRK

    #zowe files ul ftds "9_CLAIMS/inputs/claims_by_age.csv" "$DSAGE"
    #zowe files ul ftds "9_CLAIMS/inputs/claims_by_ethnicity.csv" "$DSETH"
    #zowe files ul ftds "9_CLAIMS/inputs/claims_by_industry.csv" "$DSIND"
    #zowe files ul ftds "9_CLAIMS/inputs/claims_by_race.csv" "$DSRAC"
    #zowe files ul ftds "9_CLAIMS/inputs/claims_by_sex.csv" "$DSSEX"

elif [ "$ans" = "n" ]; then
    echo "oh, ok."
else
    echo "invalid input."
fi