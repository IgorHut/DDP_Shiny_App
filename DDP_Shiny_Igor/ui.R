library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)


iris_l <-  gather(iris, Dimension, Value, -Species) %>% separate(Dimension, c("Part", "Measure"))
iris_l$Part <- as.factor(iris_l$Part)
dataset <- iris_l



ui <- shinyUI(fluidPage(
  
  titlePanel("Visual Explorer for 'iris' Dataset"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      p("This app serves an educational purpose of demonstrating basic graphical exploratory 
        analysis of the famous", code('iris'), "dataset. The dataset is transformed into the 'long' tidy format
        and", code("ggplot2"), "plotting system is used for visualisation."),
      
      
      selectInput('x', 'X', names(dataset)),
      selectInput('y', 'Y', names(dataset), names(dataset)[[4]]),
      selectInput('color', 'Color', c('None', names(dataset)), selected = names(dataset)[[2]]),
      
      checkboxInput('points', 'Points', value = TRUE),
      checkboxInput('jitter', 'Jitter'),
      checkboxInput('box', 'Boxplot'),
      
      selectInput('facet_row', 'Facet Row', c(None = '.', names(dataset)),selected = names(dataset)[[3]] ),
      selectInput('facet_col', 'Facet Column', c(None = '.', names(dataset)))
      ),
    
    mainPanel(
      plotOutput('plot')
    )
    ))
)
