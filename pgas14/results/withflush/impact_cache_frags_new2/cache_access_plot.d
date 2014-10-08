set format x "%6g"
set format y "%5.3g"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 2" 

set terminal pdf size 4in,8in
set output "raw_cache_accesses.pdf"
#set terminal pngcairo
#set output "raw_cache_accesses.png"

set multiplot layout 5,2 rowsfirst scale 1,1

set macros
set key spacing 0.4 font 'Times-Roman,2' samplen 1 \
        width -5

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics font 'Times-Roman,3' offset \
0,0.5 rotate by -90;" 
XLABEL = "set xlabel '# Fragments \
[Log-scale]'\ font 'Times-Roman,3' offset 0,2.5"
NOYTICS = "unset ylabel; unset ytics" 
YTICS = "set ytics font 'Times-Roman,3' offset \
0.5,0 ;set ylabel '%age' font 'Times-Roman, \
3' offset 4.5,-1"

TMARGIN = "set tmargin at screen 0.95; set bmargin at screen 0.65"
BMARGIN = "set tmargin at screen 0.45; set bmargin at screen 0.15"
LMARGIN = "set lmargin at screen 0.15; set rmargin at screen 0.43"
RMARGIN = "set lmargin at screen 0.55; set rmargin at screen 0.85" 

TITLE_MISS = "set title '%L3-Cache misses (Sender)' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_HITS = "set title '%L3-Cache hits (Sender)' \
font 'Times-Roman, 4' offset -3,-1"

USING_M = "using X:Y with linespoints"

set style line 1 lw 1 pt 1 ps 0.4 lc rgb "#AA4499" 
set style line 2 lw 1 pt 2 ps 0.3 lc rgb "#88CCEE" 
set style line 3 lw 1 pt 3 ps 0.4 lc rgb "#882255" 
set style line 4 lw 1 pt 4 ps 0.3 lc rgb "#332288" 
set style line 5 lw 1 pt 5 ps 0.4 lc rgb "#999933" 
set style line 6 lw 1 pt 7 ps 0.3 lc rgb "#332288"

@NOXTICS
@XTICS
@XLABEL
@YTICS

FIRST="MPQMPQ"
LAST="PQPQ"
@TITLE_HITS
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:21 with linespoints   title FIRST ls 1

@TITLE_MISS
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:23 with linespoints   title FIRST ls 1

FIRST="MPQMPQ"
LAST="PQPQ"
@TITLE_HITS
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:22 with linespoints   title LAST ls 1

@TITLE_MISS
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:24 with linespoints   title LAST ls 1


FIRST="MPQMPQ"
LAST="MPMPQ"
@TITLE_HITS
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:22 with linespoints   title LAST ls 1

@TITLE_MISS
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:24 with linespoints   title LAST ls 1


FIRST="PQPQ"
LAST="PPQ"
@TITLE_HITS
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:22 with linespoints   title LAST ls 1

@TITLE_MISS
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:24 with linespoints   title LAST ls 1

FIRST="PPQ"
LAST="MMPQAMM"
@TITLE_HITS
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:22 with linespoints   title LAST ls 1

@TITLE_MISS
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" \
         using X:24 with linespoints   title LAST ls 1
