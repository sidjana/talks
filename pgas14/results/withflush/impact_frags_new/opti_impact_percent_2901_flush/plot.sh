

export PE="combined"; 
#export PE="passive"; 
#export PE="active"; 

export FIRST1="MPQMPQ"; export LAST1="PQPQ"; 
export FIRST2="MPMPQ"; export LAST2="PPQ"; 
gnuplot ./plotcombined_edprod_reg.d

export FIRST1="MPQMPQ"; export LAST1="MPMPQ"; 
export FIRST2="PQPQ"; export LAST2="PPQ"; 
gnuplot ./plotcombined_edprod_block.d

export FIRST1="PPQ"; export LAST1="MMPQAMM"; 
#export FIRST2="PPQ"; export LAST2="MMPQ"; 
gnuplot ./plotcombined_edprod_agg.d


