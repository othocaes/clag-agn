#!/usr/bin/env bash

# This metascript uses the available plotting scripts to produce a list of
# document-rady plots.

ref_band="1367A"

case $1 in
    "PSD"|"psd"|"PSDs"|"PSDS"|"psds")
        gnuplot_file=psd_atlas.gp
        gnuplot_input=$(cat scripts/templates/${gnuplot_file}|
                        perl -pe 's|\n|␤|g')
        for tabfile in data/tables/psd_*.tab;
        do
            echo_band=$(basename $tabfile|
                        sed 's|psd_\([0-9]\{4\}A\).tab|\1|')
            if [[ "$echo_band" == "$ref_band" ]] ; then continue; fi
            gnuplot_input_edit=$(echo "$gnuplot_input"|
                                    sed "s|%FILE%|$tabfile|"|
                                    sed "s|%LABEL%|$echo_band|")
            gnuplot_input="${gnuplot_input_edit}"
        done
        echo "$gnuplot_input"|perl -pe 's|␤|\n|g' > ${gnuplot_file}
        gnuplot $gnuplot_file
        rm $gnuplot_file
    ;;

    "lags"|"lag"|"delay"|"delays")
        gnuplot_file=lag_atlas.gp
        gnuplot_input=$(cat scripts/templates/${gnuplot_file}|perl -pe 's|\n|␤|g')
        for tabfile in data/tables/lag_*.tab;
        do
            ref_band_extracted=$(basename $tabfile|
                                    sed 's|lag_\([0-9]\{4\}A\)_[0-9]\{4\}A.tab|\1|')
            echo_band=$(basename $tabfile|
                        sed 's|lag_[0-9]\{4\}A_\([0-9]\{4\}A\).tab|\1|')
            if [[ "$echo_band" == "$ref_band" ]] ; then continue; fi
            gnuplot_input_edit=$(echo "$gnuplot_input"|
                                    sed "s|%FILE%|$tabfile|"|
                                    sed "s|%LABEL%|$echo_band|")
            gnuplot_input="${gnuplot_input_edit}"
        done
        echo "$gnuplot_input"|perl -pe 's|␤|\n|g' > ${gnuplot_file}
        gnuplot $gnuplot_file
        rm $gnuplot_file
    ;;

    "tophat"|"th")
        mkdir -p data/tables/
        scripts/tophat_fft.pl
        gnuplot scripts/templates/tophat_freqdomain.gp
        gnuplot scripts/templates/tophat_timedomain.gp
    ;;

    *)
        echo "Did not understand plot type."
    ;;
esac
