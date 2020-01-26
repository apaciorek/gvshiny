
fluidPage(
  titlePanel(h1("Mass Shootings")),
  sidebarLayout(
    #sidebarPanel(img(src='<handgun.png>',
                     #width='50%')),
    sidebarPanel(
      
      selectizeInput('year','Year',
                     choices=unique(maybe$Year)
      ),
      sliderInput(
        inputId = "vic",
        label = "Number of Victims",
        min = 0,
        max = 100,
        value = 5
      ),
      #selectizeInput('state','State',
       #              choices=unique(maybe$State))
      
    ),
    
    mainPanel(
      # tags$iframe(src="https://www.youtube.com/embed/ZseWsFtwAAQ" ,
      # width="785",height="442")
      
      tabsetPanel(
        tabPanel("Plots", 
                 fluidRow(
                   column(5,plotOutput('count')),
                   column(7,plotOutput('delay'))
                 )
        ),
        tabPanel("More", (img(src='handgun.png', 
                              width = "75%"))
        ), 
        tabPanel("Data", tableOutput('data'))
      )
      
      
      
    )
  )
)


