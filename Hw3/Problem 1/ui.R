
library(shiny)

# Load the data 
mortality_rate_data <- read.csv(file="https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv",head=TRUE,sep=",")
#for 2010 only
mortality_rate_data<-subset(mortality_rate_data, Year == 2010 )


#distinct causes mortality_rate_data
causeOfDeath <- unique(mortality_rate_data$ICD.Chapter)

#todo make causes in ascending order

shinyUI(fluidPage(
  verticalLayout(
    mainPanel( 
      selectInput("causeOfDeath", "Select cause and see state ranking:", choices=causeOfDeath, width="100%")
      , htmlOutput("mortGvis")
  )
  )
))
