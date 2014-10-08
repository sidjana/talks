set format x "%6g"
set format y "%5.2g"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 2" 

set terminal pdf size 4in,2in
set output "raw_vals_cache_inst.pdf"
#set terminal pngcairo
#set output "raw_vals_cache_inst.png"

set multiplot layout 2,2 rowsfirst scale 1,1

set macros
set key spacing 0.4 font 'Times-Roman,2' samplen 2 \
        width -5

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics font 'Times-Roman,3' offset \
0,-1 rotate by 90; set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,3' offset 0,3"
NOYTICS = "unset ylabel; unset ytics" 
YTICS_INST = "set ytics font 'Times-Roman,3' offset \
0.5,0 ;set ylabel '#Instructions' font 'Times-Roman, \
3' offset 3,-1"
YTICS_CACHE = "set ytics font 'Times-Roman,3' offset \
0.5,0 ;set ylabel '#Cache misses ' font 'Times-Roman, \
3' offset 5,-1"

TMARGIN = "set tmargin at screen 0.95; set bmargin at screen 0.65"
BMARGIN = "set tmargin at screen 0.45; set bmargin at screen 0.15"
LMARGIN = "set lmargin at screen 0.15; set rmargin at screen 0.43"
RMARGIN = "set lmargin at screen 0.55; set rmargin at screen 0.85" 

TITLE_INST = "set title '(I) Instruction count' font \
'Times-Roman, 4' offset -3,-1"
TITLE_CACHE_ACTV = "set title '(II) L3 Cache misses (Sender)' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_CACHE_PASS = "set title '(III) L3 Cache misses (Recv)' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_CACHE_TOT = "set title '(IV) L3 Cache misses (Total)' \
font 'Times-Roman, 4' offset -3,-1"

USING_M = "using X:Y with linespoints"

set style line 1 lw 1 pt 1 ps 0.4 lc rgb "#AA4499" 
set style line 2 lw 1 pt 2 ps 0.3 lc rgb "#88CCEE" 
set style line 3 lw 1 pt 3 ps 0.4 lc rgb "#882255" 
set style line 4 lw 1 pt 4 ps 0.3 lc rgb "#332288" 
set style line 5 lw 1 pt 5 ps 0.4 lc rgb "#999933" 
set style line 6 lw 1 pt 7 ps 0.3 lc rgb "#332288"

set key vertical left top
@TITLE_INST; 
@TMARGIN; 
@LMARGIN
@XTICS; @YTICS_INST
Y=4 ;
#set logscale y 1.00001
#set yrange[0.01:55]
plot "MPQMPQ.readings" @USING_M title "MPQMPQ" ls 1 , \
     "PQPQ.readings" @USING_M title "PQPQ" ls 2 #, \
#     "MPMPQ.readings" @USING_M title "MPMPQ" ls 3 , \
#     "PPQ.readings" @USING_M title "PPQ" ls 4 , \
#     "MMPQAMM.readings" @USING_M title "MMPQAMM" ls 5

set key vertical left top
@TITLE_CACHE_ACTV; 
@TMARGIN; 
@RMARGIN
@XTICS; @YTICS_CACHE
Y=4 ;
#set logscale y 1.00001
#set yrange[0.0008:2]
plot "MPQMPQ.readings" @USING_M title "MPQMPQ" ls 1 , \
     "PQPQ.readings" @USING_M title "PQPQ" ls 2 #, \
#     "MPMPQ.readings" @USING_M title "MPMPQ" ls 3 , \
#     "PPQ.readings" @USING_M title "PPQ" ls 4 , \
#     "MMPQAMM.readings" @USING_M title "MMPQAMM" ls 5

XTICS = "set xtics font 'Times-Roman,3' offset \
0,-0.9 rotate by 90; set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,3' offset 0,3"


set key vertical left top
@TITLE_CACHE_PASS; 
@BMARGIN; 
@LMARGIN
@XTICS; @YTICS_CACHE
Y=4 ;
#set logscale y 1.00001
#set yrange[400:500000000]
plot "MPQMPQ.readings" @USING_M title "MPQMPQ" ls 1 , \
     "PQPQ.readings" @USING_M title "PQPQ" ls 2 #, \
#     "MPMPQ.readings" @USING_M title "MPMPQ" ls 3 , \
#     "PPQ.readings" @USING_M title "PPQ" ls 4 , \
#     "MMPQAMM.readings" @USING_M title "MMPQAMM" ls 5

set key vertical left bot
@TITLE_CACHE_TOT; 
@BMARGIN; 
@RMARGIN
@XTICS; @YTICS_CACHE
Y=4 ;
#set logscale y 1.00001
#set yrange[440000:700000000]
plot "MPQMPQ.readings" @USING_M title "MPQMPQ" ls 1 , \
     "PQPQ.readings" @USING_M title "PQPQ" ls 2 #, \
#    "MPMPQ.readings" @USING_M title "MPMPQ" ls 3 , \
#    "PPQ.readings" @USING_M title "PPQ" ls 4 , \
#    "MMPQAMM.readings" @USING_M title "MMPQAMM" ls 5

