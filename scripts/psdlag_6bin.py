#!/usr/bin/env python
import numpy as np
from scipy.stats import norm
from scipy.stats import lognorm
import sys
import getopt
sys.path.insert(1,"/usr/local/science/clag-agn/data/")
import clag
import matplotlib
# %pylab inline


#ref_file="data/lc/1367A.lc"
#echo_file="data/lc/2246A.lc"

ref_file  = str(sys.argv[1])
echo_file = str(sys.argv[2])


dt = 0.01
t1, l1, l1e = np.loadtxt(ref_file).T
# errorbar(t1, l1, yerr=l1e, fmt='o')

#A
fqL = np.logspace(np.log10(0.0049999999),np.log10(0.340002000),7)

# not done for this bin number
#B
#fqL = np.array([0.0049999999, 0.018619375, 0.044733049,
#                0.069336227, 0.10747115, 0.16658029,
#                0.25819945, 0.40020915])


#C
#fqL = np.array([0.0049999999, 0.018619375, 0.044733049,
#                0.069336227, 0.10747115, 0.16658029,
#                0.25819945, 0.40020915])

nfq = len(fqL) - 1
fqd = 10**(np.log10( (fqL[:-1]*fqL[1:]) )/2.)





P1 = clag.clag('psd10r', [t1], [l1], [l1e], dt, fqL)
p1 = np.ones(nfq)
p1, p1e = clag.optimize(P1, p1)

p1, p1e = clag.errors(P1, p1, p1e)

# xscale('log'); ylim(-4,2)
# errorbar(fqd, p1, yerr=p1e, fmt='o', ms=10, color="black")

ref_psd = p1
ref_psd_err = p1e



t2, l2, l2e = np.loadtxt(echo_file).T
# errorbar(t1, l1, yerr=l1e, fmt='o', color="green")
# errorbar(t2, l2, yerr=l2e, fmt='o', color="black")


P2 = clag.clag('psd10r', [t2], [l2], [l2e], dt, fqL)
p2 = np.ones(nfq)
p2, p2e = clag.optimize(P2, p2)

p2, p2e = clag.errors(P2, p2, p2e)

# xscale('log'); ylim(-6,2)
# errorbar(fqd, p1, yerr=p1e, fmt='o', ms=10, color="green")
# errorbar(fqd, p2, yerr=p2e, fmt='o', ms=10, color="black")
echo_psd = p2
echo_psd_err = p2e




Cx = clag.clag('cxd10r', [[t1,t2]], [[l1,l2]], [[l1e,l2e]], dt, fqL, p1, p2)
p  = np.concatenate( ((p1+p2)*0.5-0.3,p1*0+0.1) ) # a  good starting point generally
p, pe = clag.optimize(Cx, p)

phi, phie = p[nfq:], pe[nfq:]
lag, lage = phi/(2*np.pi*fqd), phie/(2*np.pi*fqd)    
cx, cxe   = p[:nfq], pe[:nfq]

cross_spectrm = cx
cross_spectrm_err = cxe

# xscale('log'); ylim(-2,1)
# errorbar(fqd, lag, yerr=lage, fmt='o', ms=10,color="black")




s, loc, scale = lognorm.fit(lag,loc=.01)
# xscale('log'); ylim(-4,1.5)
# errorbar(fqd, lag, yerr=lage, fmt='o', ms=10,color="black")
##plot(fqd,norm.pdf(fqd,mu,sigma))
#plot(fqd,lognorm.pdf(fqd,s,loc,scale))
# mu,sigma



#plot(ifft(lag))

np.savetxt("freq.out",fqL.reshape((-1,len(fqL))))
np.savetxt("ref_psd.out",[ref_psd,ref_psd_err])
np.savetxt("echo_psd.out",[echo_psd,echo_psd_err])
np.savetxt("crsspctrm.out",[cross_spectrm,cross_spectrm_err])
np.savetxt("lag.out",[lag,lage])
