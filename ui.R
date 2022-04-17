#Importing datasets

library(shiny)
library(shinythemes)
library(dplyr)
library(magrittr)
library(sf)
library(ggplot2)
library(reshape2)

barchart_data <- read.csv("barchart_data.csv")
counties <- read.csv("counties.csv")
piechart_total <- read.csv("piechart_total.csv")
crashes_total <- read.csv("crashes_total.csv")


title<-
  # Define UI
  ui <- fluidPage(theme = shinytheme("cerulean"),
                  navbarPage("Grand Rapids Crash",
                             tabPanel("Alcohol/Drug",
                                      sidebarPanel(
                                        selectInput("Type", "Select Type", choices = unique(barchart_data$Type))
                                        ), # sidebarPanel
                                      mainPanel(
                                       plotOutput("barplot"),
                                       p("This is the line chart from the year 2004 to 2019. We can filter either Crash or injuries and death due to alcohol and drugs. Then, it compares the total crash dues to alcohol and drugs per each year."),
                                       p("From the graph, we can visualize that the total number of crashes due alcohol is higher than that due to drugs."),
                                       p("However, the injuries and death rate per crash is higher due to drugs than in alcohol though the number is higher.")
                                     ) # mainPanel
                             ),
                             tabPanel("County", #countywise line chart of crash
                                      sidebarPanel(
                                        selectInput("county", "Select County", choices = unique(counties$County))
                                      ), # sidebarPanel
                                      mainPanel(
                                        tabsetPanel(
                                          tabPanel("Crashes",plotOutput("linechart1")),
                                          tabPanel("Injuries and Death",plotOutput("linechart2"))
                                        ),
                                        p("There are two tabs for the visualization for each counties: 1. Crashes 2. Injuries and death. The counties can be filtered from the sidebar panel."),
                                        p("From the visualizations above, it is proven that the all the counties have higher number of crashes. However, number of injured and died people is higher in all of the counties."),
                                        
                                        
                                      ) # mainPanel
                             ), #end - countywise line chart of crash
                             
                             tabPanel("Total Crashes - Year", #piechart
                                      sidebarPanel(
                                        selectInput("time", "Select a Year", choices = unique(piechart_total$year))
                                      ), # sidebarPanel
                                      mainPanel(
                                        plotOutput("piechart"),
                                        p("We found that Kent has almost one-third crashes among four counties in Grand Rapids Metropolitan Area in each year from 2004 to 2019."),
                                        p("Ottawa  is the second county having the higher number of crashes in that period of time. Besides that, Montcalm and Ionia has almost same range of crashes")
                                      ) # mainPanel
                             )
                  ) #nav bar 
  ) #ui 


