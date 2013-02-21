# Presentation
This matlab package bundles a set of estimator for the critical order for moment estimation
for lognormal and other log-exponential power laws. These laws can be written as 
X= exp(Y), where Y follows a distribution p_Y such that
y p_Y'(y) / p_Y(y) converges towards a finite constant rho.
In this situation, for rho>1, it can be shown (cf http://dx.doi.org/10.1088/1751-8113/45/11/115004 or http://arxiv.org/abs/1103.5033) that with a finite number of samples,
the empirical moment estimator can only estimates the theoretical moment up to critical order of moment
q_c. This critical order of moment growths extremely slowly in function of n:
q_c(n) = L(ln n) (ln n)^{1-1/rho}.

It can be therefore quite useful to be able to estimate rho and q_c. Such is the aim of this
matlab package.

# Estimators
All the available estimators are located within the Estimators sub-directory.
A standard use of these estimators would be:

```matlab
n=1000;
gaussData = normrnd(0,1,n,1);
data= arrayfun(@exp, gaussData )
estimator = qcEstimator(10,50);
q_c = estimator(data) 
```

The more efficient estimators have been gathered at the top of the 'Estimators' sub-directory.
At the lower levels, the endAnalyzers and preAnalyzers sub-directories contain the functions used 
to construct these estimators. The proposed estimators are constructed by gluing 
a 'preAnalyzers' function with one or more 'endAnalyzers' functions. Most of the endAnalysers
functions are currently unused but are still available for curiosity's sake. 

# Tests 
The sub-directory Tests contains the scripts and tests used to generates the data and figures of
the article http://dx.doi.org/10.1088/1751-8113/45/11/115004. This sub-directory implements
an adhoc test framework which has not stood the test of time. However, the scripts are still available
for the sake of scientific reproducibility. The more interesting scripts are probably the diverse
variants of test*.m which lay in the Demos sub-directory. 

One should note that the generation of correlated random variable are
assured by an external matlab package available at http://www.hermir.org. 

