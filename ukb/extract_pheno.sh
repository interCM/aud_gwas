#!/bin/bash

FIDS="21000"
OUTF="ancestry"
UKBLAKE=/tsd/p33/data/durable/s3-api/ukblake
OUTD=/cluster/projects/p33/users/alexeas/ukb/misc
WITHDRAWAL=${UKBLAKE}/participant_withdrawal/w27412_20210809.csv

python ${HOME}/src/ukb_tools/ukb_helper.py pheno --input ${UKBLAKE}/phenotypes/ukb*.csv --fields ${FIDS} --remove ${WITHDRAWAL} --out ${OUTD}/${OUTF}

