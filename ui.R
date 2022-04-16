#Importing datasets

library(shiny)
library(shinythemes)
library(ggplot2)
library(dplyr)
library(googlesheets4)
library(tidyverse)
library(plotly)
library(ggmap)
library(maps)
library(mapproj)
library(reshape2)
library(leaflet)
library(sf)
library(tigris)

barchart_data <- read.csv("barchart_data.csv")

counties <- read.csv("counties.csv")

piechart_total <- read.csv("piechart_total.csv")

crashes_total <- read.csv("crashes_total.csv")

title<-
  # Define UI
  ui <- fluidPage(theme = shinytheme("cerulean"),
                  navbarPage("Grand Rapids Crash",
                             #theme = "cerulean",  # <--- To use a theme,
                             tabPanel("Total Crash Comparison",
                                      sidebarPanel(
                                        selectInput("Type", "Select Type", choices = unique(barchart_data$Type))
                                      ), # sidebarPanel
                                      mainPanel(
                                        plotOutput("barplot"),
                                      ) # mainPanel
                             ),
                             tabPanel("Crashes - County", #countywise line chart of crash
                                      sidebarPanel(
                                        selectInput("county", "Select County", choices = unique(counties$County))
                                      ), # sidebarPanel
                                      mainPanel(
                                        plotOutput("linechart1"),
                                      ) # mainPanel
                             ), #end - countywise line chart of crash
                             
                             tabPanel("Injuries and death - County", #countywise line chart of injury and death
                                      sidebarPanel(
                                        selectInput("county_injury", "Select One County", choices = unique(counties$County))
                                      ), # sidebarPanel
                                      mainPanel(
                                        plotOutput("linechart2"),
                                      ) # mainPanel
                             ), #end - countywise line chart of injury and death
                             
                             tabPanel("Piechart1", #piechart
                                      sidebarPanel(
                                        selectInput("Year", "Select a Year", choices = unique(piechart_total$year))
                                      ), # sidebarPanel
                                      mainPanel(
                                        plotOutput("piechart1"),
                                      ) # mainPanel
                             ), #end - countywise line chart of injury and death
                             
                             tabPanel("Total Crashes", #piechart
                                      sidebarPanel(
                                        selectInput("time", "Select a Year", choices = unique(piechart_total$year))
                                      ), # sidebarPanel
                                      mainPanel(
                                        plotOutput("piechart"),
                                      ) # mainPanel
                             )
                             
                  ) #nav bar 
  ) #ui 


