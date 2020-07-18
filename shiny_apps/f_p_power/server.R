server <- function(input, output) {
  output$plot_f <- renderPlot({
    N<-input$N
    J<-input$group
    eta_pop<-input$eta_pop
    alpha<-input$alpha
    xmax<-input$xmax
    ymax<-input$ymax
    
    xmin <- -2
    #Calculations
    df1 <- J-1
    df2 <- J*(N - 1)
    Ntot = N*J
    ncp = Ntot/(1/eta_pop-1)
    crit_f <- qf(1 - alpha, df1, df2)
    
    x=seq(xmin,xmax,length=1000)
    #F-value function
    eta_pop_dist <- function(x) df((x*df2)/(df1-x*df1), df1, df2, ncp)
    par(bg = "aliceblue")
    plot(-10,xlab=substitute(paste(eta[p]^2)), ylab="Density", axes=FALSE,
         main=substitute(paste("distribution for ",eta[p]^2 == eta_pop," for ",J," groups and ", N, " observations per group.")), xlim=c(0,xmax),  ylim=c(0, ymax))
    axis(side=1, at=seq(0,xmax, 0.1), labels=seq(0,xmax, 0.1))
    axis(side=2)
    ncp<-0
    eta_pop_crit<-(crit_f*df1)/(crit_f*df1+df2)
    
    curve(eta_pop_dist, 0.00000000001, 1, n=10000, col="grey", lwd=2, add=TRUE)
    x=seq(eta_pop_crit,xmax,length=10000) 
    z<-df((x*df2)/(df1-x*df1), df1, df2) #determine upperbounds polygon
    polygon(c(eta_pop_crit,x,1),c(0,z,0),col=rgb(1, 0, 0,0.5)) #draw polygon
    #Add Type 2 error rate
    ncp = Ntot/(1/eta_pop-1)
    curve(eta_pop_dist, 0.00000000001, 1, n=10000, col="black", lwd=2, add=TRUE)
    y=seq(0.00000000001,eta_pop_crit,length=10000) 
    z<-df((y*df2)/(df1-y*df1), df1, df2, ncp) #determine upperbounds polygon
    polygon(c(y,eta_pop_crit,eta_pop_crit),c(0,z,0),col=rgb(0, 0, 1,0.5))
    segments(eta_pop_crit, 0, eta_pop_crit, ymax-0.03, col= 'black', lwd=2)
    text(eta_pop_crit, pos=4, ymax-0.02, paste("Effects observed in the sample that are > ",round(eta_pop_crit,2),"will be statistically significant"), cex = 1)
  })
  output$plot_pdf <- renderPlot({
    N<-input$N
    J<-input$group
    eta_pop<-input$eta_pop
    alpha<-input$alpha
    xmax<-input$xmax
    
    #Calculations
    df1 <- J-1
    df2 <- J*(N - 1)
    Ntot = N*J
    ncp = Ntot/(1/eta_pop-1)
    crit_f <- qf(1 - alpha, df1, df2)
    ymax<-25 #Maximum value y-scale (only for p-curve)
    
    
    pdf2_F <- function(alpha) df(qf(1-alpha,df1,df2,0),df1,df2,ncp)/df(qf(1-alpha,df1,df2,0),df1,df2,0)
    par(bg = "aliceblue")
    plot(-10,xlab="P-value", ylab="Density", axes=FALSE,
         main=substitute(paste("P-value distribution for ",eta[pop] == eta_pop," and N =",N)), xlim=c(0,1),  ylim=c(0, ymax))
    abline(v = seq(0,1,0.1), h = seq(0,ymax,5), col = "lightgray", lty = 1)
    axis(side=1, at=seq(0,1, 0.1), labels=seq(0,1,0.1))
    axis(side=2)
    cord.x <- c(0.00000000000001,seq(0.00000000000001,alpha,0.001),alpha) 
    cord.y <- c(0.00000000000001,pdf2_F(seq(0.00000000000001, alpha, 0.001)),0)
    polygon(cord.x,cord.y,col=rgb(1, 0, 0,0.5))
    curve(pdf2_F, 0, 1, n=1000, col="black", lwd=2, add=TRUE)
  })
  output$plot_cdf <- renderPlot({
    N<-input$N
    J<-input$group
    eta_pop<-input$eta_pop
    alpha<-input$alpha
    xmax<-input$xmax
    
    #Calculations
    df1 <- J-1
    df2 <- J*(N - 1)
    Ntot = N*J
    ncp = Ntot/(1/eta_pop-1)
    crit_f <- qf(1 - alpha, df1, df2)
    
    cdf2_F<-function(alpha) 1-pf(qf(1-alpha,df1,df2,0),df1,df2,ncp)
    par(bg = "aliceblue")
    plot(-10,xlab="Alpha", ylab="Power", axes=FALSE,
         main=substitute(paste("Power for F-test with ",eta[pop] == eta_pop," and N = ",N)), xlim=c(0,1),  ylim=c(0, 1))
    abline(v = seq(0,1,0.1), h = seq(0,1,0.1), col = "lightgray", lty = 1)
    axis(side=1, at=seq(0,1, 0.1), labels=seq(0,1,0.1))
    axis(side=2)
    curve(cdf2_F, 0, 1, n=1000, col="black", lwd=2, add=TRUE)
    points(x=alpha, y=(1 - pf(qf(1-input$alpha,df1,df2,0),df1,df2,ncp)), cex=2, pch=19, col=rgb(1, 0, 0,0.5))
    
  })
  output$text1 <- renderText({
    N<-input$N
    J<-input$group
    eta_pop<-input$eta_pop
    alpha<-input$alpha
    df1 <- J-1
    df2 <- J*(N - 1)
    Ntot = N*J
    ncp = Ntot/(1/eta_pop-1)
    Fvalue<-(eta_pop*df2)/(df1-eta_pop*df1)
    crit_f = qf(1-alpha, df1, df2) # <- does not work. 
    eta_pop_crit<-(crit_f*df1)/(crit_f*df1+df2)
    cohen_f<-sqrt(Fvalue*(df1/df2))
    cohen_f<-sqrt(eta_pop/(1-eta_pop))
    crit_f <- qf(1 - alpha, df1, df2)
    power_anova <- pf(crit_f, df1, df2, ncp = ncp, lower.tail = FALSE)
    mean_f<-df2/(df2-2)
    
    f<-4
    eta_pop_from_f<-(f*df1)/(f*df1+df2)
    eta_pop<-eta_pop_from_f
    eta_pop
    f_from_eta_pop<-(eta_pop*df2)/(df1-eta_pop*df1)
    f<-f_from_eta_pop
    f
    
    
    paste("With an observed eta_pop of ", eta_pop," the F-value is ",round(Fvalue,2), ". The critical F-value is ",round(crit_f,2),". The critical value for eta_pop is ",round(eta_pop_crit,2),". Cohen's f = ",round(cohen_f,2), ". The ncp = ",round(ncp,2),". The total sample size is ",Ntot,". The power is ",round(power_anova,2))
  })
}
