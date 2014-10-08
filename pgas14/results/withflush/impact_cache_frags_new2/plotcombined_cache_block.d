
FIRST1 = "`echo $FIRST1`"
LAST1 = "`echo $LAST1`"
FIRST2 = "`echo $FIRST2`"
LAST2 = "`echo $LAST2`"
PREFIX1 = "Pinned Source : "
PREFIX2 = "Unpinned Source : "
PE = "`echo $PE`"

set format x "%10.0f"
set format y "%10.0f"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 4" 

set terminal pdf size 4in,2in
set output "impact_blocking".PE.".pdf"
#set terminal pngcairo
#set output "impact_blocking".PE.".png"

set multiplot layout 2,2 rowsfirst scale 1,1 # \

set macros
set key spacing 0.5 font 'Times-Roman,2.5' samplen 1 \
        width -20

XTICS = "set xtics font 'Times-Roman,3' offset \
0,-1.5 rotate by 90; set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,3' offset 0,5"
NOYTICS = "unset ylabel; unset ytics" 
YTICS = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Reduction(%)' font 'Times-Roman, \
3' offset 8,-1"

TMARGIN = "set tmargin at screen 0.95; set bmargin at screen 0.65"
BMARGIN = "set tmargin at screen 0.45; set bmargin at screen 0.15"
LMARGIN = "set lmargin at screen 0.15; set rmargin at screen 0.43"
RMARGIN = "set lmargin at screen 0.60; set rmargin at screen 0.90" 

TITLE_INST_ACTIVE = "set title '(I) Instr Exec. Reduction (%) (sender)' font \
'Times-Roman, 3' offset -3,-1"
TITLE_CACHE_ACTIVE = "set title '(II) L3-Cache miss Reduction (%) (sender)' font \
'Times-Roman, 3' offset -3,-1"
TITLE_DCA_ACTIVE = "set title '(III) L3-Data Cache Access Reduction (%) (sender)' font \
'Times-Roman, 3' offset -3,-1"
TITLE_TCA_ACTIVE = "set title '(IV) L3-Total Cache Access Reduction (%) (sender)' font \
'Times-Roman, 3' offset -3,-1"

USING_M = "using X:Y with linespoints"
set style line 1 lw 2 pt 1 ps 0.3 lc rgb "#AA4499" 
set style line 2 lw 2 pt 4 ps 0.3 lc rgb "#332288" 
set style line 6 lt 3 lc rgb "red" lw 1
set arrow from 1,0 to 524288,0 back nohead  ls 6 

set key vertical right bot
@TITLE_INST_ACTIVE;
@LMARGIN; @TMARGIN
@XTICS; @YTICS
Y=3 
#set yrange[-100:100]
plot "2901_opti_impact_cache_".FIRST1."_".LAST1.".out" @USING_M \
        title PREFIX1.FIRST1."->".LAST1 ls 1 , \
        "2901_opti_impact_cache_".FIRST2."_".LAST2.".out" @USING_M \
        title PREFIX2.FIRST2."->".LAST2 ls 2

set key vertical right bot
@TITLE_CACHE_ACTIVE;
@RMARGIN; @TMARGIN
@XTICS; @YTICS
Y=6
#set yrange[-100:100]
plot "2901_opti_impact_cache_".FIRST1."_".LAST1.".out" @USING_M \
        title PREFIX1.FIRST1."->".LAST1 ls 1 , \
        "2901_opti_impact_cache_".FIRST2."_".LAST2.".out" @USING_M \
        title PREFIX2.FIRST2."->".LAST2 ls 2


set key vertical right bot
@TITLE_DCA_ACTIVE;
@LMARGIN; @BMARGIN
@XTICS; @YTICS
Y=15
#set yrange[-100:100]
plot "2901_opti_impact_cache_".FIRST1."_".LAST1.".out" @USING_M \
        title PREFIX1.FIRST1."->".LAST1 ls 1 , \
        "2901_opti_impact_cache_".FIRST2."_".LAST2.".out" @USING_M \
        title PREFIX2.FIRST2."->".LAST2 ls 2

set key vertical right bot
@TITLE_TCA_ACTIVE;
@RMARGIN; @BMARGIN
@XTICS; @YTICS
Y=18
#set yrange[-100:100]
plot "2901_opti_impact_cache_".FIRST1."_".LAST1.".out" @USING_M \
        title PREFIX1.FIRST1."->".LAST1 ls 1 , \
        "2901_opti_impact_cache_".FIRST2."_".LAST2.".out" @USING_M \
        title PREFIX2.FIRST2."->".LAST2 ls 2
