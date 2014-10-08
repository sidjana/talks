FILE_NAME = "`echo $FILE_NAME`"
set logscale x 2
set logscale y 2
set format x "%10.0f"
set format y "%10.0f"
set xrange [1:2097152] 
set yrange [1:2097152]
set xtics font "Times-Roman, 8" offset 0,0,0 rotate by 90
set ytics font "Times-Roman, 8" offset 0,0,0 #rotate by 45
X=1 ; set xlabel "#Bytes" font "Times-Roman, 8" offset 0,1,0
Y=2 ; set ylabel "#Fragments" font "Times-Roman, 8"\
offset 7,-0.75,0
set cblabel "Number of Packets" font "Times-Roman, 8" \
        offset -8,0,0 rotate by -90
set cbtics font "Times-Roman, 5"
set title font "Times-Roman, 5" 
unset key

#set terminal pdf 
#set output FILE_NAME.".pdf"
set terminal pngcairo
set output FILE_NAME.".png"

set palette defined ( 0 "blue", 1 "green", 2 "yellow",\
        3 "orange", 4 "red", 5 "black" )
set pm3d corners2color mean at st
set view map
set multiplot layout 2,2 rowsfirst scale 1,1 

Z=3 ;set title "Transmitted Packets [Sender]" font "Times-Roman, 8"; set log cb; \
  set cbrange[2:2097157] ;splot FILE_NAME using X:Y:Z with pm3d
Z=4 ;set title "Transmitted Packets [Receiver]" font "Times-Roman, 8"; set log cb; \
  set cbrange[2:2096885] ;splot FILE_NAME using X:Y:Z with pm3d
Z=5 ;set title "Number of on-the-fly Packets b/w 2 nodes" font "Times-Roman, 8"; set log cb; \
  set cbrange[2:4194042] ;splot FILE_NAME using X:Y:Z with pm3d

pause -1 "Hit any key to continue" 
