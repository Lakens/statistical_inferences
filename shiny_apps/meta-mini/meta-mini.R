# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# this app uses analysis 1.6 from http://onlinelibrary.wiley.com/wol1/doi/10.1002/14651858.CD000169.pub3/figures
# to explore how a meta-analysis works
# created by: Amy Finnegan
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# try using 

# setup =======================================================================

library(dplyr)
library(magrittr)
library(ggplot2)
library(shiny)
library(miniUI)
library(meta)

# default data ================================================================

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

# calculate RR, and 95% ci
default <- 
  default %>%
  mutate(RR = round((Ty/TN)/(Cy/CN), 2),
         ciUpper=round(exp(log(RR)+1.96*(sqrt((Tno/(Ty*TN)) + ((Cno/(Cy*CN)))))), 2),
         ciLower=round(exp(log(RR)-1.96*(sqrt((Tno/(Ty*TN)) + ((Cno/(Cy*CN)))))), 2)
  )




# Define UI for application 
ui <- miniPage(
   
   # Application title
   miniTitleBar("Meta-Analysis"),
   
   # check boxes to select studies to exclude
   

  miniTabstripPanel(
    
        miniContentPanel(
          
          plotOutput("forestPlot", width="100%"),
          
          helpText("Pick a study.  Change the number of events for treatment, 
                   control or both.  If you choose a value out of range,
                   no Risk Ratio will be calculated."),
          
          fluidRow(
            
            column(4,
                   wellPanel(
                     
                     selectInput("study",
                                 label = "Choose study:",
                                 choices=levels(default$study)))),
            
            column(4,
                   wellPanel(
                     sliderInput("Tevent",
                                 label = "Intervention Event",
                                 min=1, max=max(default$TN),
                                 value=default$Ty[default$study=="Challis (2004)"],
                                 step=1))),
            
            column(4,
                   wellPanel(
                     sliderInput("Cevent",
                                 label = "Control Event",
                                 min=1, max(default$CN),
                                 value=default$Cy[default$study=="Challis (2004)"],
                                 step=1)))
            
          )

    )
)
)

# Define server logic to draw forestplot and table

server <- function(input, output) {
  
  
  # group of studies to consider
  toPlot <- reactive({
    
    a <- default
    a$Ty[a$study==input$study] <- input$Tevent
    a$Cy[a$study==input$study] <- input$Cevent
    
    return(a)
  })
  
  
  
  output$forestPlot <- renderPlot({
    
    # plot
    
    mh<-  metabin(event.e=toPlot()$Ty, n.e=toPlot()$TN, event.c=toPlot()$Cy, n.c=toPlot()$CN)
    mh$studlab <- as.character(toPlot()$study)
    
    forest(mh, studlab = T, comb.fixed=F, 
           col.square="blue",
           col.diamond="black",
           squaresize=0.5,
           text.random="Summary",
           plotwidth="4cm"
    )
    
    
  })
   
   

}

# Run the application 
shinyApp(ui = ui, server = server)

