
function(input,output,session) {
  
  observe({
    updateSelectizeInput(
      session,'state',
      choices = unique(maybe[maybe$Year==input$year,'year']),
      selected = unique(maybe[maybe$Year==input$year,'year'][1])
    )
  })
  # filter the observations in data that match the chosen year
  # from the provided dropdown menu
  impact= reactive({
    maybe%>%
      filter(., Year == input$year) 
    
  })
  # plot of injuries
  output$injured=renderPlot(
    impact()%>%
      group_by(., X..Injured) %>%
      summarise(., frequency = n()) %>%
      top_n(input$vic, frequency) %>%
      ggplot(aes(x= X..Injured,y=frequency))+geom_point(col = "purple")+
      #ggtitle('Injuries') +
      xlab("Injuries per Incident") +
      ylab("Frequency") +
      theme_bw()
  )
  # plot of fatalities
  output$killed=renderPlot(
    impact()%>%
      group_by(., X..Killed) %>%
      summarise(., frequency = n()) %>%
      top_n(input$vic, frequency) %>%
      ggplot(aes(x= X..Killed,y=frequency))+geom_point(col = "red")+
      #ggtitle('Fatalities') +
      xlab("Fatalities per Incident") +
      ylab("Frequency") +
      theme_bw()
  )  
  # the data
  output$data=renderTable(
    impact()
  )
  # summary wrt incidents with four injuries
  output$summary = renderPrint(
    summary(impact() %>%
              filter(., X..Injured == 4) %>%
              select(., X..Killed))
  )
  #output$box = renderPlot({
  # boxplot(summary(impact() %>%
  #               filter(., X..Injured == 4) %>%
  #              select(., X..Killed)))
  #boxplot(x, col = "sky blue", border = "purple")
  #})
  
  #output$example <- renderUI({
  #  tags$a(imageOutput("handgun.png"),href="https://www.google.com")
  #})
  
}



