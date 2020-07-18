server <- function(input, output) {
  #surpress warnings
  options(warn = -1)
  
  output$pdf <- renderPlot({
    N<-input$N
    d<-input$d
    p<-0.05
    p_upper<-input$p_upper+0.00000000000001
    p_lower<-input$p_lower+0.00000000000001
    #    if(p_lower==0){p_lower<-0.0000000000001}
    ymax<-25 #Maximum value y-scale (only for p-curve)
    
    #Calculations
    se<-sqrt(2/N) #standard error
    ncp<-(d*sqrt(N/2)) #Calculate non-centrality parameter d
    
    #p-value function
    pdf2_t <- function(p) 0.5 * dt(qt(p/2,2*N-2,0),2*N-2,ncp)/dt(qt(p/2,2*N-2,0),2*N-2,0) + dt(qt(1-p/2,2*N-2,0),2*N-2,ncp)/dt(qt(1-p/2,2*N-2,0),2*N-2,0)
    par(bg = "aliceblue")
    plot(-10,xlab="P-value", ylab="Density", axes=FALSE,
         main=substitute(paste("P-value distribution for ", delta == d," and N =",N)), xlim=c(0,1),  ylim=c(0, ymax))
    abline(v = seq(0,1,0.1), h = seq(0,ymax,5), col = "lightgray", lty = 1)
    axis(side=1, at=seq(0,1, 0.1), labels=seq(0,1,0.1))
    axis(side=2)
    cord.x <- c(p_lower,seq(p_lower,p_upper,0.001),p_upper) 
    cord.y <- c(0,pdf2_t(seq(p_lower, p_upper, 0.001)),0)
    polygon(cord.x,cord.y,col=rgb(1, 0, 0,0.5))
    curve(pdf2_t, 0, 1, n=1000, col="black", lwd=2, add=TRUE)
  })
  output$cdf <- renderPlot({
    N<-input$N
    d<-input$d
    p_upper<-input$p_upper
    p_lower<-input$p_lower
    ymax<-25 #Maximum value y-scale (only for p-curve)
    
    #Calculations
    se<-sqrt(2/N) #standard error
    ncp<-(input$d*sqrt(N/2)) #Calculate non-centrality parameter d
    
    cdf2_t<-function(p) 1 + pt(qt(p/2,2*N-2,0),2*N-2,ncp) - pt(qt(1-p/2,2*N-2,0),2*N-2,ncp)
    
    par(bg = "aliceblue")
    plot(-10,xlab="Alpha", ylab="Power", axes=FALSE,
         main=substitute(paste("Power for independent t-test with ", delta == d," and N =",N)), xlim=c(0,1),  ylim=c(0, 1))
    abline(v = seq(0,1,0.1), h = seq(0,1,0.1), col = "lightgray", lty = 1)
    axis(side=1, at=seq(0,1, 0.1), labels=seq(0,1,0.1))
    axis(side=2)
    #    cord.x <- c(p_lower,seq(p_lower,p_upper,0.001),p_upper) 
    #    cord.y <- c(0,cdf2_t(seq(p_lower, p_upper, 0.001)),0)
    #    polygon(cord.x,cord.y,col=rgb(1, 0, 0,0.5))
    curve(cdf2_t, 0, 1, n=1000, col="black", lwd=2, add=TRUE)
    points(x=p_upper, y=(1 + pt(qt(input$p_upper/2,2*N-2,0),2*N-2,ncp) - pt(qt(1-input$p_upper/2,2*N-2,0),2*N-2,ncp)), cex=2, pch=19, col=rgb(1, 0, 0,0.5))
  })
  output$power_plot <- renderPlot({
    N<-input$N
    d<-input$d
    p_upper<-input$p_upper
    ncp<-(input$d*sqrt(N/2)) #Calculate non-centrality parameter d
    plot_power <- (function(d, N, p_upper){
      ncp <- d*(N*N/(N+N))^0.5 #formula to calculate t from d from Dunlap, Cortina, Vaslow, & Burke, 1996, Appendix B
      t <- qt(1-(p_upper/2),df=(N*2)-2)
      1-(pt(t,df=N*2-2,ncp=ncp)-pt(-t,df=N*2-2,ncp=ncp))
    }
    )
    par(bg = "aliceblue")
    plot(-10,xlab="sample size (per condition)", ylab="Power", axes=FALSE,
         main=substitute(paste("Power for independent t-test with ", delta == d)), xlim=c(0,N*2),  ylim=c(0, 1))
    abline(v = seq(0,N*2, (2*N)/10), h = seq(0,1,0.1), col = "lightgray", lty = 1)
    axis(side=1, at=seq(0,2*N, (2*N)/10), labels=seq(0,2*N,(2*N)/10))
    axis(side=2, at=seq(0,1, 0.2), labels=seq(0,1,0.2))
    curve(plot_power(d=d, N=x, p_upper=p_upper), 3, 2*N, type="l", lty=1, lwd=2, ylim=c(0,1), xlim=c(0,N), add=TRUE)
    points(x=N, y=(1 + pt(qt(input$p_upper/2,2*N-2,0),2*N-2,ncp) - pt(qt(1-input$p_upper/2,2*N-2,0),2*N-2,ncp)), cex=2, pch=19, col=rgb(1, 0, 0,0.5))
  })  
  output$power_plot_d <- renderPlot({
    N<-input$N
    d<-input$d
    p_upper<-input$p_upper
    ncp<-(input$d*sqrt(N/2)) #Calculate non-centrality parameter d
    plot_power_d <- (function(d, N, p_upper)
    {
      ncp <- d*(N*N/(N+N))^0.5 #formula to calculate t from d from Dunlap, Cortina, Vaslow, & Burke, 1996, Appendix B
      t <- qt(1-(p_upper/2),df=(N*2)-2)
      1-(pt(t,df=N*2-2,ncp=ncp)-pt(-t,df=N*2-2,ncp=ncp))
    }
    )
    par(bg = "aliceblue")
    plot(-10,xlab=substitute(paste("Cohen's ", delta == d)), ylab="Power", axes=FALSE,
         main=substitute(paste("Power for independent t-test with N =",N," per group")), xlim=c(0,2),  ylim=c(0, 1))
    abline(v = seq(0,2, 0.2), h = seq(0,1,0.1), col = "lightgray", lty = 1)
    axis(side=1, at=seq(0,2, 0.2), labels=seq(0,2,0.2))
    axis(side=2, at=seq(0,1, 0.2), labels=seq(0,1,0.2))
    curve(plot_power_d(d=x, N=N, p_upper=p_upper), 0, 2, type="l", lty=1, lwd=2, ylim=c(0,1), xlim=c(0,2), add=TRUE)
    points(x=d, y=(1 + pt(qt(input$p_upper/2,2*N-2,0),2*N-2,ncp) - pt(qt(1-input$p_upper/2,2*N-2,0),2*N-2,ncp)), cex=2, pch=19, col=rgb(1, 0, 0,0.5))
  }) 
  # make dynamic slider 
  output$p_low <- renderUI({
    sliderInput("p_lower", "p-value (lower limit):", min = 0, max = input$p_upper, value = 0, step= 0.005)
  })
  output$pow0 <- renderText({
    p_upper<-input$p_upper
    N<-input$N
    d<-input$d
    VARd<-((N+N)/(N*N))+(d^2/(2*(N+N)))
    SEd<-sqrt(VARd)
    crit_d<-abs(qt(p_upper/2, (N*2)-2))/sqrt(N/2)
    paste("On the top, you can see the distribution of Cohen's d assuming a true effect size of d =",d,"illustrated by the black line. Only observed effect sizes larger than d =",round(crit_d,2),"will be statisically significant with",N,"observations per group. The distribution assuming a Cohen's d of 0 is illustrated by the grey curve. Red areas illustrates Type 1 errors, the blue area illustrates the Type 2 error rate. The distribution has a standard error of",round(SEd,3),".")
  })
  output$pow1 <- renderText({
    N<-input$N
    d<-input$d
    paste("On the right, you can see the p-value distribution for a two-sided independent t-test with",N,"participants in each group, and a true effect size of ", d)
  })
  output$pow2 <- renderText({
    N<-input$N
    d<-input$d
    p_upper<-input$p_upper
    p_lower<-input$p_lower
    ncp<-(input$d*sqrt(N/2)) #Calculate non-centrality parameter d
    p_u<-1 + pt(qt(p_upper/2,2*N-2,0),2*N-2,ncp) - pt(qt(1-p_upper/2,2*N-2,0),2*N-2,ncp) #two-tailed
    p_l<-1 + pt(qt(p_lower/2,2*N-2,0),2*N-2,ncp) - pt(qt(1-p_lower/2,2*N-2,0),2*N-2,ncp) #two-tailed
    paste("The statistical power based on an alpha of",p_upper,"and assuming the true effect size is d =",d,"is",100*round((1 + pt(qt(input$p_upper/2,2*N-2,0),2*N-2,ncp) - pt(qt(1-input$p_upper/2,2*N-2,0),2*N-2,ncp)),digits=4),"%. In the long run, you can expect ",100*round(p_u-p_l, 4),"% of p-values to fall in the selected area between p = ",p_lower,"and p = ",p_upper,".")
  })
  output$plot_d <- renderPlot({
    N<-input$N
    d<-input$d
    p_upper<-input$p_upper
    ncp<-(input$d*sqrt(N/2)) #Calculate non-centrality parameter d
    crit_d<-abs(qt(p_upper/2, (N*2)-2))/sqrt(N/2)
    low_x<-min(-1-crit_d)
    high_x<-max(d+1+crit_d)
    #calc d-distribution
    x=seq(low_x,high_x,length=10000) #create x values
    d_dist<-dt(x*sqrt(N/2),df=(N*2)-2, ncp = ncp)*sqrt(N/2) #calculate distribution of d based on t-distribution
    #Set max Y for graph
    y_max<-max(d_dist)+1
    #create plot
    par(bg = "aliceblue")
    d = round(d,2)
    plot(-10,xlim=c(low_x,high_x), ylim=c(0,y_max), xlab=substitute(paste("Cohen's ", delta == d)), ylab="Density",main=substitute(paste("Distribution of Cohen's ", delta == d,", N = ",N)))
    #abline(v = seq(low_x,high_x,0.1), h = seq(0,0.5,0.1), col = "lightgray", lty = 1)
#    axis(side = 1, at = seq(low_x,high_x,0.1), labels = FALSE)
    lines(x,d_dist,col='black',type='l', lwd=2)
    # add d = 0 line
    d_dist<-dt(x*sqrt(N/2),df=(N*2)-2, ncp = 0)*sqrt(N/2)
    lines(x,d_dist,col='grey',type='l', lwd=1)
    #Add Type 1 error rate right
    crit_d<-abs(qt(p_upper/2, (N*2)-2))/sqrt(N/2)
    y=seq(crit_d,10,length=10000)
    z<-(dt(y*sqrt(N/2),df=(N*2)-2)*sqrt(N/2)) #determine upperbounds polygon
    polygon(c(crit_d,y,10),c(0,z,0),col=rgb(1, 0, 0,0.5))
    #Add Type 1 error rate left
    crit_d<--abs(qt(p_upper/2, (N*2)-2))/sqrt(N/2)
    y=seq(-10, crit_d, length=10000)
    z<-(dt(y*sqrt(N/2),df=(N*2)-2)*sqrt(N/2)) #determine upperbounds polygon
    polygon(c(y,crit_d,crit_d),c(z,0,0),col=rgb(1, 0, 0,0.5))
    #Add Type 2 error rate
    crit_d<-abs(qt(p_upper/2, (N*2)-2))/sqrt(N/2)
    y=seq(-10,crit_d,length=10000)
    z<-(dt(y*sqrt(N/2),df=(N*2)-2, ncp=ncp)*sqrt(N/2)) #determine upperbounds polygon
    polygon(c(y,crit_d,crit_d),c(0,z,0),col=rgb(0, 0, 1,0.5))
    segments(crit_d, 0, crit_d, y_max-0.8, col= 'black', lwd=2)
    text(crit_d, y_max-0.5, paste("Effects larger than d = ",round(crit_d,2),"will be statistically significant"), cex = 1)
  }) 
  
}