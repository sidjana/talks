#!/bin/bash

## Remember when plotting data for MAX_MSG_NUM=1, comment the 
## extra call to echo ""

MIN_WRK_SIZE="524288"
MAX_WRK_SIZE="524288"
MIN_MSG_NUM="1"
MAX_MSG_NUM="524288"

INI_OPTI="$1"
INI_ACT_FREQ="2901"
INI_PASS_FREQ="2901"

FINAL_OPTI="$2"
FINAL_ACT_FREQ="2901"
FINAL_PASS_FREQ="2901"

INI_FILE="${INI_OPTI}.readings"
FINAL_FILE="${FINAL_OPTI}.readings"

X=$MIN_WRK_SIZE

echo "#1.Msg_size 2.Frags " \
     "3.Inst_active_diff 4.Inst_passive_diff 5.Inst_tot_diff" \
     "6.Cache_active_diff 7.Cache_passive_diff 8.Cache_tot_diff"

while  [ $X -le $MAX_WRK_SIZE ] ; 
do
Y=$MIN_MSG_NUM
while  [ $Y -le $MAX_MSG_NUM ] && [ $Y -le $X ] ; 
do

        line_ini=` grep "$X\s*$Y\s*" ${INI_FILE}`
        line_final=` grep "$X\s*$Y\s*" ${FINAL_FILE}`

    	myarr_ini=($line_ini)
    	myarr_final=($line_final)
	
        inst_active_diff=` echo "scale=12; (${myarr_ini[4]}-${myarr_final[4]})*100/${myarr_ini[4]}"| bc`
        inst_passive_diff=` echo "scale=12; (${myarr_ini[5]}-${myarr_final[5]})*100/${myarr_ini[5]}"| bc`
        inst_tot_diff=` echo "scale=12; (${myarr_ini[6]}-${myarr_final[6]})*100/${myarr_ini[6]}"| bc`
        cache_active_diff=` echo "scale=12; (${myarr_ini[7]}-${myarr_final[7]})*100/${myarr_ini[7]}"| bc`
        cache_passive_diff=` echo "scale=12; (${myarr_ini[8]}-${myarr_final[8]})*100/${myarr_ini[8]}"| bc`
        cache_tot_diff=` echo "scale=12; (${myarr_ini[9]}-${myarr_final[9]})*100/${myarr_ini[9]}"| bc`

        echo $X $Y \
        $inst_active_diff $inst_passive_diff $inst_tot_diff \
        $cache_active_diff $cache_passive_diff $cache_tot_diff

        : $(( Y=Y*2 ))

    done
    : $(( X=X*2 ))
done
