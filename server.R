
function(input,output,session) {
  
  observe({
   updateSelectizeInput(
      session,'state',
      choices = unique(maybe[maybe$Year==input$year,'year']),
      selected = unique(maybe[maybe$Year==input$year,'year'][1])
    )
  })
  
  impact= reactive({
    maybe%>%
      filter(., Year == input$year) 
    #%>%
      #group_by(., X..Injured) %>%
      #summarise(., count = n()) %>%
      #top_n(15, count)
      #filter(origin==input$dep,dest==input$arr)%>%
      #group_by(carrier)%>%
      #summarise(n=n(),arr=mean(arr_delay),dep=mean(dep_delay))
  })
  
  output$count=renderPlot(
    impact()%>%
      group_by(., X..Injured) %>%
      summarise(., frequency = n()) %>%
      top_n(input$vic, frequency) %>%
      ggplot(aes(x= X..Injured,y=frequency))+geom_point(col = "red")+
      #ggtitle('Injuries') +
      xlab("Number of Injured") +
      ylab("Frequency") +
      theme_bw()
  )
  
  output$delay=renderPlot(
    impact()%>%
      group_by(., X..Killed) %>%
      summarise(., frequency = n()) %>%
      top_n(input$vic, frequency) %>%
      ggplot(aes(x= X..Killed,y=frequency))+geom_point(col = "red")+
      #ggtitle('Fatalities') +
      xlab("Number of Fatalities") +
      ylab("Frequency") +
      theme_bw()
  )  
  
  output$data=renderTable(
    impact()
  )
  
}



