
library(shiny)
library(markdown)
source("source/analysis.R")

navbarPage("Project Life Navigation",
           tabPanel("Plot",
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
            dataTableOutput("table"),
    ),
    
    )), tabPanel("Background & Research Question", "Research Questions: Does government spending on healthcare per person in a country has a direct correlation with the life expectancy of that same country?
What are some patterns and relationships regarding life expectancy of different countries with the spending of those countries?  
"),
        tabPanel("Conclusion", ),
        tabPanel("About Us", )
)

