server <- function(input, output) {
  barchart_data <- read.csv("barchart_data.csv")
  
  counties <- read.csv("counties.csv")
  
  piechart_total <- read.csv("piechart_total.csv")
  
  crashes_total <- read.csv("crashes_total.csv")
  
  
  output$barplot <- renderPlot({
    library(reshape2)
    barchart_data <- barchart_data %>% filter(Type==input$Type)
    barchart_data <- melt(barchart_data[,c('year','Alcohol_total','Drug_total')], id.vars = 1)
    g <- ggplot(barchart_data, aes(x = year, y = value)) +
      geom_bar(aes(fill = variable),stat = "identity",position = "dodge")
    g
  })
  
  output$barr <- renderPlot({
    barchart_data <- barchart_data %>% filter(Type==input$type)
    barchart1 <- data.frame(Year = barchart_data$year,
                            Number1 = c(barchart_data$Alcohol_total, barchart_data$Drug_total),
                            Type = c(rep("Alcohol Total", nrow(barchart_data)),
                                     rep("Drug Total", nrow(barchart_data))))
    g <- ggplot(barchart1, aes(Year, Number1, col = Type)) +
      geom_bar()
    g
  })
  
  #line chart of crash
  output$linechart1 <- renderPlot({
    cc <- counties
    cc <- cc %>% filter(County==input$county)
    county_crash <- data.frame(Year = cc$year,                            # Reshape data frame
                               Number = c(cc$Alcohol_crash, cc$Drug_crash),
                               Type = c(rep("Alcohol Crash", nrow(cc)),
                                        rep("Drug Crash", nrow(cc))))
    
    ggp <- ggplot(county_crash, aes(Year, Number , col = Type)) +             # Create ggplot2 plot
      geom_line()
    ggp 
  }) # end - line chart of crash
  
  #Linechart of injuries and death
  output$linechart2 <- renderPlot({
    cc2 <- counties
    cc2 <- cc2 %>% filter(County==input$county_injury)
    injury_county <- data.frame(Years = cc2$year,                            # Reshape data frame
                                Numbers = c(cc2$Alcohol_injury, cc2$Drug_injury),
                                Types = c(rep("Alcohol Injuries and Death", nrow(cc2)),
                                          rep("Drug Injuries and Death", nrow(cc2))))
    
    ggp <- ggplot(injury_county, aes(Years, Numbers , col = Types)) +             # Create ggplot2 plot
      geom_line()
    ggp 
  }) # end of Linechart of injuries and death
  
  # Start -- piechart of total crashes per year
  output$piechart <- renderPlot({
    piechart_total <- piechart_total %>% filter(year==input$Year)
    df_crash <- data.frame(Types = c("alcohol", "drug", "others"),
                           value=c(piechart_total$total_alcohol_crashes, piechart_total$total_drug_crashes, piechart_total$Other_Crashes)
    )
    ggp <-  ggplot(df_crash, aes(x="", y=value, fill=Types)) +
      geom_bar(stat="identity", width=1) +
      coord_polar("y", start=0) +
      theme_void()
    ggp
  })
  
  output$piechart1 <- renderPlot({
    piechart_total <- piechart_total %>% filter(year==input$Year)
    df_crash <- data.frame(Types = c("alcohol", "drug", "others"),
                           value=c(piechart_total$total_alcohol_crashes, piechart_total$total_drug_crashes, piechart_total$Other_Crashes)
    )
    ggp <-  ggplot(df_crash, aes(x="", y=value, fill=Types)) +
      geom_bar(stat="identity", width=1) +
      coord_polar("y", start=0) +
      theme_void()
    ggp
  })
  
  
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
