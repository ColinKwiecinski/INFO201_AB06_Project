#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("source/analysis.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Project Life"),

    # Sidebar with a slider input for number of bins
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

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("dynamic_plot"),
            dataTableOutput("table")
        )
    )
))
