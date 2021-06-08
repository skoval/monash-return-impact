
library(shiny)
shinyServer(function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  
  output$distPlot1 <- renderPlot({
    
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
    
   positions %>%
      filter(player == input$player,
             surface == input$surface,
             Servetype == input$serve,
             serve == input$servenum) %>%
      ggplot(aes(y = Y, x = X)) + 
      annotate("rect", xmin=-Inf, xmax=-5.4, ymin=-Inf, ymax=Inf, fill=courtcolor) +
      annotate("rect", xmin=-11.89, xmax=-5.4, ymin=-5.49, ymax=5.49, fill=courtinside) +
      geom_path(data = courtTrace, aes(x = x, y = y), color = 'black', size = 1) +
      geom_segment(aes(x= -5.4, xend= -5.4, y= -6.5, yend= 6.5), size = 2, color = 'lightgrey', 
                   lineend = 'round') +           
      geom_point(size = 3, aes(col = factor(input$servenum, lab = input$servenum)), alpha = 0.5) +
      scale_colour_manual("Serve Number", values = "orange") +
      theme_bw() +
      coord_flip() + 
      theme(legend.position = "top") +
      scale_x_continuous("Depth (meters from net)", n. = 8) +
      scale_y_continuous("Lateral position (meters from center)", n. = 8)     
    
  })
  
  
  output$distPlot2 <- renderPlot({
    
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
    
    positions %>%
      filter(player == input$complay,
             surface == input$surface,
             Servetype == input$serve,
             serve == input$servenum) %>%
      ggplot(aes(y = Y, x = X)) + 
      annotate("rect", xmin=-Inf, xmax=-5.4, ymin=-Inf, ymax=Inf, fill=courtcolor) +
      annotate("rect", xmin=-11.89, xmax=-5.4, ymin=-5.49, ymax=5.49, fill=courtinside) +
      geom_path(data = courtTrace, aes(x = x, y = y), color = 'black', size = 1) +
      geom_segment(aes(x= -5.4, xend= -5.4, y= -6.5, yend= 6.5), size = 2, color = 'lightgrey', 
                   lineend = 'round') +           
      geom_point(size = 3, aes(col = factor(input$servenum, lab = input$servenum)), alpha = 0.5) +
      scale_colour_manual("Serve Number", values =  "#f572b9") +
      theme_bw() +
      coord_flip() + 
      theme(legend.position = "top") +
      scale_x_continuous("Depth (meters from net)", n. = 8) +
      scale_y_continuous("Lateral position (meters from center)", n. = 8)     
    
  })
  
  
  
  output$densit1plot <- renderPlot({
    
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
    positions %>%
      filter(player == input$player,
             surface == input$surface,
             Servetype == input$serve,
             serve == input$servenum) %>%
      ggplot(aes(y = Y, x = X)) + 
      xlim(-10,10) +
      annotate("rect", xmin=-Inf, xmax=-5.4, ymin=-Inf, ymax=Inf, fill=courtcolor) +
      annotate("rect", xmin=-11.89, xmax=-5.4, ymin=-5.49, ymax=5.49, fill=courtinside) +
      geom_path(data = courtTrace, aes(x = x, y = y), color = 'black', size = 1) +
      geom_segment(aes(x= -5.4, xend= -5.4, y= -6.5, yend= 6.5), size = 2, color = 'lightgrey', 
                   lineend = 'round') +     
      stat_density_2d(geom = "polygon", 
                      aes(alpha = ..level.., group = input$serve, fill = input$serve), n = 100, bins = 10) +
      scale_fill_manual("Serve Type", values = "orange") +
      theme_bw() +
      coord_flip() + 
      theme(legend.position = "top") +
      scale_x_continuous("Depth (meters from net)", n. = 8) +
      scale_y_continuous("Lateral position (meters from center)", n. = 8) 
    
    
    
    
  })
  
  output$densit2plot <- renderPlot({
    
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
    positions %>%
      filter(player == input$complay,
             surface == input$surface,
             Servetype == input$serve,
             serve == input$servenum) %>%
      ggplot(aes(y = Y, x = X)) + 
      xlim(-10,10) +
      annotate("rect", xmin=-Inf, xmax=-5.4, ymin=-Inf, ymax=Inf, fill=courtcolor) +
      annotate("rect", xmin=-11.89, xmax=-5.4, ymin=-5.49, ymax=5.49, fill=courtinside) +
      geom_path(data = courtTrace, aes(x = x, y = y), color = 'black', size = 1) +
      geom_segment(aes(x= -5.4, xend= -5.4, y= -6.5, yend= 6.5), size = 2, color = 'lightgrey', 
                   lineend = 'round') +     
      stat_density_2d(geom = "polygon", 
                      aes(alpha = ..level.., group = input$serve, fill = input$serve ), n = 100, bins = 10) +
      scale_fill_manual("Serve Type", values = "#f572b9") +
      theme_bw() +
      coord_flip() + 
      theme(legend.position = "top") +
      scale_x_continuous("Depth (meters from net)", n. = 8) +
      scale_y_continuous("Lateral position (meters from center)", n. = 8) 
    
    
    
    
  })
  
  
  
  

  
  
  
  
  output$cluster <- renderPlot({
    
    posit <- positions %>% dplyr::filter(serve == input$servenum,
                                         player == input$players,
    Servetype == input$serve,
    surface == input$surface)
    c <-  mixmodCluster(posit[,c("X","Y")], input$clusters)
    plot(c)
  })
  
})







