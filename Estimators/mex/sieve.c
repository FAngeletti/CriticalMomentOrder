#include <mex.h>


#include "math.h"


double distance(double sT, double sR,double drank,double dpos)
{
  double x=fabs(drank/sT);
  double y=fabs(dpos/sR);
return (x>y)?x:y;
}


void eliminate(int pos,double sT,int sR,int n, double* index, char* ref)
{
int i=0;
int rPos=index[pos];

  for(i=pos+1;i<n && i< (1+pos+sR);++i )
    if( distance(sT,sR, index[i]-rPos,i-pos)<1 )
      ref[i]=0;
  
}

void mexFunction(int nlhs, mxArray* plhs [],int nrhs, const mxArray* prhs [])
{
  double sT= *(double*) mxGetData(prhs[0]);
  double sR= *(double*) mxGetData(prhs[1]);
  
   double* tail= mxGetPr(prhs[2]);
   int n=mxGetNumberOfElements(prhs[2]);
   
   double* index= mxGetPr(prhs[3]);

   
   int k= *(double*) mxGetData(prhs[4]);

plhs[0]=mxCreateDoubleMatrix(k,1,mxREAL);
double* res=mxGetPr(plhs[0]); 

char* ref=(char*) malloc (n*sizeof(char));
int i;

for(i=0;i<n;++i)
  ref[i]=1;

int p=0;
int r=0;

while(p<n && r <k)
{
  while(ref[p]==0 && p<n) ++p;
  if(p==n)
    break;

  res[r]=tail[p];
   ++r;
  eliminate(p,sT,sR,n,index,ref);
  ++p;
  
}

if(r<k)
{
  mxSetM(plhs[0],r);
/*  mxRealloc(plhs,r); */ 
}
free(ref);

}