
# server.R

library(googleVis)
library(shiny)



# Load the data 
mortality_rate_data <- read.csv(file="https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv",head=TRUE,sep=",")
#for 2010 only
mortality_rate_data<-subset(mortality_rate_data, Year == 2010 )

# Define server logic required to plot various variables against mpg
shinyServer(
function(input, output) 
{
  
  
  loadData <- reactive({ 
    data <- subset(mortality_rate_data[mortality_rate_data$ICD.Chapter == input$causeOfDeath,], select=c("State", "Crude.Rate"))
    data <- data[order(-data$Crude.Rate),] #descending order
    data$State <- factor(data$State, levels=unique(as.character(data$State)) )
    return (data)
  })
  
  # googleVis 
  output$mortGvis <- renderGvis({gvisBarChart(loadData(), 
                                              xvar="State", 
                                              yvar=c("Crude.Rate"),
                                              options=list(width="100%", 
                                                           height="850", 
                                                           chartArea="{top:'10'}"))})
  
  
 
  
}
)