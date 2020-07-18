## app.R ##
# Made by Lisa DeBruine: https://github.com/debruine/shiny/tree/master/withincor
library(shiny)
library(shinyjs)
library(shinydashboard)
library(ggplot2)
library(viridis)

## Functions ----

library(Rcpp)
library(MASS)

withincor_render_plots <- function(cor.true, mx, my, sdx, sdy, n, session) {
    if (n <= 0) {
        n = 100
        updateSliderInput(session, "withincor_n", value = n)
    }
    
    if (cor.true == 1) {
        cor.true = .99
        updateSliderInput(session, "withincor_r", value = cor.true)
    }
    
    #cbbPalette<-c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
    
    #randomly draw data
    cov.mat <- matrix(c(1.0, cor.true, cor.true, 1.0), nrow = 2, byrow = T)
    mu <- c(0,0)
    mat <- mvrnorm(n, Sigma = cov.mat, mu = mu, empirical = FALSE)
    x<-mat[,1]*sdx+mx
    y<-mat[,2]*sdy+my
    dif<-y-x
    datasetplot<-data.frame(x,y)
    dataset <- data.frame(
        DV = c(x,y),
        IV = rep(c(1, 2), each = n)
    )
    
    t <- t.test(y, x, alternative = "two.sided",
                paired = TRUE,
                conf.level = 0.95) #t-test
    
    p1 <- ggplot(dataset, aes(DV, fill = as.factor(IV)))  +
        geom_histogram(alpha=0.4, binwidth=2,
                       position="identity",
                       colour="black",
                       aes(y = ..density..),
                       show.legend = F) +
        #scale_fill_manual(values=cbbPalette, name = "Condition") +
        scale_fill_viridis(discrete=TRUE) + # viridis is better for colourblindness
        stat_function(fun=dnorm, args=c(mean=mx,sd=sdx), size=1,
                      color=viridisLite::viridis(2)[1], lty=2) +
        stat_function(fun=dnorm, args=c(mean=my,sd=sdy), size=1,
                      color=viridisLite::viridis(2)[2], lty=2) +
        xlab("IQ") +
        ylab("number of people")  +
        #ggtitle("Data") +
        theme_bw(base_size=16) +
        theme(panel.grid.major.x = element_blank(),
              axis.text.y = element_blank(),
              panel.grid.minor.x = element_blank()) +
        geom_vline(xintercept=mean(x), colour="black", linetype="dashed", size=1) +
        geom_vline(xintercept=mean(y), colour="black", linetype="dashed", size=1) +
        coord_cartesian(xlim=c(50,150)) + scale_x_continuous(breaks=seq(50, 150, by = 10)) +
        #annotate("text", x = 70, y = 0.02,
        #         label = paste("Mean X = ",round(mean(x)),"\n","SD = ",round(sd(x)),sep="")) +
        #annotate("text", x = 130, y = 0.02,
        #         label = paste("Mean Y = ",round(mean(y)),"\n","SD = ",round(sd(y)),sep="")) +
        theme(plot.title = element_text(hjust = 0.5)) +
        ggtitle(paste0("Twin 1: M = ",round(mean(x),1),", ","SD = ",round(sd(x), 1),
                       "\nTwin 2: M = ",round(mean(y),1),", ","SD = ",round(sd(y), 1)))
    
    
    #plot data differences
    p2 <- ggplot(as.data.frame(dif), aes(dif))  +
        geom_histogram(colour="black", fill="deepskyblue2", aes(y=..density..), binwidth=2) +
        #  geom_density(fill=NA, colour="black", size = 1) +
        xlab("IQ dif") + ylab("number of pairs")  +
        #ggtitle("Data") +
        theme_bw(base_size=16) +
        theme(panel.grid.major.x = element_blank(),
              axis.text.y = element_blank(),
              panel.grid.minor.x = element_blank()) +
        geom_vline(xintercept=mean(dif), colour="gray20", linetype="dashed") +
        coord_cartesian(xlim=c(-80,80)) +
        scale_x_continuous(breaks=c(seq(-80, 80, 10))) +
        #annotate("text", x = mean(dif), y = 0.01,
        #         label = paste("Mean = ",round(mean(dif)),"\n","SD = ",round(sd(dif)),sep="")) +
        ggtitle(paste0("M = ",round(mean(dif)),"; ","SD = ",round(sd(dif)))) +
        theme(plot.title = element_text(hjust = 0.5))
    
    #Plot correlation
    p3 <- ggplot(datasetplot, aes(x=x, y=y)) +
        geom_point(size=2, alpha = 0.5) +    # Use hollow circles
        geom_smooth(method=lm, colour="#E69F00", size = 1, fill = "#56B4E9") + # Add linear regression line
        coord_cartesian(xlim=c(40,160), ylim=c(40,160)) +
        scale_x_continuous(breaks=c(seq(40, 160, 20))) +
        scale_y_continuous(breaks=c(seq(40, 160, 20))) +
        xlab("IQ twin 1") + ylab("IQ twin 2")  +
        ggtitle(paste("Correlation = ",round(cor(x,y),digits=2),sep="")) +
        theme_bw(base_size=16) +
        theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()) +
        #coord_fixed(ratio = 1)  +
        theme(plot.title = element_text(hjust = 0.5))
    
    list(p1, p2, p3, t)
}



