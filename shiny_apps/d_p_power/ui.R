ui <- fluidPage(titlePanel("Distribution of Cohen's d, p-values, and power curves for an independent two-tailed t-test"),
                sidebarLayout(
                  sidebarPanel(numericInput("N", "Participants per group:", 50, min = 2, max = 1000),
                               sliderInput("d", label = HTML("Cohen's d (&delta;)"), min = 0, max = 2, value = 0.5, step= 0.01),
                               sliderInput("p_upper", "alpha, or p-value (upper limit):", min = 0, max = 1, value = 0.05, step= 0.005),
                               uiOutput("p_low"),
                               h4(textOutput("pow0")),br(),
                               h4(textOutput("pow1")),br(),
                               h4(textOutput("pow2")),br(),
                               h4("The three other plots indicate power for a range of alpha levels (top right), sample sizes per group (bottom left), and effect sizes (bottom right). The bottom right figure illustrates the point that when the true effect size of a study is unknown, the power of a study is best thought of as a curve, not as a single value."),br(),
                               h4("Created by Daniel Lakens, shared under a MIT license. For the code see ", a("GitHub", href="https://github.com/Lakens/shiny_apps/tree/master/p-curves"))
                  ),
                  mainPanel(
                    plotOutput("plot_d", width = "1004px", height = "500px"),
                    splitLayout(style = "border: 1px solid silver:", cellWidths = c(500,500),
                                plotOutput("pdf"),
                                plotOutput("cdf")),
                    splitLayout(style = "border: 1px solid silver:", cellWidths = c(500,500), 
                                plotOutput("power_plot"),
                                plotOutput("power_plot_d")
                    ),
                    h4("Get the code at ", a("GitHub", href="https://github.com/Lakens/p-curves"))
                  )
                )
)