library(shiny)
library(shinythemes)
ui <- fluidPage(theme=shinytheme("flatly"),
                titlePanel("F-distribution as a function of sample size per group, number of groups, and the true effect size."),
                sidebarLayout(
                  sidebarPanel(numericInput("N", "Number of participants :", 50, min = 1, max = 1000),
                               numericInput("group", "Number of groups:", 2, min = 2, max = 1000),
                               sliderInput("eta_pop", "eta_pop:", min = 0, max = 1, value = 0.0588, step= 0.001),
                               numericInput("alpha", "Alpha:", 0.05, min = 0, max = 1, step= 0.005),
                               numericInput("xmax", "Maximum value X-axis:", 0.5, min = 0, max = 1, step= 0.1),
                               numericInput("ymax", "Maximum value Y-axis:", 0.5, min = 0.00, max = 100, step= 0.05)
                  ),
                  mainPanel(plotOutput("plot_f"), br(),
                            plotOutput("plot_pdf"), br(),
                            plotOutput("plot_cdf"), br(),
                            h4(textOutput("text1")), br()
                  )
                )
)
