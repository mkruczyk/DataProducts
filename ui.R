shinyUI(
        navbarPage("MPG!",
                tabPanel("Prediction",
                         fluidPage(
                                 headerPanel("Miles Per Galon Prediction"),
                                 fluidRow(
                                         column(3, 
                                                radioButtons("id1", "Variable",
                                                             c("Nr of cylinders" = "2",
                                                               "Gross horsepower" = "4",
                                                               "Weight (lb/1000)" = "6",
                                                               "Transmission" = "9"))
                                                ),
                                         column(9,
                                                h3("Distribution of the variable"),
                                                plotOutput('myPlot')
                                                )
                                         ),
                                 hr(),
                                 fluidRow(
                                         column(3, NULL),
                                         column(9,
                                                h3("Miles per Gallon versus Selected Varibale"),
                                                plotOutput('myPlot2')
                                                )
                                         ),
                                 hr(),
                                 fluidRow(
                                         column(3, 
                                                radioButtons("cyl", "Number of Cylinders", c("4"="4", "6"="6", "8"="8"), inline=T),
                                                sliderInput('hp', 'Gross horsepower',value = 150, min = 55, max = 335, step = 5),
                                                sliderInput('wt', 'Weight',value = 3.2, min = 1.5, max = 5.4, step = 0.1),
                                                radioButtons("am", "Transmission", c("Automatic"="0", "Manual"="1"), inline=T)
                                                ),
                                         column(9, 
                                                h3("Prediction"),
                                                verbatimTextOutput("fit"),
                                                verbatimTextOutput("interval")
                                                )
                                         )
                                 )
                         ),
                tabPanel("Documentation",
                         fluidPage(
                                 fluidRow(
                                         includeMarkdown("Documentation.md")
                                         )
                                 )
                        )
        )
)