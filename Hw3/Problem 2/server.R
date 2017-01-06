
library(shiny)
library(googleVis)
library(dplyr)

# load data
mortality_rate_data <- read.csv(file="https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv",head=TRUE,sep=",")


shinyServer(function(input, output)
{
  
    data <- function(data)
    {
      c(SumOfStates = with(data, weighted.mean(Crude.Rate, Population)))
    }
  
    outputPlot <- function()
    {
         in_cause <- input$cause
         in_state <- input$state
         statesums <- ddply(mortality_rate_data, .variables = c("ICD.Chapter", "Year"), .fun = data)
         mortality_rate_data <- merge(mortality_rate_data, statesums, by=c("ICD.Chapter", "Year"))
          selected <- mortality_rate_data %>%
          filter(ICD.Chapter == in_cause, State == in_state) %>%
          select(Year, Crude.Rate, SumOfStates)
          colnames(selected) <- c("Year", in_state, "National")
        
          gvisLineChart(selected, options=list(
            hAxis="{title:'Year'}",
            vAxis="{title:'Rate'}",
            height=600, width=900)
          )
    }
  
  output$view <- renderGvis(outputPlot())
}
)