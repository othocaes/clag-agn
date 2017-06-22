#!/usr/bin/env bash

mkdir -p data/tables
mkdir -p logs

analysis_script="psdlag_6bin.py"

ref_band="1367A"
refpsd_tabfile=data/tables/psd_${ref_band}.tab

err_str="LF"

for lightcurve in data/lc/*.lc
do
    
    echo_band=$(basename $lightcurve|sed 's|\([0-9]\{4\}A\).lc|\1|')
    if [[ $ref_band == $echo_band ]]; then continue; fi

    # Save tables with these filenames
    echopsd_tabfile=data/tables/psd_${echo_band}.tab
    timelag_tabfile=data/tables/lag_${ref_band}_${echo_band}.tab

    echo -n "Running psdlag using ref band ${ref_band}"
    echo " and echo band $echo_band."

    echo $(date) >> logs/$echo_band
    echo "using ${analysis_script}"
    echo " " >> logs/$echo_band

    # psdlag python script will call clag and print rudimentary tables to *.out, 
    # and is logged to the log file
    time scripts/${analysis_script} data/lc/${ref_band}.lc $lightcurve >> logs/${echo_band}


    # process_output perl script reads *.out files from the python script,
    # then creates other useful tables

    scripts/process_output.pl $echo_band 

    # So if one fails we don't read the previous output
    rm *.out

    # saves the tables to data/tables/
    mv -v tmp.echopsd $echopsd_tabfile
    mv -v tmp.refpsd $refpsd_tabfile
    mv -v tmp.lag $timelag_tabfile

    echo ""
done
