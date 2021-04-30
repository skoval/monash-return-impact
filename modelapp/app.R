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
            selectInput("player",
                        "Player:",
                        c(
                            unique(as.character(positions$player))),
                        selected = "K. Khachanov"))  
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )


# Define server logic required to draw a histogram
server <- function(input, output) {

        output$distPlot <- renderPlot({
            
    
 mixmodCluster( positions %>% filter(player == input$player)[,c("X","Y")], 5) %>%
                plot()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
