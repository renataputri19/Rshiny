#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

r <- 1000

# Define server logic required to draw a histogram
shinyServer(

    function(input, output, session) {
        
        rv <- reactiveValues(sample = NULL,
                             all.means = NULL)
        
        output$myPlot <- renderPlot({
            
            distType <- input$Distribution
            
            size <- input$sampleSize
            
            randomVec <- switch(input$Distribution,
                                "Normal" = matrix(rnorm(size*r, mean = as.numeric(input$mean), sd=as.numeric(input$sd)), r),
                                "Exponential" = matrix(rexp(size*r, rate = 1/as.numeric(input$lambda)), r),
                                "Poisson" = matrix(rpois(size*r, lambda = as.numeric(input$lambdaPois)), r),
                                "ChiSquare" = matrix(rchisq(size*r, df = as.numeric(input$df), ncp=as.numeric(input$ncp)), r),
                                "Uniform" = matrix(runif(size*r, min = as.numeric(input$min), max=as.numeric(input$max)), r),
                                "Gamma" = matrix(rgamma(size*r, shape = as.numeric(input$shape), scale=as.numeric(input$scale)), r),
                                "Student-t" = matrix(rt(size*r, df = as.numeric(input$df)), r),
                                "Binomial" = matrix(rbinom(size*r, size = as.numeric(input$trial), prob = as.numeric(input$prob)),r)
                                )
            
            rv$sample <- as.numeric(randomVec[1, ])
            rv$all.means <- as.numeric(apply(randomVec, 1, mean))
            
            
            par(mfrow=c(2,2), oma=c(0,0,5,0))
            
            hist(rv$sample, col="pink", main="Histogram of One Sample Distribution",xlab="Mean")
            hist(rv$all.means, main="Sampling Distribution of the Mean",
                 ylab="Frequency",xlab="Mean",col=3)
            plot(density(rv$sample), main="Density Plof of Sampling Distribution", ylab="Frequency",col=2)
            mtext("Simulation Results", outer=TRUE, cex=3)
            # Create a histogram
            hist(rv$sample, freq = FALSE, main = "Histogram and Density",xlab="Mean")
            
            # Calculate density
            dx <- density(rv$sample)
            
            # Add density
            lines(dx, lwd = 2, col = "red")
            
        }   , height=660, width=900)
    } 
    
)
