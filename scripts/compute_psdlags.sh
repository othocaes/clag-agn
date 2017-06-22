#!/usr/bin/env bash

mkdir -p data

ref_band="1367A"
refpsd_tabfile=data/tables/psd_${ref_band}.tab

for lightcurve in data/lc/*.lc
do
    
    echo_band=$(basename $lightcurve|sed 's|\([0-9]????A\).lc|\1|')
    if [[ $ref_band == $echo_band ]]; then continue; fi
    err_str="LF"

    # Save tables with these filenames
    echopsd_tabfile=data/tables/psd_${echo_band}.tab
    timelag_tabfile=data/tables/lag_${ref_band}_${echo_band}.tab

    echo -n "Running psdlag using ref band ${ref_band}"
    echo " and echo band $echo_band{${err_str}}."

    # psdlag python script will call clag and print tables
    # tmp.* files.
    echo scripts/psdlag_4bin.py ${ref_band}.lc $lightcurve


    # process_tables perl script reads tmp.* files and creates some
    # other useful tables
    scripts/process_tables.pl $lightcurve > /dev/null
    mv tmp.echoPSD $echoPSD_tabfile
    mv tmp.refPSD $refPSD_tabfile
    mv tmp.timelag $timelag_tabfile
done

rm tmp.*