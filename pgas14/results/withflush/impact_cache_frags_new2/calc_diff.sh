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
     "3.Inst_active_diff 4.Inst_passive_diff 5.Inst_tot_diff " \
     "6.Cache_active_diff 7.Cache_passive_diff 8.Cache_tot_diff " \
     "9.Inst_per_put_ini 10.Inst_per_put_final 11.Inst_per_put_diff " \
     "12.Tch_per_put_ini 13.Tch_per_put_final 14.Tch_per_put_diff " \
     "15.Dca_active_diff 16.Dca_passive_diff 17.Dca_tot_diff " \
     "18.Tca_active_diff 19.Tca_passive_diff 20.Tca_tot_diff " \
     "21.Tch_percent_ini 22.Tch_percent_final " \
     "23.Tcm_percent_ini 24.Tcm_percent_final "



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

        dca_active_diff=` echo "scale=12; (${myarr_ini[10]}-${myarr_final[10]})*100/${myarr_ini[10]}"| bc`
        dca_passive_diff=` echo "scale=12; (${myarr_ini[11]}-${myarr_final[11]})*100/${myarr_ini[11]}"| bc`
        dca_tot_diff=` echo "scale=12; (${myarr_ini[12]}-${myarr_final[12]})*100/${myarr_ini[12]}"| bc`
        
        tca_active_diff=` echo "scale=12; (${myarr_ini[13]}-${myarr_final[13]})*100/${myarr_ini[13]}"| bc`
        tca_passive_diff=` echo "scale=12; (${myarr_ini[14]}-${myarr_final[14]})*100/${myarr_ini[14]}"| bc`
        tca_tot_diff=` echo "scale=12; (${myarr_ini[15]}-${myarr_final[15]})*100/${myarr_ini[15]}"| bc`

        inst_per_put_ini=` echo "scale=12; (${myarr_ini[4]}/${Y})"| bc`
        inst_per_put_final=` echo "scale=12; (${myarr_final[4]}/${Y})"| bc`
        inst_per_put_diff=` echo "scale=12; ($inst_per_put_ini-$inst_per_put_final)*100/${inst_per_put_ini}"| bc`
        tch_per_put_ini=` echo "scale=12; (${myarr_ini[13]}/${Y})"| bc`
        tch_per_put_final=` echo "scale=12; (${myarr_final[13]}/${Y})"| bc`
        tch_per_put_diff=` echo "scale=12; ($tch_per_put_ini-$tch_per_put_final)*100/${tch_per_put_ini}"| bc`
        tch_percent_ini=` echo "scale=12; (${myarr_ini[13]}-${myarr_ini[7]})*100/${myarr_ini[13]}"| bc`
        tch_percent_final=` echo "scale=12; (${myarr_final[13]}-${myarr_final[7]})*100/${myarr_final[13]}"| bc`
        tcm_percent_ini=` echo "scale=12; (${myarr_ini[7]})*100/${myarr_ini[13]}"| bc`
        tcm_percent_final=` echo "scale=12; (${myarr_final[7]})*100/${myarr_final[13]}"| bc`

        echo $X $Y \
        $inst_active_diff $inst_passive_diff $inst_tot_diff \
        $cache_active_diff $cache_passive_diff $cache_tot_diff \
        $inst_per_put_ini $inst_per_put_final $inst_per_put_diff \
        $tch_per_put_ini $tch_per_put_final $tch_per_put_diff \
        $dca_active_diff $dca_passive_diff $dca_tot_diff \
        $tca_active_diff $tca_passive_diff $tca_tot_diff \
        $tch_percent_ini $tch_percent_final \
        $tcm_percent_ini $tcm_percent_final

        : $(( Y=Y*2 ))

    done
    : $(( X=X*2 ))
done
