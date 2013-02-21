#include "ExpPowInversionCore.h"


double estim(double rho,double x)
{
  double y= (x<0.1)? x/exp(1) : pow((-log(1-x)),1/rho);
  return y;
};

void mexFunction(int nlhs, mxArray* plhs [],int nrhs, const mxArray* prhs [])
{


double rho=* (double*)mxGetData(prhs[0]);
double norm=* (double*)mxGetData(prhs[1]);
int n= (int) (* (double*) mxGetData(prhs[2]));

int deep=log2(n);
n=(1<<deep) +1;



plhs[0]=mxCreateDoubleMatrix(n,1,mxREAL);
double* table=mxGetPr(plhs[0]); 



int i;
double pos;

i=1;
pos=i/(double)(n+1);
table[i-1]=inversion(rho,norm,estim(rho,pos),pos );


i=n;
pos=i/(double)(n+1);
table[i-1]=inversion(rho,norm,estim(rho,pos),pos );

int d,s;
int stride=n-1;
for(d=0;d<deep;++d)
{
  for(s=1;s<=n-stride;s+=stride)
    { 
    i=(2*s+stride)/2;
    pos=i/(double)(n+1);

    table[i-1]=inversion(rho,norm, (table[s-1]+table[s+stride-1])/2,pos);


    }
  stride/=2;
}

}



