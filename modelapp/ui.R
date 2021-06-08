
dashboardPage(
  dashboardHeader(title = "Return Impact"),
  dashboardSidebar(
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
    selectInput("player",
                "Player One for Distribution:",
                c(unique(as.character(positions$player))),
                selected = "A. Zverev"),
    selectInput("complay",
                "Player Two for Distribution:",
                c(unique(as.character(positions$player))),
                selected = "R. Federer"),
    numericInput('clusters', 'Cluster count', 9, min = 3, max = 12),
    sidebarMenu(
      menuItem(text = "Overview",
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
                box(title = "Distribution One",
                           status = "danger",
                           width = 6, 
                           solidHeader = TRUE,  
                           plotOutput("distPlot1")),
                box(title = "Distribution Two",
                    status = "danger",
                    width = 6, 
                    solidHeader = TRUE,  
                    plotOutput("distPlot2"))
                ),
              fluidRow(
                box(title = "Density One",
                           status = "danger",
                           width = 6, solidHeader = TRUE,
                           plotOutput("densit1plot")),
                box(title = "Density Two",
                    status = "danger",
                    width = 6, solidHeader = TRUE,
                    plotOutput("densit2plot")))
                       
              )
              
      ,
      tabItem("cluster",
            fluidRow(
                title = "Cluster",
                plotOutput("cluster", width = "900px", height = "750px")

              )
              
      ),
      tabItem("refer",
              fluidPage(
                htmlOutput("about")
              )
      )
    )
  )
)

