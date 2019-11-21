library(shiny)
source("source/analysis.R")

shinyServer(function(input, output) {
    
    output$dynamic_plot <- renderPlot({
        # Pulls input chart as correct variable type 
        x_axis <- get(input$x_axis)
        
        # Gathers correct labels for the plot
        filtered_labels <- labels %>%
            filter(x_var == input$x_axis)
        
        # Boolean to split plot
        split_plot <- input$use_double_plot
        
        # Confidence interval
        ci <- input$conf_int
        
        country_name <- input$country_point
        
        # Generates smoothed plots with 95% CI and loess method curve
        if(split_plot == 0) {
            single_plot(x_axis, ci, filtered_labels, country_name)
        } else {
            double_plot(x_axis, ci, filtered_labels, country_name)
        }
    })
    
    output$table <- renderDataTable(big_table,
                                    options = list(
                                        lengthMenu = c(10, 25, 50, 100, 200),
                                        pageLength = 10))
    
})

