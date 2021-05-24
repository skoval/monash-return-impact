library(ggplot2)
library(tidyverse)
library(shiny)
library(dplyr)
library(plotly)
library(Rmixmod)

position <- readRDS("data/position.rds") 
positions <- position %>% 
  pivot_longer(AdT:DeuceWide,
               names_to = "Servetype", 
               values_to = "values") %>%
  filter(values == 1)  %>% 
  dplyr::select(-values)


ui<- pageWithSidebar(
  headerPanel('Cluster Distribution'),
  sidebarPanel(
    selectInput('serve', 'Serve Number:', 
                c(unique(as.character(positions$serve))),
                selected = "1"),
    selectInput("player",
                "Player:",
                c(unique(as.character(positions$player))),
                selected = c("N. Djokovic", "R. Federer", "D. Thiem", "A. Zverev", "D. Schwartzman", "R. Nadal", "D. Medvedev", "S. Tsitsipas", "A. Rublev", "M. Berrettini", "R. Bautista Agut", "P. Carreno Busta"),
                multiple = TRUE),
    numericInput('clusters', 'Cluster count', 9, min = 3, max = 12),
    selectInput("servetype",
                "Serve Type:",
                c(
                  unique(as.character(positions$Servetype))),
                selected = "DeuceWide"),
    selectInput("surface",
                "Surface Type:",
                c(
                  unique(as.character(positions$surface))),
                selected = "Hard")
  ),
  mainPanel(
    plotOutput('plot1')
  )
)


server <- function(input, output, session) {
  
  # Combine the selected variables into a new data frame

  
  
  output$plot1 <- renderPlot({
    
    posit <- positions %>% dplyr::filter(serve == input$serve,
                                player == input$player,
                                Servetype == input$servetype,
                                surface == input$surface)
   c <-  mixmodCluster(posit[,c("X","Y")], input$clusters)
    plot(c)
  })
  
}


shinyApp(ui = ui, server = server)


