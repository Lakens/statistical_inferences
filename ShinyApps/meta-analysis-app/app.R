# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# this app uses analysis 1.6 from http://onlinelibrary.wiley.com/wol1/doi/10.1002/14651858.CD000169.pub3/figures
# to explore how a meta-analysis works
# created by: Amy Finnegan
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




# setup =======================================================================

library(dplyr)
library(magrittr)
library(ggplot2)
library(shiny)
library(meta)
library(shinydashboard)

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

# treatment - yes, no, N
Ty <- c(2, 4, 6, 34,
        22, 30, 28, 22,
        18, 18)
TN <- c(106, 21, 23, 348,
        327, 567, 172, 148,
        208, 133)


# control - yes, no, N
Cy <- c(5, 5, 6, 48,
        48, 199, 35, 45,
        40, 30)
CN <- c(22, 13, 22, 178,
        177, 564, 170, 134,
        203, 127)

default <- data.frame(
  study=study,
  Ty=as.numeric(Ty),
  TN=as.numeric(TN),
  Cy=as.numeric(Cy),
  CN=as.numeric(CN)
)


# set the study you want to manipulate with the app by name
toChange <- "Shulman (1999)"



# Define UI for application

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
                   title="Meta-Analysis App",
                   dashboardPage(
                     #header=dashboardHeader(title=tags$a(href='http://www.designsandmethods.com/',
                                                         #tags$img(src='logo.png'))),
                     header=dashboardHeader(disable=TRUE),
                     sidebar=dashboardSidebar(disable = TRUE),
                     body=dashboardBody(
fluidPage(

  # Show a forest plot and a table of included values

  fluidRow(column(12, align="left",

           # instructions
           h4("This Shiny app reproduces the results of a meta-analysis
                           of the effects of chemoprevention on parasitaemia
                           (Radeva-Petrova et al., 2014). Note that the pooled risk ratio
                           is 0.39, which favors chemoprevention. Use the buttons below
                           to explore two key drivers of meta-analysis results:
                           study sample size and effect size estimates. The study with
                           the largest sample size is an RCT by Shulman et al. (1999)
                           with 1,131 women. What happens to the confidence interval on
                           the Shulman et al. effect size estimate if the sample size is
                           one-tenth as big? Reset to the original sample size and then
                           explore what happens if there is no effect, or if the study
                           results flip to favoring the control group."
           ))),


  fluidRow(column(12, align="center",

                  actionButton("smallN", "Small Sample",
                               style="color: #fff; background-color: #E7A34D"),

                  actionButton("noEffect", "No effect",
                               style="color: #fff; background-color: #6781CF"),

                  actionButton("favorsControl", "Favours Control",
                               style="color: #fff; background-color: #6781CF"),

                  actionButton("reset", "Reset to original values", icon("undo"),
                               style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),

                  tags$style(type="text/css", "#noEffect { margin-left: 2px; }"),

                  plotOutput("forestPlot", width="100%")


                  )



  )
  )))),
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

                          "It is based on the following systematic review:"),



                          p("Radeva-Petrova, D., Kayentao, K., ter Kuile, F. O., Sinclair, D.,
                          & Garner, P. (",

                          a("2014",
                            href="http://onlinelibrary.wiley.com/doi/10.1002/14651858.CD000169.pub3/abstract",
                            target="_blank"),

                          "). Drugs for preventing malaria in pregnant
                          women in endemic areas: any drug regimen versus placebo or no treatment.
                          Cochrane Database Syst Rev, 10, CD000169.")
                          )
                        })

                        ))))))
)


# Define server logic to draw forestplot and table

server <- function(input, output) {

  values <- reactiveValues(default=default)

  observeEvent(input$reset, {

    values$default <- default

  })

  observeEvent(input$smallN, {

    values$default$Ty[values$default$study==toChange] <- 3
    values$default$Cy[values$default$study==toChange] <- 20

    values$default$TN[values$default$study==toChange] <- 57
    values$default$CN[values$default$study==toChange] <- 56


  })


  observeEvent(input$noEffect, {

    values$default$Ty[values$default$study==toChange] <- 200
    values$default$Cy[values$default$study==toChange] <- 199

    values$default$TN[values$default$study==toChange] <- 567
    values$default$CN[values$default$study==toChange] <- 564

  })

  observeEvent(input$favorsControl, {

    values$default$Ty[values$default$study==toChange] <- 500
    values$default$Cy[values$default$study==toChange] <- 50

    values$default$TN[values$default$study==toChange] <- 567
    values$default$CN[values$default$study==toChange] <- 564

  })


  output$forestPlot <- renderPlot({

    # plot

    mh<-  metabin(event.e=values$default$Ty, n.e=values$default$TN, event.c=values$default$Cy, n.c=values$default$CN)
    mh$studlab <- as.character(values$default$study)

    forest(mh, studlab = T, comb.fixed=F,
           col.square=ifelse(mh$studlab=="Shulman (1999)", "orange", "blue"),
           col.diamond="black",
           squaresize=0.5,
           text.random="Summary",
           plotwidth="4cm",
           label.right="Favours control", col.label.right="black",
           label.left="Favours chemoprevention", col.label.left="black",
           lab.e="Intervention", lab.c="Control"
    )


  })



}

# Run the application
shinyApp(ui = ui, server = server)
