#Make sure JAGS is installed or R will crash: https://sourceforge.net/projects/mcmc-jags/files/JAGS/4.x/
require(BEST) #To calculate HDI
require(TOSTER) #To calculate Equivalence Tests

set.seed(1)

x<-rnorm(100) #Generate 100 random normally distributed observations
y<-rnorm(100) #Generate 100 random normally distributed observations

# ROPE test
# Skipped when compiling because it takes so long - data is loaded below
BESTout<-BESTmcmc(x,y)
plot(BESTout)

#TOST test
TOSTtwo.raw(m1=mean(x),m2=mean(y),sd1=sd(x),sd2=sd(y),n1=length(x),n2=length(y),low_eqbound=-0.5,high_eqbound=0.5, alpha=0.025)


# ROPE power analysis
# Skipped when compiling because it takes so long - data is loaded below
# 1. Generate idealised data set:
proData <- makeData(mu1=0, sd1=1, mu2=0, sd2=1, nPerGrp=10000,
                    pcntOut=0, sdOutMult=1.0, rnd.seed=1)

# 2. Generate credible parameter values from the idealised data:
proMCMC <- BESTmcmc(proData$y1, proData$y2, numSavedSteps=2000)

# 3. Compute the prospective power for planned sample sizes:

N1plan <- N2plan <- 100
powerPro <- BESTpower(proMCMC, N1=N1plan, N2=N2plan,
                      ROPEm=c(-0.5,0.5), ROPEsd=c(-10,10), ROPEeff=c(-10,10),
                      maxHDIWm=15.0, maxHDIWsd=10.0, maxHDIWeff=10.0, nRep=2000)
powerPro

#TOST power analysis
powerTOSTtwo.raw(alpha=0.025,statistical_power=0.875,low_eqbound=-0.5,high_eqbound=0.5,sdpooled=1)

save.image("data/BESTout.Rdata")