library(dplyr)
library(plyr)
library(magrittr)
library(ggplot2)
library(reshape2)
library(shiny)
library(meta)

# probably should rbind after selecting columns
# just have a summary data.frame -- this will update
# and I want to control the size/shape of the point

# default data set


  study <- c("Fleming (1986)", 
             "Greenwood (1989)",
             "Nahlen (1989)",
             "Parise I (1998)",
             "Parise II (1998)",
             "Shulman (1999)",
             "Njagi I (2003)",
             "Njagi II (2003)",
             "Challis (2004)",
             "Menendez (2008)")
  
  
  year <- c(1986, 1989, 1989, 1998,
            1998, 1999, 2003, 2003,
            2004, 2008)
  
# treatment - yes, no, N
  Ty <- c(2, 4, 6, 34, 
          22, 30, 28, 22, 
          18, 18)
  TN <- c(106, 21, 23, 348, 
          327, 567, 172, 148, 
          208, 133)
  Tno <- TN-Ty

# control - yes, no, N
  Cy <- c(5, 5, 6, 48, 
          48, 199, 35, 45, 
          40, 30)
  CN <- c(22, 13, 22, 178, 
          177, 564, 170, 134, 
          203, 127)
  Cno <- CN-Cy

# weight
  weight <- c(0.045, 0.067, 0.077, 0.12, 
              0.115, 0.122, 0.116, 0.116, 
              0.111, 0.11)
  

  
  default <- data.frame(
          study=study,
          year=year,
          Ty=as.numeric(Ty),
          Tno=as.numeric(Tno),
          TN=as.numeric(TN),
          Cy=as.numeric(Cy),
          Cno=as.numeric(Cno),
          CN=as.numeric(CN),
          weight=as.numeric(weight)
  )
  
  
  # this does all the pieces needed for the plot, still need total ------------
  #https://globalhealthresearch.shinyapps.io/meta-analysis-app/
  default <- 
  default %>%
    mutate(RR = round((Ty/TN)/(Cy/CN), 2),
           ciUpper=round(exp(log(RR)+1.96*(sqrt((Tno/(Ty*TN)) + ((Cno/(Cy*CN)))))), 2),
           ciLower=round(exp(log(RR)-1.96*(sqrt((Tno/(Ty*TN)) + ((Cno/(Cy*CN)))))), 2)
           )

# calculated from deeks document, same as page 25 of:  
  #http://www.biostat.umn.edu/~susant/Fall10ph6414/Lesson14_complete.pdf
  sqrt(1/Ty+1/Cy-1/TN-1/CN)
  
# make a summary matrix that will be updated based on the default data frame
# when the default data frame changes, the summary value should change too
  #http://sphweb.bumc.bu.edu/otlt/MPH-Modules/BS/BS704-EP713_Confounding-EM/BS704-EP713_Confounding-EM7.html
  summary <- as.data.frame(matrix(0, ncol=length(default), nrow=1))
  colnames(summary) <- colnames(default)
  summary$study <- c("Summary")
  summary$RR <- round( sum( default$RR*(default$Ty+default$CN) )/sum( default$TN+default$CN ), 2 )

  
# M-H (Mantel-Haenszel Method) from Deeks 2010
  # default$mhw <- c(a+b)/N
  # a = experiment event
  # b = experiment no event
  # c = control event
  # N = total n
  # 
#   default$mhw <- (default$Cy*(default$Ty+default$Tno))/(default$TN+default$CN)
#   
# # maybe the weight should be out of 100?
#   default$mhw100 <- default$mhw/sum(default$mhw)

# using the given weights I get pretty close
  default %>%
    mutate(ew=RR*weight) %>%
    summarize(sum(ew))

  
  
# data frame of prior + summary
  toPlot <- as.data.frame(rbind(default, summary))


# plot
  ggplot(toPlot, aes(x=RR, y=factor(study, levels=toPlot$study))) +
    geom_point(shape=15, size=(toPlot$weight*20), color="blue") +
    
    # summary has 0 weight so this prints over it
    geom_point(aes(x=summary$RR, y=summary$study), shape=18, size=10, color="black") +
    
    geom_errorbarh(aes(xmax=toPlot$ciUpper, xmin=toPlot$ciLower, height=0)) +
    xlim(0,10) +
    labs(title=paste0("Risk Ratio & 95% CI\n",
                      "Outcome: Parasitaemia (mother)"),
         y="Study", 
         x="Risk Ratio") +
    
    
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank()
    ) +
    geom_vline(xintercept=1)
  
  
  
## try the meta package
  
mh<-  metabin(event.e=Ty, n.e=TN, event.c=Cy, n.c=CN, data=default)
mh$studlab <- as.character(default$study)
forest(mh, studlab = T, comb.fixed=F, 
       col.square="blue",
       col.diamond="black",
       squaresize=0.5,
       text.random="Summary",
       plotwidth="4cm",
       label.right="Favours control", col.label.right="black",
       label.left="Favours chemoprevention", col.label.left="black",
       lab.e="Intervention", lab.c="Control")

forest(mh, layout="RevMan5", comb.random=T)
  