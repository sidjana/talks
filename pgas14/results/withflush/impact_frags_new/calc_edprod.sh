#!/bin/bash

## Remember when plotting data for MAX_MSG_NUM=1, comment the 
## extra call to echo ""

MIN_WRK_SIZE="524288"
MAX_WRK_SIZE="524288"
MIN_MSG_NUM="1"
MAX_MSG_NUM="524288"
FREQ="$1"
Prog="$1"
Low="$3"
High="$2"

X=$MIN_WRK_SIZE

session=0
while  [ $X -le $MAX_WRK_SIZE ] ; 
do
Y=$MIN_MSG_NUM
while  [ $Y -le $MAX_MSG_NUM ] && [ $Y -le $X ] ; 
do
        # For RAPL comparing optimizations
        line_low_rapl=` grep "$X[[:space:]]$Y[[:space:]]" ${FREQ}MHz/${Low}/${Low}.out`
        line_high_rapl=`grep "$X[[:space:]]$Y[[:space:]]" ${FREQ}MHz/${High}/${High}.out`

        # For RAPL comparing frequencies
        #line_low_rapl=` grep "$X[[:space:]]$Y[[:space:]]" ${Low}MHz/${Prog}/${Prog}.out`
        #line_high_rapl=`grep "$X[[:space:]]$Y[[:space:]]" ${High}MHz/${Prog}/${Prog}.out`

        # For FPGA comparing optimizations
        line_low_fpga=` grep "$X[[:space:]]$Y[[:space:]]" ${FREQ}MHz/${Low}/${Low}_fpga.out`
        line_high_fpga=`grep "$X[[:space:]]$Y[[:space:]]" ${FREQ}MHz/${High}/${High}_fpga.out`

        # For FPGA comparing frequencies
        #line_low_fpga=` grep "$X[[:space:]]$Y[[:space:]]"  ${Low}MHz/${Prog}/${Prog}_fpga.out`
        #line_high_fpga=`grep "$X[[:space:]]$Y[[:space:]]" ${High}MHz/${Prog}/${Prog}_fpga.out`
     
    	myarr_low_rapl=($line_low_rapl)
        myarr_high_rapl=($line_high_rapl)
    	myarr_low_fpga=($line_low_fpga)
        myarr_high_fpga=($line_high_fpga)
	
        timer_high=${myarr_high_rapl[2]}
        timer_low=${myarr_low_rapl[2]}

        energy_tot_high=`echo "scale=12; (${myarr_high_rapl[3]}+${myarr_high_fpga[6]})  "| bc`
        edprod_high=`echo "scale=12; (${energy_tot_high}*${timer_high})  "| bc`
        energy_tot_low=`echo "scale=12; (${myarr_low_rapl[3]}+${myarr_low_fpga[6]})  "| bc`
        edprod_low=`echo "scale=12; (${energy_tot_low}*${timer_low})  "| bc`

        edprod_impact=`echo "scale=12; ((${edprod_high}-${edprod_low}))*100/${edprod_high}  "| bc`
    
        echo $X $Y ${edprod_high} ${edprod_low}  ${edprod_impact}

        : $(( Y=Y*2 ))

    done
#    echo ""
    : $(( X=X*2 ))
done
echo ""
