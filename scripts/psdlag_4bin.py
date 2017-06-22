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
#fqL = np.logspace(np.log10(0.005),np.log10(0.6),5)

#B
#fqL = np.array([0.0049999999, 0.018619375, 0.069336227,
#                0.10747115, 0.62032418])

#C
#fqL = np.array([0.0049999999, 0.044733049, 0.10747115,  
#               0.22, 0.56])

#D
fqL = np.logspace(np.log10(0.008999999),np.log10(0.340002000),5)
nfq = len(fqL) - 1
fqd = 10**(np.log10( (fqL[:-1]*fqL[1:]) )/2.)





P1 = clag.clag('psd10r', [t1], [l1], [l1e], dt, fqL)
p1 = np.ones(nfq)
p1, p1e = clag.optimize(P1, p1)

p1, p1e = clag.errors(P1, p1, p1e)


ref_psd = p1
ref_psd_err = p1e



t2, l2, l2e = np.loadtxt(echo_file).T


P2 = clag.clag('psd10r', [t2], [l2], [l2e], dt, fqL)
p2 = np.ones(nfq)
p2, p2e = clag.optimize(P2, p2)

p2, p2e = clag.errors(P2, p2, p2e)

echo_psd = p2
echo_psd_err = p2e




Cx = clag.clag('cxd10r',
                [[t1,t2]],
                [[l1,l2]],
                [[l1e,l2e]],
                dt, fqL, p1, p2)
# a  good starting point generally
p  = np.concatenate( ((p1+p2)*0.5-0.3,p1*0+0.1) ) 
p, pe = clag.optimize(Cx, p)
#p, pe = clag.errors(Cx, p, pe)

phi, phie = p[nfq:], pe[nfq:]
lag, lage = phi/(2*np.pi*fqd), phie/(2*np.pi*fqd)    
cx, cxe   = p[:nfq], pe[:nfq]

crs_spectrm = cx
crs_spectrm_err = cxe





s, loc, scale = lognorm.fit(lag,loc=.01)




np.savetxt("freq.out",fqL.reshape((-1,len(fqL))))
np.savetxt("ref_psd.out",[ref_psd,ref_psd_err])
np.savetxt("echo_psd.out",[echo_psd,echo_psd_err])
np.savetxt("crsspctrm.out",[crs_spectrm,crs_spectrm_err])
np.savetxt("lag.out",[lag,lage])
