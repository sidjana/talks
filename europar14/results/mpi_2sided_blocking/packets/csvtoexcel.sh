#!/bin/bash

MIN_WRK_SIZE="1"
MAX_WRK_SIZE="1048576"
MIN_MSG_NUM="1"
MAX_MSG_NUM="1048576"

X=$MIN_WRK_SIZE
K=1

while  [ $X -le $MAX_WRK_SIZE ] ; 
do
Y=$MIN_MSG_NUM
while  [ $Y -le $MAX_MSG_NUM ] && [ $Y -le $X ] ; 
do

message_size=$X
fragment=$Y
printf '%6d %6d %6d \n' "$message_size" "$fragment" "$K"
: $((K=K+1))
: $((Y=Y*2))

done
echo ""
: $((X=X*2))
done
echo ""

