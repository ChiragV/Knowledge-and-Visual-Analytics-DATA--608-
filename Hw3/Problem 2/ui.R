
library(shiny)
library(ggplot2)
library(googleVis)



mortality_rate_data <- read.csv(file="https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv",head=TRUE,sep=",")

cause  <- lapply(unique(mortality_rate_data$ICD.Chapter), as.character)
states <- lapply(unique(mortality_rate_data$State), as.character)

shinyUI
(
  fluidPage(
    titlePanel("Mortality Rates : State V/s National Avg"),
    sidebarPanel(selectInput("state", "Select state: ", choices=states),
                 selectInput("cause", "Select cause: ", 
                             choices=cause)),
    mainPanel(htmlOutput('view'))
  )
)