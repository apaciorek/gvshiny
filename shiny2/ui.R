
fluidPage(
  titlePanel(h1("The Mass of Mass Shootings"), 
             windowTitle = "mass shootings shiny"),
  sidebarLayout(
    #sidebarPanel(img(src='<handgun.png>',
    #width='50%')),
    sidebarPanel(
      # drop down menu to filter data by year
      selectizeInput('year','Year',
                     choices=unique(maybe$Year)
      ),
      # slider to adjust x-axis on both plots
      sliderInput(
        inputId = "vic",
        label = "Number of Victims",
        min = 0,
        max = 100,
        value = 5
      ),
      
      # link to gun violence archive (where data was sourced)
      helpText(   a("Gun Violence Archive",
                    href="https://www.gunviolencearchive.org/reports"))
      
    ),
    
    mainPanel(
      
      # first tab shows plots
      tabsetPanel(
        tabPanel("Overview",
                 fluidRow(
                   column(5, plotOutput("trend"))
                 )
        ),
        
        tabPanel("On Mass", 
                 fluidRow(
                   column(5,plotOutput('injured')),
                   column(7,plotOutput('killed'))
                 )
        ),
        # looking closer at incidents with four injuries
        tabPanel("More on Four", verbatimTextOutput("summary")#,
                 # plotOutput("box")
        ),
        # third tab shows gun type distribution and link to site 
        tabPanel("Weapon Type",
                 (img(src='handgun.png', 
                      width = "75%")),
                 helpText(   a("Statista Site",
                               href="https://www.statista.com/statistics/476409/mass-shootings-in-the-us-by-weapon-types-used/")),
                 
                 (img(src='handgunss.png', 
                                  width = "75%")),
                 helpText(   a("Everytown Site",
                               href="https://everytownresearch.org/massshootingsreports/mass-shootings-in-america-2009-2019/"))
                 
                 
              
                 
                 
                 
        ), 
        
        # fourth tab shows the data table
        tabPanel("Data", tableOutput('data'))
      )
      
      
      
    )
  )
)


