set terminal pdf size 3.5,5
set output "lag_atlas_overlay.pdf"
set termopt enhanced

set macros

    # Placement of the a,b,c,d labels in the graphs
    POS = "at graph 0.72,0.88 font 'Times,9'"
    
    # x- and ytics for each row resp. column
    NOXNUMS = "unset xlabel;\
               set format x ''"
    XNUMS = "unset xlabel;\
             set format x '10^{%+3T}'"
    XLABEL = "set xlabel 'Temporal Frequency [days^{-1}]' font 'Times' off 0,1;\
              set format x '10^{%+3T}'"
    YLABEL = "set ylabel 'Lag [days]' font 'Times' offset 1,2.5;\
              set format y '%.0t'"
    NOYNUMS = "set format y ''; unset ylabel"
    YNUMS = "set format y '%.0t'"
    

    VSET_1 = "set tmargin at screen 0.97; set bmargin at screen 0.825"
    VSET_2 = "set tmargin at screen 0.825; set bmargin at screen 0.68"
    VSET_3 = "set tmargin at screen 0.68; set bmargin at screen 0.535"
    VSET_4 = "set tmargin at screen 0.535; set bmargin at screen 0.39"
    VSET_5 = "set tmargin at screen 0.39; set bmargin at screen 0.245"
    VSET_6 = "set tmargin at screen 0.245; set bmargin at screen 0.10"

    HSET_1 = "set lmargin at screen 0.15; set rmargin at screen 0.42"
    HSET_2 = "set lmargin at screen 0.42; set rmargin at screen 0.69"
    HSET_3 = "set lmargin at screen 0.69; set rmargin at screen 0.96"

unset key
set logscale x
set xtics auto font 'Times,9' offset 0,.5
set ytics ('0' 0,'5' 5,'10' 10,'15' 15,'20' 20,'-5' -5,'' -10,-15,-20) font 'Times,9'
#minor ticks
#set ytics add (-20)
set ytics add ('' -19.5 1)
set ytics add ('' -19 1)
set ytics add ('' -18.5 1)
set ytics add ('' -18 1)
set ytics add ('' -17.5)
set ytics add ('' -17 1)
set ytics add ('' -16.5 1)
set ytics add ('' -16 1)
set ytics add ('' -15.5 1)
#set ytics add (-15)
set ytics add ('' -14.5 1)
set ytics add ('' -14 1)
set ytics add ('' -13.5 1)
set ytics add ('' -13 1)
set ytics add ('' -12.5)
set ytics add ('' -12 1)
set ytics add ('' -11.5 1)
set ytics add ('' -11 1)
set ytics add ('' -10.5 1)
#set ytics add ('' -10)
set ytics add ('' -9.5 1)
set ytics add ('' -9 1)
set ytics add ('' -8.5 1)
set ytics add ('' -8 1)
set ytics add ('' -7.5) 
set ytics add ('' -7 1)
set ytics add ('' -6.5 1)
set ytics add ('' -6 1)
set ytics add ('' -5.5 1)
#set ytics add (-5)
set ytics add ('' -4.5 1)
set ytics add ('' -4 1)
set ytics add ('' -3.5 1)
set ytics add ('' -3 1)
set ytics add ('' -2.5)
set ytics add ('' -2 1)
set ytics add ('' -1.5 1)
set ytics add ('' -1 1)
set ytics add ('' -0.5 1)
#set ytics add (0)
set ytics add ('' 0.5 1)
set ytics add ('' 1 1)
set ytics add ('' 1.5 1)
set ytics add ('' 2 1)
set ytics add ('' 2.5)
set ytics add ('' 3 1)
set ytics add ('' 3.5 1)
set ytics add ('' 4 1)
set ytics add ('' 4.5 1)
#set ytics add (5)
set ytics add ('' 5.5 1)
set ytics add ('' 6 1)
set ytics add ('' 6.5 1)
set ytics add ('' 7 1)
set ytics add ('' 7.5)
set ytics add ('' 8 1)
set ytics add ('' 8.5 1)
set ytics add ('' 9 1)
set ytics add ('' 9.5 1)
#set ytics add (10)
set ytics add ('' 10.5 1)
set ytics add ('' 11 1)
set ytics add ('' 11.5 1)
set ytics add ('' 12 1)
set ytics add ('' 12.5)
set ytics add ('' 13 1)
set ytics add ('' 13.5 1)
set ytics add ('' 14 1)
set ytics add ('' 14.5 1)
#set ytics add (15)
set ytics add ('' 15.5 1)
set ytics add ('' 16 1)
set ytics add ('' 16.5 1)
set ytics add ('' 17 1)
set ytics add ('' 17.5)
set ytics add ('' 18 1)
set ytics add ('' 18.5 1)
set ytics add ('' 19 1)
set ytics add ('' 19.5 1)
#set ytics add (20)
#major ticks










































set xrange [0.007:0.60];
set yrange [-10:15]

# Draw line at origin
set arrow from 0.007,0 to 0.60,0 nohead lt 3 lc rgb 'black'
set pointsize 0

set multiplot layout 6,3 rowsfirst


    # --- GRAPH a
    @VSET_1; @HSET_1
    @NOXNUMS; @YNUMS
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH b
    @NOXNUMS; @NOYNUMS
    @VSET_1; @HSET_2
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    #-- GRAPH c
    @NOXNUMS; @NOYNUMS
    @VSET_1; @HSET_3
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH d
    @NOXNUMS; @YNUMS
    @VSET_2; @HSET_1
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @NOYNUMS
    @VSET_2; @HSET_2
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @NOYNUMS
    @VSET_2; @HSET_3
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @YNUMS
    @VSET_3; @HSET_1
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @NOYNUMS
    @VSET_3; @HSET_2
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @NOYNUMS
    @VSET_3; @HSET_3
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @YLABEL
    @VSET_4; @HSET_1
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @NOYNUMS
    @VSET_4; @HSET_2
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @NOYNUMS
    @VSET_4; @HSET_3
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @YNUMS
    @VSET_5; @HSET_1
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @NOYNUMS
    @VSET_5; @HSET_2
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @NOXNUMS; @NOYNUMS
    @VSET_5; @HSET_3
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @XNUMS; @YNUMS
    @VSET_6; @HSET_1
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @XLABEL; @NOYNUMS
    @VSET_6; @HSET_2
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"
    
    # --- GRAPH a
    @XNUMS; @NOYNUMS
    @VSET_6; @HSET_3
    set label 1 '%LABEL%' @POS
    plot '%FILEA%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "black", '%FILEB%' using 1:2:($2-$4):($2+$4) with yerrorbars pt 7 ps .3 lt rgb "red"


unset multiplot

