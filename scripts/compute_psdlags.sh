#!/usr/bin/env bash

mkdir -p data

ref_band="1367A"

for lightcurve in data/lc/*.lc
do
    
    echo_band=$(basename $lightcurve|sed 's|\([0-9]????A\).lc|\1|')
    if [[ $ref_band == $echo_band ]]; then continue; fi
    err_str="LF"

echo -n "Running psdlag using ref band ${ref_band}"
echo " and echo band $echo_band{${err_str}}."

scripts/psdlag_4bin.py


    # Propagate tables into analyses/tables
    echoPSD_tabfile=analyses/tables/PSD_${echo_band}_\{${err_str}\}.tab
    refPSD_tabfile=analyses/tables/PSD_${ref_band}_\{${err_str}\}.tab
    timelag_tabfile=analyses/tables/timelag_${ref_band}_≺_${echo_band}_\{${err_str}\}.tab

    # Output curves to temporary files using perl script, move tables to
    # permanent location. This just assumes there are no conflicts.
    scripts/extract_tables.pl $lightcurve > /dev/null
    mv tmp.echoPSD $echoPSD_tabfile
    mv tmp.refPSD $refPSD_tabfile
    mv tmp.timelag $timelag_tabfile
done

rm tmp.*