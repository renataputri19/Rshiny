#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)


ui <- dashboardPage(
      dashboardHeader(
        title = "Sampling Distribution and the Central Limit Theorem"),
        
        dashboardSidebar(
            
            helpText('Choose your source distribution and number of items, n, in each sample with 1000 replications.'),
            
            selectInput("Distribution", "Please Select Distribution Type",
                        choices = c("Normal", "Exponential", "Poisson", "ChiSquare", "Uniform", "Gamma", "Student-t","Binomial")),
            
            sliderInput("sampleSize", "Please Select Sample Size: ", min=10, max=1000, value=50, step=10),
            
            conditionalPanel(condition = "input.Distribution == 'Normal'",
                             textInput("mean", "Please Select the Mean", 0),
                             textInput("sd", "Please Select Standard Deviation", 1)),
            
            conditionalPanel(condition = "input.Distribution == 'Exponential'",
                             textInput("lambda", "Please Select Exponential Lambda", 1)),
            
            conditionalPanel(condition = "input.Distribution == 'Poisson'",
                             textInput("lambdaPois", "Please Select Poisson Lambda", 1)),
            
            conditionalPanel(condition = "input.Distribution == 'ChiSquare'",
                             textInput("df", "Please Select Chi Square Degree of Freedom", 3),
                             textInput("ncp", "Please Select Non-Centrality Parameter", 0)),
            
            conditionalPanel(condition = "input.Distribution == 'Uniform'",
                             textInput("min", "Please Select Minimum: ", 0),
                             textInput("max", "Please Select Maximum: ", 1)),
            
            conditionalPanel(condition = "input.Distribution == 'Gamma'",
                             textInput("shape", "Please Select Distribution Shape: ", 1),
                             textInput("scale", "Please Select Distribution Scale: ", 1)),
            
            conditionalPanel(condition = "input.Distribution == 'Student-t'",
                             textInput("df", "Please Select Degree of Freedom", 1)),
            
            conditionalPanel(condition = "input.Distribution == 'Binomial'",
                             textInput("trial", "Trial : ", 1),
                             textInput("prob", "Probability : ", 0.2))
            
        ),
        
        dashboardBody(
            
            plotOutput("myPlot")
            
        )
        
    )
    
