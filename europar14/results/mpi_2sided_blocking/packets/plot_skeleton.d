FILE_NAME = "empty"

set logscale x 2
set logscale y 2
set format x "%10.0f"
set format y "%10.0f"
set xrange [1:2097152] 
set yrange [1:2097152]
X=1 ; 
Y=2 ; 
set cbtics font "Times-Roman, 7" offset -0.5,0
set cblabel "Color-scale" font \
"Times-Roman, 7" offset 0,0,0 rotate by -90
set title font "Times-Roman, 7" 

unset key
#set label 1 "P ~ {32KB payload, 1024 fragments}" at \
128,131072 center font "Times-Roman,6"
#set arrow from 1,1024 to 32768,1024 nohead front lw 2
#set arrow from 32768,1024 to 32768,1 nohead front lw 2
#set arrow from 32768,2048 to 64,65536 nohead front lw 2

set label 1 "Fixed total payload-size" at 64,524288 \
center font "Times-Roman,6"
set arrow from 1024,524288 to 262144,32768 nohead front lw 2 
set arrow from 524288,524288 to 524288,2  front lw 2 lt 2

set label 2 "Constant bytes per transfer" at 64,65536 \
center font "Times-Roman,6"
set arrow from 32768,8192 to 2048,65536  nohead front lw 2 
set arrow from 16,4 to 262144,65536  front lw 2 lt 2 

set label 3 "Constant number of fragments" at 64,4096 \
center font "Times-Roman,6"
set arrow from 64,1024 to 8,4  nohead front lw 2 
set arrow from 32,4 to 262144,4  front lw 2 lt 2  


set terminal pdf 
set output FILE_NAME.".pdf"

set xtics font 'Times-Roman,7' offset 0,-1,0 rotate \
by 90; set xlabel 'Total Message Size \
(Bytes)[Log-scale]' font 'Times-Roman,7' offset 2,-1

set ytics font 'Times-Roman,7' offset 0.5,0,0 ;set \
ylabel '#Fragments[Log-scale]' font 'Times-Roman, 7' offset 4,-1,0

set pm3d corners2color mean at st
set view map

Z=3 ;set title "<Transport + Protocol> [<Metric>(Units)]" font "Times-Roman, 7"; unset log cb; \
  set cbrange[1:231] ;splot FILE_NAME using X:Y:Z with pm3d

pause -1 "Hit any key to continue" 
