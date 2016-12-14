library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)


iris_l <-  gather(iris, Dimension, Value, -Species) %>% separate(Dimension, c("Part", "Measure"))
iris_l$Part <- as.factor(iris_l$Part)
dataset <- iris_l


server <- shinyServer(function(input, output) {
  
  dataset <- reactive({iris_l})
  
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x = input$x, y = input$y))
    
    
    if (input$points)
      p <- p + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color = input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$jitter)
      p <- p + geom_jitter()
    
    if (input$box)
      p <- p + geom_boxplot()
    
    print(p)
    
  }, height = 700)
  
})