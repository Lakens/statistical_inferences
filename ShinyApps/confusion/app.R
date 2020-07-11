# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# this app uses Kim (2014)
# to explore cutpoints on a ROC curve
# created by: Amy Finnegan
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




# setup =======================================================================

library(dplyr)
library(magrittr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(plotly)

# default data ================================================================


BDI <- data.frame(Scale=rep("BDI-II", 12),
                  cutoff=c("max",11,12,13,14,15,16,17,18,19,20,"min"),
                  specificity=c(0, 0.588, 0.638, 0.686,
                                0.739, 0.774, 0.794,
                                0.829, 0.866, 0.906, 0.930, 1),
                  sensitivity=c(1, 0.849, 0.830, 0.811,
                                0.774, 0.745, 0.679,
                                0.623, 0.575, 0.557, 0.500, 0))
rownames(BDI) <- BDI$cutoff


CDI <- data.frame(Scale=rep("CDI-II-S", 11),
                  cutoff=c("max",47,48,50,52,53,54,56,57,58,"min"),
                  specificity=c(0, 0.456, 0.474, 0.553,
                                0.662, 0.667, 0.735,
                                0.750, 0.785, 0.831, 1),
                  sensitivity=c(1, 0.868, 0.868, 0.792,
                                0.689, 0.689, 0.594,
                                0.594, 0.509,
                                0.472, 0))
rownames(CDI) <- CDI$cutoff

ui <- navbarPage(
  title=HTML("<a href=\"http://www.designsandmethods.com/book/\" target=_blank>
             Global Health Research</a>"),
  
  # title=HTML("<img src=logo.png style=width:42px;height:42px;border:0;align:right;>
  #            <a href=\"http://www.designsandmethods.com/book/\" target="_blank">
  #            Global Health Research</a>"),
  
  id="nav",
  #theme="http://bootswatch.com/spacelab/bootstrap.css",
  #inverse=TRUE,
  windowTitle="Shiny GHR",
  collapsible=TRUE,
  
  tabPanel(
    title="Reciever Operating Characteristic Curve (ROC)",
    dashboardPage(
      #header=dashboardHeader(title=tags$a(href='http://www.designsandmethods.com/',
      #tags$img(src='logo.png'))),
      header=dashboardHeader(disable=TRUE),
      sidebar=dashboardSidebar(disable = TRUE),
      body=dashboardBody(
        
        fluidPage(
          
          fluidRow(column(12, align="left",
                          
                          # instructions
                          h4("This Shiny app reproduces a Receiver Operating Characteristic Curve (ROC)
                                from Kim, et al. (2014) that compares cut-points on two scales to
                                measure depression among adolescents in Malawi. Hover over each point 
                                to see the cut-point on the depression scale. Which one maximizes the 
                                sensitivy and specificity of the scale's measure of depression?"
                          ))),
              
              fluidRow(
                column(12, align="center",
                    plotlyOutput("ROC", width="547px", height="426px")
                       ),
                fluidRow(column(12, align="left",
                                
                                h4("Answer: BDI-II's accuracy is best at a cutpoint of 15.  
                                   CDI-II-S's accuracy is best at a cupoint of 53.")))
              )
                

                
            )
    ))),

tabPanel(
  title="About",
  dashboardPage(
    header=dashboardHeader(disable=TRUE),
    sidebar=dashboardSidebar(disable = TRUE),
    body=dashboardBody(
      fluidPage(
        
        # about text
        fluidRow(column(12, align="left",
                        
                        # credits
                        img(src='logo.png', align = "left"),
                        
                        withTags({
                          
                          div(class="header",
                              
                              p("This app was created by ",
                                
                                a("Amy Finnegan",
                                  href="https://sites.google.com/site/amyfinnegan/home", target="_blank"),
                                
                                "and Eric Green for the online textbook" ,
                                
                                a("Global Health Research: Designs and Methods.",
                                  href="http://www.designsandmethods.com/book/", target="_blank"),
                                
                                "It is based on the following article:"),
                              
                              
                              
                              p("Kim, et al. (",
                                
                                a("2014",
                                  href="http://jiasociety.org/index.php/jias/article/view/18965/3868",
                                  target="_blank"),
                              
                              "). Prevalence of Depression and Validation of the Beck Depression 
                              Inventory-Ii and the Children’s Depression Inventory-Short Amongst 
                              Hiv-Positive Adolescents in Malawi.” Journal of the International AIDS Society 17 (1).")
                              
                              
                                )
                        })
                        
                        ))))))
)


                
   
  
  server <- function(input, output) {

    #http://stackoverflow.com/questions/38733403/edit-labels-in-tooltip-for-plotly-maps-using-ggplot2-in-r
    output$ROC <- renderPlotly({
      
         
         gg <-
         ggplot(CDI, aes(x=1-specificity, y=sensitivity, group=Scale, color=Scale, text = paste("Cut Point:", cutoff))) +
           geom_line() +
           geom_point() +
           geom_line(aes(x=1-specificity, y=sensitivity), data=BDI,
                     linetype="dashed") +
           geom_point(aes(1-specificity, y=sensitivity), data=BDI) +
           xlim(0,1) +
           ylim(0,1) +
           labs(title="ROC Curves for Comparison",
                x="1-Specificity",
                y="Sensitivity") +
           geom_abline(intercept=0, slope=1) +
           annotate(geom="text", x=0.24, y=0.9, label="better than random", size=4) +
           annotate(geom="text", x=0.7, y=0.28, label="worse than random", size=4) +
           annotate(geom="text", x=0.75, y=0.70, label="no diagnostic benefit", size=4) +
           theme_bw() +
           scale_colour_manual(values=c("black", "black")) +
           theme(plot.title=element_text(hjust=0.5, size=rel(2)),
                 axis.title=element_text(size=20),
                 panel.grid.major=element_line(color="lightgrey"),
                 panel.grid.minor=element_blank(),
                 legend.position="bottom")
         
         
          ggplotly(gg, tooltip=c("text"))
      

    

    

      
      
    })
    
    

    
    
  }
  
  shinyApp(ui, server)



