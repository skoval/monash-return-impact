dashboardPage(
  dashboardHeader(title = "Return Impact"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Player",
               tabName = "final",
               icon = icon("map-marked-alt")),
      menuItem(text = "Comparison",
               tabName = "density",
               icon = icon("map-marked-alt")),
      menuItem(text = "Cluster",
               tabName = "cluster",
               icon = icon("chart-bar")),
      menuItem(text = "Reproducibility",
               tabName = "refer",
               icon = icon("book"))
    )
  ),
  dashboardBody(
    tags$head(tags$style(HTML('
        /* logo */
        .skin-blue .main-header .logo {
                              background-color:#961e1e;
                              }
        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #ffb8c3 ;
                              }
        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #3b0008 ;
                              }        
        /* main sidebar */
        .skin-blue .main-sidebar {
                              background-color:#3b0008 ;
                              }
        /* active selected tab in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: #808080  ;
                              }
        /* other links in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                              background-color:#5a5a5a ;
                              color: #000000;
                              }
        /* other links in the sidebarmenu when hovered */
         .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                              background-color:#737373   ;
                              }
        /* toggle button when hovered  */                    
         .skin-blue .main-header .navbar .sidebar-toggle:hover{
                              background-color: #5a5a5a   ;
                              }
                              '))),
    tabItems(
      tabItem("density",
              fluidRow(
                box(
                  title = "Distribution Player One",
                    status = "danger",
                    width = 4,
                    solidHeader = TRUE,  
                    plotOutput("distPlot1")),
                box(title = "Distribution Player Two",
                    status = "danger",
                    width = 4,
                    solidHeader = TRUE,  
                    plotOutput("distPlot2")),
                box(width = 4,
                    selectInput('servenum', 'Serve Number:', 
                                c(unique(as.character(positions$serve))),
                                selected = "1"),
                    selectInput("player",
                                "Player One:",
                                c(unique(as.character(positions$player))),
                                selected = "A. Zverev"),
                    selectInput("complay",
                                "Player Two:",
                                c(unique(as.character(positions$player))),
                                selected = "R. Federer"),
                    selectInput("surface",
                                "Surface Type:",
                                c(
                                  unique(as.character(positions$surface))),
                                selected = "Hard"),
                    selectInput("serve",
                                "Serve Type:",
                                c(
                                  unique(as.character(positions$Servetype))),
                                selected = "DeuceT")
                    )),
              
              fluidRow(
                box(title = "Density Player One",
                    status = "danger",
                    width = 4, solidHeader = TRUE,
                    plotOutput("densitplot1")),
                box(title = "Density Player Two",
                    status = "danger",
                    width = 4, solidHeader = TRUE,
                    plotOutput("densitplot2")))
              
      ),
      tabItem("final",
        fluidRow(
        box(
          title = "Hard Court",
          status = "danger",
          width = 8,
          solidHeader = TRUE,  
          plotOutput("densitplot3")),
        box(width = 4,
            selectInput("player",
                        "Player:",
                        c(unique(as.character(positions$player))),
                        selected = "R. Federer"),
            selectInput("serve",
                        "Serve Type:",
                        c(
                          unique(as.character(positions$Servetype))),
                        selected = "DeuceT"))),
            
        fluidRow(
          box(
            title = "Clay Court",
            status = "danger",
            width = 8,
            solidHeader = TRUE,  
            plotOutput("densitplot4"))
        ),
        fluidRow(box(
          title = "Grass Court",
          status = "danger",
          width = 8,
          solidHeader = TRUE,  
          plotOutput("densitplot5")))),
      
      tabItem("cluster",
              fluidRow( 
                box(width = 9,
                  title = "Cluster",
                             plotOutput("cluster", width = "900px", height = "750px")),
                box(width = 3,
                  selectInput("serve",
                                      "Serve Type:",
                                      c(
                                        unique(as.character(positions$Servetype))),
                                      selected = "DeuceT"),
                          selectInput("surface",
                                      "Surface Type:",
                                      c(
                                        unique(as.character(positions$surface))),
                                      selected = "Hard"),
                          selectInput('servenum', 'Serve Number:', 
                                      c(unique(as.character(positions$serve))),
                                      selected = "1"),
                          selectInput("players",
                                      "Player for Cluster:",
                                      c(unique(as.character(positions$player))),
                                      selected = c("N. Djokovic", "R. Federer", "D. Thiem", "A. Zverev", "D. Schwartzman", "R. Nadal", "D. Medvedev", "S. Tsitsipas", "A. Rublev", "M. Berrettini", "R. Bautista Agut", "P. Carreno Busta"),
                                      multiple = TRUE),
                          numericInput('clusters', 'Cluster count', 9, min = 3, max = 12)))
              
      ),
      tabItem("refer",
              fluidPage(
                htmlOutput("about")
              )
      )
    )
  )
)