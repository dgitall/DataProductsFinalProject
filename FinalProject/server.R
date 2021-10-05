#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(thematic)


shinyServer(function(input, output) {
    
    # Create reactive function to grab the dataset to display or plot
    datasetInput <- reactive({
        # Clean up the data to ensure the data types make sense
        data <- mpg
        data$manufacturer <- as.factor(data$manufacturer)
        data$model <- as.factor(data$model)
        data$displ <- as.numeric(data$displ)
        data$year <- as.factor(data$year)
        data$cyl <- as.factor(data$cyl)
        data$trans <- as.factor(data$trans)
        data$drv <- as.factor(data$drv)
        data$cty <- as.numeric(data$cty)
        data$hwy <- as.numeric(data$hwy)
        data$fl <- as.factor(data$fl)
        data$class <- as.factor(data$class)
        
        # Filter data based on selections        
        if (input$man != "All") {
            data <- data[data$manufacturer == input$man,]
        }
        if (input$cyl != "All") {
            data <- data[data$cyl == input$cyl,]
        }
        if (input$trans != "All") {
            data <- data[data$trans == input$trans,]
        }
        # Change names to human readable form
        names(data) <- c("Manufacturer",
                         "Model",
                         "Displacement",
                         "Year",
                         "Cylinders",
                         "Transmission",
                         "DriveTrain",
                         "MPG(city)",
                         "MPG(highway)",
                         "FuelType",
                         "VehicleClass")
        data
    })
    
    # Grab the updated selection for the y-axis
    predictorInput <- reactive({
        input$predictor
    })
    
    # Grab the updated selection for the x-axis
    mpgInput <- reactive({
        input$mpgType
    })
     
    # Plot out the data table using the DT table
    output$table <- DT::renderDataTable(
        DT::datatable({datasetInput()},
                      # Change the list of options for number of rows to display. 
                      # Set the default to the smallest to allow the table to fit on the
                      # page without scrolling.
                      # use 'dom' to display everything but the search box
                      # Set the selection mode to allow only single selections
                      options = list(lengthMenu = list(c(5, 10, 25, 50, -1), 
                                                       c('5', '10', '25', '50', 'All')),
                                     pageLength = 5,
                                     dom = 'ltpr'),
                      selection = 'single'
                      )
        )  

    # Call thematic before rendering the plot to pass the page theme into the
    # ggplot. If you don't it will plot using the default ggplot theme
    thematic::thematic_shiny()
    output$carsPlot <- renderPlot({
        # Call functions to get the most current table
        # data and the radio button selections
        dataset <- datasetInput()
        predictorName <- predictorInput()
        mpgName <- mpgInput()
        # massage the data to get into the form ggplot needs
        data <- data.frame(x=dataset[,predictorName],
                             y=dataset[,mpgName])
        names(data) <- c("x","y")
        # Use qplot to allow it to pick the appropriate graph
        if(is.factor(data$x)) {
            plot <- qplot(data=data,x=x, y=y, geom = "boxplot",
                          xlab=predictorName,
                          ylab=mpgName)
        } else {
            plot <- qplot(data=data,x=x, y=y,
                          xlab=predictorName,
                          ylab=mpgName)
            
        }
        # Change some of the text formatting to make them easier to read
        plot <- plot + theme(axis.text.x = element_text(angle=90, size=rel(1.2)),
                             axis.text.y = element_text(size=rel(1.2)),
                             axis.title = element_text(size=rel(1.1), face="bold"))
        # If a row in the data table is selected, plot a large point there
        if (!is.null(input$table_rows_selected)) {
            plot <- plot + geom_point(aes(x=x[input$table_rows_selected],
                                      y=y[input$table_rows_selected],
                                      size=4), show.legend = FALSE
                                      )
        }
        plot
    }
    )

})
