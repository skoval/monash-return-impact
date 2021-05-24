library(ggplot2)
library(tidyverse)
library(shiny)
library(dplyr)
library(plotly)
library(Rmixmod)

positions <- readRDS("data/position.rds")



# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Cluster"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput('serve', 'Serve Number:', 
                        c(unique(as.character(positions$serve))),
                        selected = "1"),
            selectInput("player",
                        "Player:",
                        c(unique(as.character(positions$player))),
                        selected = c("N. Djokovic", "R. Federer", "D. Thiem", "A. Zverev", "D. Schwartzman", "R. Nadal", "D. Medvedev", "S. Tsitsipas", "A. Rublev", "M. Berrettini", "R. Bautista Agut", "P. Carreno Busta")),
            numericInput('clusters', 'Cluster count', 9, min = 3, max = 12))  
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("Plot")
        )
    )


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    selectdata <- positions %>% filter(serve == input$serve,
                                       player == input$player)
        output$Plot <- renderPlot({
       
   clusterplot <- mixmodCluster(selectdata[,c("X","Y")], input$clusters)
   plot(clusterplot)         
    
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
