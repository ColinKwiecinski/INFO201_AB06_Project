

library(shiny)
source("source/analysis.R")

shinyServer(function(input, output) {

    output$dynamic_plot <- renderPlot({
        # Pulls input chart as correct variable type 
        x_axis <- get(input$x_axis)
        
        # Gathers correct labels for the plot
        filtered_labels <- labels %>%
            filter(x_var == input$x_axis)
        
        # Determines values for individual country selection
        country_point <- avg_life %>%
            filter(country == input$country_point) %>%
            inner_join(x_axis, by = "country", suffix = c(".y", ".x"))
        
        # Generates smoothed plot with 95% CI and loess method curve
        create_plot(avg_life, x_axis) +
            geom_smooth() +
            labs(
                title = filtered_labels$title,
                 x = filtered_labels$x_label,
                 y = filtered_labels$y_label) +
            geom_point(
                data = country_point,
                size = 4
            )
    })
    
    output$table <- renderDataTable(big_table,
                                options = list(
                                    lengthMenu = c(10, 25, 50, 100, 200),
                                    pageLength = 10))

})
