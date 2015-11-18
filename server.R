library(UsingR)
library(ggplot2)
data(mtcars)
myfit <- lm(mpg~cyl+hp+wt+am, mtcars)

firstPlot <- function(option){
  hist(mtcars[, as.numeric(option)], 
       xlab=colnames(mtcars)[as.numeric(option)], 
       col='lightblue', 
       main='Distribution')
}

secPlot <- function(option){
  myPlot <- if(option %in% c("4", "6")){
    qplot(mtcars[,as.numeric(option)],
          mtcars$mpg, 
          geom=c("point", "smooth"), 
          method="lm",
          xlab=colnames(mtcars)[as.numeric(option)],
          ylab="mpg")
  } else {
    qplot(factor(mtcars[,as.numeric(option)]), 
          mtcars$mpg, 
          geom="boxplot", 
          xlab=colnames(mtcars)[as.numeric(option)],
          ylab="mpg")
  }
  myPlot
}



shinyServer(
        function(input, output) {
                output$myPlot <- renderPlot({
                  firstPlot(input$id1)
                })
                
                output$myPlot2 <- renderPlot({
                  secPlot(input$id1)
                })
                
                
                myPrediction <- reactive({
                  tempData <- data.frame(cyl=c(as.numeric(input$cyl)), 
                                       hp=c(as.numeric(input$hp)), 
                                       wt=c(as.numeric(input$wt)), 
                                       am=c(as.numeric(input$am)))
                myPred <- predict(myfit, newdata=tempData, interval="predict")
                myPred})
                
                output$fit <- renderText({
                  paste("Predicted value of miles per gallon is", round(myPrediction()[1], 1))
                })
                
                output$interval <- renderText({
                  paste("The 95% confidence interval of the prediciton is from ", 
                        round(myPrediction()[2], 1), 
                        "to", 
                        round(myPrediction()[3], 1))
                })

                }
)
                