## Interface Tab Items ----

### withincor_tab ----
withincor_tab <- tabItem(
    tabName = "withincor_tab",
    tags$span("App created by"),
    tags$a(href = "https://github.com/debruine/shiny/tree/master/withincor","Lisa DeBruine."), 
    tags$span("This app lets you try out the code from Daniël Lakens' blog post: "),
    tags$a(href = "http://daniellakens.blogspot.com/2016/11/why-within-subject-designs-require-less.html",
           "Why Within-Subject Designs Require Fewer Participants than Between-Subject Designs."),
    p("Try changing the correlation and see how the SD of the difference scores
    changes and what effect this has on the test statistic."),
    fluidRow( # start row 1
        column( # start column 1
            width = 3,
            box(
                title = "Parameters",
                width = NULL,
                sliderInput("withincor_r", "Correlation:", min = -1, max = 1, value = 0.25, step = 0.01),
                sliderInput("withincor_n", "N:", min = 0, max = 1e4, value = 1000, step = 50),
                sliderInput("withincor_m1", "Mean 1:", min = 50, max = 150, value = 100, step = 1),
                sliderInput("withincor_sd1", "SD 1:", min = 0, max = 20, value = 10, step = 1),
                sliderInput("withincor_m2", "Mean 2:", min = 50, max = 150, value = 105, step = 1),
                sliderInput("withincor_sd2", "SD 2:", min = 0, max = 20, value = 10, step = 1),
                actionButton("withincor_resim", "Re-Simulate")
            )
        ), # end column 1
        column( # start column 2
            width = 5,
            box(
                title = "Data",
                width = NULL,
                plotOutput(outputId = "withincor_plot1", height = "auto")
            ),
            box(
                title = "Difference Scores",
                width = NULL,
                plotOutput(outputId = "withincor_plot2", height = "auto")
            )
        ), # end column 2
        column( # start column 3
            width = 4,
            box(
                title = "T-Test",
                width = NULL,
                textOutput(outputId = "ttext")
            ),
            box(
                title = "Correlation",
                width = NULL,
                plotOutput(outputId = "withincor_plot3", height = "auto")
            )
        ) # end column 3
    ) # end row 1
)



## UI ----
ui <- dashboardPage(
    dashboardHeader(title = "Within-Between"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Within", tabName = "withincor_tab")
        )
    ),
    dashboardBody(
        useShinyjs(),
        tabItems(
            withincor_tab
        )
    )
)

## server ----
server <- function(input, output, session) {
    addClass(selector = "body", class = "sidebar-collapse")
    
    withincor_plots <- reactive({
        resim <- input$withincor_resim
        
        withincor_render_plots(input$withincor_r,
                               input$withincor_m1,
                               input$withincor_m2,
                               input$withincor_sd1,
                               input$withincor_sd2,
                               input$withincor_n,
                               session)
    })
    
    output$ttext <- renderText({
        t <- withincor_plots()[4][[1]]
        
        p <- ifelse(t$p.value < .001, "< .001", paste("=", round(t$p.value, 3)))
        
        paste0("t = ", round(t$statistic, 2),
               "; df = ", t$parameter,
               "; p ", p)
    })
    
    output$withincor_plot1 <- renderPlot({
        withincor_plots()[1]
    }, height = function() {
        session$clientData$output_withincor_plot1_width/2
    })
    
    output$withincor_plot2 <- renderPlot({
        withincor_plots()[2]
    }, height = function() {
        session$clientData$output_withincor_plot2_width/2
    })
    
    output$withincor_plot3 <- renderPlot({
        withincor_plots()[3]
    }, height = function() {
        session$clientData$output_withincor_plot3_width
    })
    
} # end server()

shinyApp(ui, server)
