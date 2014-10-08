#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>

char ib_before_xmit[100], ib_after_xmit[100], ib_after_xmit_exact[100];
char ib_before_rcv[100], ib_after_rcv[100], ib_after_rcv_exact[100];
unsigned long long int ib_xfer_xmit;
unsigned long long int ib_xfer_rcv;

int main(int argc, char **argv)
{
    int const nt=MAX_WRK_SIZE;
    int me, k , it, j;
    FILE* in;
    char cmd[100];
    long long int msg_cnt, bytes_per_msg;
    void * msg; 

    bindmyproc();
    MPI_Init(NULL,NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &me);
	msg = malloc( nt );
    MPI_Status status;

    if (me == 0)
        printf("#MessageSize\tMsg_cnt\tXmit-PE0\tXmit-PE1\tOn-fly\n");

    for(j=MIN_WRK_SIZE; j<=MAX_WRK_SIZE; j*=2)
    {
      for(msg_cnt=MIN_MSG_NUM;msg_cnt<=j && msg_cnt<=MAX_MSG_NUM; msg_cnt*=2)
      { 
        bytes_per_msg=j/msg_cnt;
        MPI_Barrier(MPI_COMM_WORLD);
        get_xfer_str_ib(ib_before_xmit,ib_before_rcv);
        MPI_Barrier(MPI_COMM_WORLD);

        for (it=0; it<msg_cnt; it++)
        {
             if (me==0)
               MPI_Send((char*)msg+it*bytes_per_msg, bytes_per_msg, MPI_BYTE, 1, 0, MPI_COMM_WORLD);
             else
               MPI_Recv((char*)msg+it*bytes_per_msg, bytes_per_msg, MPI_BYTE, 0, 0, MPI_COMM_WORLD, &status);
        }
        MPI_Barrier(MPI_COMM_WORLD);






        if(me == 0)
        {  
          get_xfer_str_ib(ib_after_xmit,ib_after_rcv);

          detect_overflow(ib_before_xmit, ib_after_xmit, ib_after_xmit_exact);
          detect_overflow(ib_before_rcv, ib_after_rcv, ib_after_rcv_exact);
          ib_xfer_xmit=atoll(ib_after_xmit_exact)-atoll(ib_before_xmit);
          ib_xfer_rcv=atoll(ib_after_rcv_exact)-atoll(ib_before_rcv);

          printf("%d\t%d\t%llu\t%llu\t%llu\n", \
              j,msg_cnt,ib_xfer_xmit,ib_xfer_rcv,ib_xfer_xmit+ib_xfer_rcv);
        }
      }
      if(me==0) printf("\n");
    }
    free(msg);
    MPI_Finalize();
    return 0;
}
