
#include "ExpPowInversionCore.h"
#include <gsl/gsl_sf_erf.h>



double normcdf(double sq2,double x)
{
return gsl_sf_erfc(x/sq2)/2;
}

void mexFunction(int nlhs, mxArray* plhs [],int nrhs, const mxArray* prhs [])
{
  
const double sq2=sqrt(2);

double rho=* (double*)mxGetData(prhs[0]);
double norm=* (double*)mxGetData(prhs[1]);
double* table= mxGetPr(prhs[2]);
size_t n= mxGetNumberOfElements(prhs[2]);
double* x= mxGetPr(prhs[3]);
size_t nx=mxGetNumberOfElements(prhs[3]);

plhs[0]=mxCreateDoubleMatrix(1,nx,mxREAL);
double* y=mxGetPr(plhs[0]);

/*mexPrintf("nTable=%u nX=%u \n" ,n,nx); */ 

double y0=0.5;
int pos;
int i;
double t,xv;

for (i=0;i<nx;++i)
{
 xv=normcdf(sq2,x[i]);
/* mexPrintf("x=%f xv=%f \n",x[i],xv); */
 pos= (int) (xv*(n+1));
if(pos<=1)
  y0=table[0];
else if(pos>=n)
  y0=table[n-1];
else
  {
  t= (n+1)*xv-pos;
 /*mexPrintf("pos=%d t=%f, %f<y<%f \n",pos,t,table[pos-1],table[pos]); */
  y0=(1-t)*table[pos-1]+t*table[pos];

  }

y[i]=exp(inversion(rho,norm,y0,xv));
/* mexPrintf("y=%f (%f) \n",y[i],y0); */
}
}



