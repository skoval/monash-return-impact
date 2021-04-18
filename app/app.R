library(ggplot2)
library(tidyverse)
library(shiny)
library(dplyr)
library(plotly)

positions <- readRDS("data/position.rds")

pivit <- position %>% pivot_longer(AdT:DeuceWide,
                                   names_to = "Servetype", 
                                   values_to = "values") %>%
  filter(values == 1)  %>% 
  dplyr::select(-values)

# Define dimensions of tennis court on negative X (receiver) side only
courtTrace <- data.frame(x = c(-11.89, -11.89, -5.4, -5.4, -11.89, -11.89, -5.4, -5.4, -11.89, -6.4, -6.4, -5.4, -5.4, -5.4, -6.4),
                         y = c(5.49, -5.49, -5.49, 5.49, 5.49, 4.115, 4.115, -4.115, -4.115, -4.115, 4.115, 4.115, -4.115, 0, 0))


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Return Impact Position"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
    selectInput("player",
                "Player:",
                c(
                  unique(as.character(pivit$player))),
                selected = "K. Khachanov"),
    selectInput("serve",
                "Serve Type:",
                c(
                  unique(as.character(pivit$Servetype))),
                selected = "DeuceWide"),
    selectInput("surface",
                "Surface Type:",
                c(
                  unique(as.character(pivit$surface))),
                selected = "Hard")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      
      plotOutput("densityplot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    courtcolor <- '#0a8d45'
    if(input$surface == 'Clay'){
      courtcolor <- '#d16036'
    }
    else if(input$surface == 'Grass'){
      courtcolor <- '#00a30e'
    }
    else {
      courtcolor <- '#68b0f2'
    }
    
    courtinside <- '#0a8d45'
    if(input$surface == 'Clay'){
      courtinside <- '#a3350a'
    }
    else if(input$surface == 'Grass'){
      courtinside <- '#057517'
    }
    else {
      courtinside <- '#1263b0'
    }
    

    pivit %>%
      filter(player == input$player,
             surface == input$surface,
             Servetype == input$serve) %>%
      ggplot(aes(y = Y, x = X)) + 
      annotate("rect", xmin=-Inf, xmax=-5.4, ymin=-Inf, ymax=Inf, fill=courtcolor) +
      annotate("rect", xmin=-11.89, xmax=-5.4, ymin=-5.49, ymax=5.49, fill=courtinside) +
      geom_path(data = courtTrace, aes(x = x, y = y), color = 'black', size = 1) +
      geom_segment(aes(x= -5.4, xend= -5.4, y= -6.5, yend= 6.5), size = 2, color = 'lightgrey', 
                   lineend = 'round') +           
      geom_point(size = 3, aes(col = factor(serve, lab = c("FIRST", "SECOND"))), alpha = 0.5) +
      scale_colour_manual("Serve", values = c("orange", "#f572b9")) +
      theme_bw() +
      coord_flip() + 
      theme(legend.position = "top") +
      scale_x_continuous("Depth (meters from net)", n. = 8) +
      scale_y_continuous("Lateral position (meters from center)", n. = 8)    
    
  })
  
  output$densityplot <- renderPlot({
    
    courtcolor <- '#0a8d45'
    if(input$surface == 'Clay'){
      courtcolor <- '#d16036'
    }
    else if(input$surface == 'Grass'){
      courtcolor <- '#00a30e'
    }
    else {
      courtcolor <- '#68b0f2'
    }
    
    courtinside <- '#0a8d45'
    if(input$surface == 'Clay'){
      courtinside <- '#a3350a'
    }
    else if(input$surface == 'Grass'){
      courtinside <- '#057517'
    }
    else {
      courtinside <- '#1263b0'
    }
    pivit %>%
      filter(player == input$player,
             surface == input$surface,
             Servetype == input$serve) %>%
      ggplot(aes(y = Y, x = X)) + 
      xlim(-10,10) +
      annotate("rect", xmin=-Inf, xmax=-5.4, ymin=-Inf, ymax=Inf, fill=courtcolor) +
      annotate("rect", xmin=-11.89, xmax=-5.4, ymin=-5.49, ymax=5.49, fill=courtinside) +
      geom_path(data = courtTrace, aes(x = x, y = y), color = 'black', size = 1) +
      geom_segment(aes(x= -5.4, xend= -5.4, y= -6.5, yend= 6.5), size = 2, color = 'lightgrey', 
                   lineend = 'round') +     
      stat_density_2d(geom = "polygon", 
                      aes(alpha = ..level.., group = Ad, fill = ifelse(Ad == 0, "DEUCE COURT", "AD COURT")), n = 100, bins = 10) +
      scale_fill_manual("Serve", values = c("orange", "#f572b9")) +
      theme_bw() +
      coord_flip() + 
      theme(legend.position = "top") +
      scale_x_continuous("Depth (meters from net)", n. = 8) +
      scale_y_continuous("Lateral position (meters from center)", n. = 8) 
    
    
    
    
  }
    
    
    
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)












