#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)
library(DT)
library(ggplot2)


# Define UI for application that draws a histogram
shinyUI(fluidPage( 
    theme = bs_theme(bootswatch = "flatly",
                     bg = "#faf9eb", 
                     fg = "#523c1d"
                     ),
    
    # Application title
    titlePanel("Exploring Auto Fuel Efficiency"),
    sidebarLayout( 
        sidebarPanel( 
            h2("Filters"),
            # Create a new Row in the UI for selectInputs            
            fluidRow(column(8, 
                            selectInput("man", 
                                        "Manufacturer:", 
                                        c("All", 
                                          unique(as.character(mpg$manufacturer)
                                                 )
                                          )
                                        ) 
                            )
                     ),
            fluidRow(    
                column(8,
                       selectInput("trans",
                                   "Transmission:",
                                   c("All",
                                     unique(as.character(mpg$trans))))
                )),
            fluidRow(
                column(8,
                       selectInput("cyl",
                                   "Cylinders:",
                                   c("All",
                                     unique(as.character(mpg$cyl))))
                )) 
        ),
        
        mainPanel(
            plotOutput("carsPlot"),
            tabsetPanel(
                tabPanel("Data",
                         DT::dataTableOutput("table")),
                tabPanel("Options",
                         fluidRow(
                             radioButtons("predictor",
                                          label = h4("Select X-axis parameter "),
                                          choices = list("Manufacturer",
                                                           "Model",
                                                           "Displacement",
                                                           "Year",
                                                           "Cylinders",
                                                           "Transmission",
                                                           "DriveTrain",
                                                           "FuelType",
                                                           "VehicleClass"
                                                         ),
                                          selected = "Displacement"
                                                        ),
                            radioButtons("mpgType",
                                         label = h4("Select Y-axis paramter "),
                                         choices = list("MPG(city)",
                                                        "MPG(highway)"
                                                        ),
                                         selected = "MPG(highway)"
                                         )
                                )  
                )
                )          
            )
    )
))
