

default <- data.frame(
  
  study = as.factor(
    c("Fleming (1986)", 
             "Greenwood (1989)",
             "Nahlen (1989)",
             "Parise I (1998)",
             "Parise II (1998)",
             "Shulman (1999)",
             "Njagi I (2003)",
             "Njagi II (2003)",
             "Challis (2004)",
             "Menendez (2008)")
    ),
  
  year = c(1986, 1989, 1989, 1998,
            1998, 1999, 2003, 2003,
            2004, 2008),

  
  
  # treatment - yes, no, N
  Ty = c(2, 4, 6, 34, 
          22, 30, 28, 22, 
          18, 18),
  
  TN = c(106, 21, 23, 348, 
          327, 567, 172, 148, 
          208, 133),
  
  
  # control - yes, no, N
  Cy = c(5, 5, 6, 48, 
          48, 199, 35, 45, 
          40, 30),
  
  CN = c(22, 13, 22, 178, 
          177, 564, 170, 134, 
          203, 127),
  
  # weight
  weight = c(0.045, 0.067, 0.077, 0.12, 
              0.115, 0.122, 0.116, 0.116, 
              0.111, 0.11)
  )
  
  default$Tno = default$TN-default$Ty
  default$Cno = default$CN-default$Cy
  


  ## calculating RR, etc. manually --------------------------------------------
  
  default$TOR <- default$Ty/default$TN
  default$COR <- default$Cy/default$CN
  default$RR <- round(default$TOR/default$COR, 2)
  
  ## confidence interval - page 25
  # http://www.biostat.umn.edu/~susant/Fall10ph6414/Lesson14_complete.pdf
  
  
  #1. estimate RR
  default$RR
  #2. find log(RR) which is point est for CI
  default$lnRR <- log(default$RR)
  #3. 1.96*se
  #4. calculate se of ln(RR)
  default$se <- sqrt((Tno/(Ty*TN)) + (Cno/(Cy*CN)))
  #5. calculate lower and upper limits
  # ln(RR) +/- 1.96* SE LN(RR)
  default$ul <- default$lnRR+1.96*default$se
  default$ll <- default$lnRR-1.96*default$se
  # 6. find limits on the original scale exp(ll), exp(ul)
  default$ciUpper <- round(exp(default$ul), 2)
  default$ciLower <- round(exp(default$ll), 2)
  
  # overall - weighted average
  weightedRR <- sum(default$RR*(default$Ty+default$CN))/sum(default$TN+default$CN)
  round(sum(default$RR*default$weight)/sum(default$weight), 2)
  #http://sphweb.bumc.bu.edu/otlt/MPH-Modules/BS/BS704-EP713_Confounding-EM/BS704-EP713_Confounding-EM7.html  

  
  lnWeightedRR <- log(weightedRR)
  totalSE <- sqrt(sum(default$Tno)/(sum(default$Ty)*sum(default$TN)) 
                  + (sum(default$Cno)/(sum(default$Cy)*sum(default$CN))))
  weightedU <- lnWeightedRR+1.96*totalSE
  weightedL <- lnWeightedRR-1.96*totalSE
  
  weightedUpper <- round(exp(weightedU), 2)
  weightedLower <- round(exp(weightedL), 2)
  
  total <- data.frame(study="total", 
                      RR=weightedRR,
                      ciUpper=weightedRR,
                      ciLower=weightedRR,
                      weight=0)
  
  toPlot <- data.frame(study=default$study, 
                       RR=default$RR,
                       ciUpper=default$ciUpper,
                       ciLower=default$ciLower,
                       weight=default$weight)
  
  toPlot <- rbind(toPlot, total)
  
  
  ggplot(toPlot, aes(x=RR, y=study)) +
    geom_point() +
    geom_errorbarh(aes(xmax=toPlot$ciUpper, xmin=toPlot$ciLower, height=0)) +
    geom_point(data=total, aes(x=RR, y=study), color="red", shape=18, size=15)
  
  # plot
  ggplot(toPlot, aes(x=RR, y=study)) +
    geom_point(shape=15, size=(toPlot$weight*20), color="blue") +
    geom_point(data=total, aes(x=RR, y=study), color="black", shape=18, size=10) +
    geom_errorbarh(aes(xmax=toPlot$ciUpper, xmin=toPlot$ciLower, height=0)) +
    xlim(0,3) +
    labs(y="Study", x="Risk Ratio") +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank()
    ) +
    geom_vline(xintercept=1)
  
  
