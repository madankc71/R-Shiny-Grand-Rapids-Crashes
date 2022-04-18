barchart_data <- read.csv("barchart_data.csv")
View(barchart_data)
counties <- read.csv("counties.csv")
piechart_total <- read.csv("piechart_total.csv")
crashes_total <- read.csv("crashes_total.csv")

server <- function(input, output) {
  #bar chart of the total crashes due to alcohol and drugs from 2004 to 2019.
  output$barplot <- renderPlot({ #Not in use now
    library(reshape2)
    barchart_data <- barchart_data %>% filter(Type==input$Type)
    barchart_data <- melt(barchart_data[,c('year','Alcohol_total','Drug_total')], id.vars = 1)
    View(barchart_data)
    barr <- data.frame( Year = barchart_data$year,
                        
                        Frequency = c(barchart_data$Alcohol_total, barchart_data$Drug_total),
                        Type = c(rep("Alcohol Crash", nrow(barchart_data)),
                                 rep("Drug Crash", nrow(barchart_data)))
    )
    
    g <- ggplot(barchart_data, aes(x = Year, y = Frequency, col = Type)) +
      geom_bar()
    g
  })
  
  output$barr <- renderPlot({
    barchart_data <- barchart_data %>% filter(Type==input$Type)
    barchart1 <- data.frame(Year = barchart_data$year,
                            Number1 = c(barchart_data$Alcohol_total, barchart_data$Drug_total),
                            Type = c(rep("Alcohol", nrow(barchart_data)),
                                     rep("Drug", nrow(barchart_data))))
 
  ggplot(barchart1, aes( y = Number1, x = Year, fill=Type))+geom_bar(stat='identity')
  ggplot(barchart1, aes(fill=Type, y=Number1, x=Year)) + 
    geom_bar(position="dodge", stat="identity") +
    xlab("Year") + ylab("Frequency")
  })
  
  #line chart of crash
  output$linechart1 <- renderPlot({
    cc <- counties
    counties <- counties %>% filter(County==input$county)
    county_crash <- data.frame(Year = counties$year,                            # Reshape data frame
                               Number = c(counties$Alcohol_crash, counties$Drug_crash),
                               Type = c(rep("Alcohol Crash", nrow(counties)),
                                        rep("Drug Crash", nrow(counties))))
    
    ggp <- ggplot(county_crash, aes(Year, Number , col = Type)) +             # Create ggplot2 plot
      geom_line()
    ggp 
  }) # end - line chart of crash
  
  #Linechart of injuries and death
  output$linechart2 <- renderPlot({
    cc2 <- counties
    counties <- counties %>% filter(County==input$county)
    injury_county <- data.frame(Years = counties$year,                            # Reshape data frame
                                Numbers = c(counties$Alcohol_injury, counties$Drug_injury),
                                Types = c(rep("Alcohol Injuries and Death", nrow(counties)),
                                          rep("Drug Injuries and Death", nrow(counties))))
    
    ggp <- ggplot(injury_county, aes(Years, Numbers , col = Types)) +             # Create ggplot2 plot
      geom_line()
    ggp 
  }) # end of Linechart of injuries and death
  
  
  output$piechart <- renderPlot({
    crashes_total <- crashes_total %>% filter(year==input$time)
    df_crash <- data.frame(Types = c("Ionia", "Kent", "Montcalm","Ottawa"),
                           value=c(crashes_total$Ionia_total_crash, crashes_total$Kent_total_crash, crashes_total$Montcalm_total_crash, crashes_total$Ottawa_total_crash)
    )
    ggp <-  ggplot(df_crash, aes(x="", y=value, fill=Types)) +
      geom_bar(stat="identity", width=1) +
      coord_polar("y", start=0) +
      theme_void()
    ggp
  })
}

# Run the application 
#shinyApp(ui = ui, server = server)
