
library(shiny)
source("source/analysis.R")

shinyUI(fluidPage(

    titlePanel("Project Life"),

    sidebarLayout(
        sidebarPanel(
            # Chart selector
            selectInput(
                inputId = "x_axis",
                label = "Independent Variable",
                choices = c("Private Share" = "avg_private_share", 
                            "Government Share" = "avg_gov_share",
                            "Individual Spending" = "avg_individual_spend",
                            "Government Spending" = "avg_gov_spending",
                            "Healthcare to GDP Ratio" = "avg_gov_spend_ratio"
                            )
            ),
            # Input to put a point for a specific country on the plot
            textInput(
                inputId = "country_point",
                label = "Country",
                placeholder = "United States"
            )
        ),

        # Outputs plots
        # TODO: Make it stylish
        mainPanel(
            plotOutput("dynamic_plot"),
            dataTableOutput("table")
        )
    )
))
