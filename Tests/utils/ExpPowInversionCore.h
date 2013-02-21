
#include "gsl/gsl_sf_gamma.h"
#include <math.h>
#include <mex.h>

double der(double norm,double xpr)
{
return exp(-xpr)/norm;
}

double der2r(double rho,double x,double xpr)
{
return (-rho*xpr/x);
}

double cdf(double rho, double xpr)
{
return gsl_sf_gamma_inc_P(1/rho,xpr);
}

double rder(double norm,double xpr)
{
return -exp(-xpr)/norm;
}

double rcdf(double rho,double xpr)
{
return gsl_sf_gamma_inc_Q(1/rho,xpr);
}

typedef struct {double (*fun) (double,double); double (*der) (double,double); } derivable;

double inversion(double rho,double norm, double y0, double x)
{

double eps=1e-10;
int type=1;
if(x>0.5)
  type=2,x=1-x;

double y=y0,ypr=pow(y0,rho);
double fy,fyd,fyd2r;
double delta;
derivable F;


if(type==1)
  F.fun=cdf,F.der=der;
else
  F.fun=rcdf,F.der=rder;

fy=F.fun(rho,ypr);
int i=0;
while (fabs(fy-x)>eps)
{
  ++i;


fyd=F.der(norm,ypr);

/*fyd2r=der2r(rho,y,ypr); 
delta= 2*(fy-x)*fyd/(fyd*(2*fyd-fy*fyd2r) ); */
delta= (fy-x)/fyd;
y-=delta;


if(y<=0)
  y= (delta+y)/2;
ypr=pow(y,rho);
fy=F.fun(rho,ypr);

}
/*mexPrintf("%d iterations\n",i); */
return y;
}



