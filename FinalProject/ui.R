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


shinyUI(fluidPage( 
    # Set the page theme using a default theme and changing the color
    theme = bs_theme(bootswatch = "flatly",
                     bg = "#faf9eb", 
                     fg = "#523c1d"
                     ),
    
    # Application title
    titlePanel("Exploring Auto Fuel Efficiency"),
    # Create the left sidebar
    sidebarLayout( 
        sidebarPanel( 
            h2("Filters"),
            # Add in dropdown selectors to filter on individual
            # manufacturer, transmission type, and number of cylinders
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
                )),
            p("The 'mpg' data set in the ggplot2 R package contains fuel economy 
              data for 38 popular models of cars from 1999 to 2008."),
            p("Filters: Select a subset of the data set using the
              dropdown controls."),
            p("Plot: Graph the highway or city fuel efficiency against a user selected
              parameter."),
            p("Data: Display the filtered data set. A selected row is highlight in the plot."),
            p("Controls: Select the x and y axis parameters to display in the plot."),
            a(href="https://ggplot2.tidyverse.org/reference/mpg.html", "(For more information about the 'mpg' data set)")
        ),
        
        # Create the layout for the main panel
        mainPanel(
            # Setup a plot at the top
            plotOutput("carsPlot"),
            # with two tabs underneath
            tabsetPanel(
                # The first tab displays the filtered data in a table
                tabPanel("Data",
                         DT::dataTableOutput("table")),
                # The second tab allows the user to select the x- and y-axis
                # parameters
                tabPanel("Controls",
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
