library(shiny)
library(markdown)
library(shinythemes)
source("source/analysis.R")

navbarPage(
    theme = shinythemes::shinytheme("flatly"),
    title = "Project Life",
    
    tabPanel("Home"),
    
    tabPanel(
        "Plot",
        titlePanel("Data Visualization"),
        
        # Using tabsetPanel to subdivide the plots tab into the main plot and the table
        tabsetPanel(
            type = "tabs",
            tabPanel("Plot",
                     # Sidebar viz controls
                     sidebarLayout(
                         sidebarPanel(
                             # Chart selector
                             selectInput(
                                 inputId = "x_axis",
                                 label = "Independent Variable",
                                 choices = c(
                                     "Private Share" = "avg_private_share",
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
                             ),
                             # Select if use double plot
                             radioButtons(
                                 inputId = "use_double_plot",
                                 label = "Show difference between UHC countries",
                                 choices = list("No split" = 0, "UHC Split" = 1),
                                 selected = 0
                             ),
                             # Confidence interval slider
                             sliderInput(
                                 inputId = "conf_int",
                                 label = "Confidence Interval",
                                 min = 0,
                                 max = 1,
                                 value = 0.95
                             )
                         ),
                         # Outputs the plot in the main section
                         mainPanel(plotOutput("dynamic_plot"))
                     )),
            # Subtab to output table
            tabPanel("Table",
                     dataTableOutput("table"))
        )
    ),
    
    tabPanel(
        "Background & Research Question",
        h2("Research Questions:"),
        strong(
            p(
                "Does government spending on healthcare per person
          in a country has a direct correlation with the life expectancy of that
          same country?"
            ),
            p(
                "What are some patterns and relationships regarding life
        expectancy of different countries with the spending of those countries?"
            )
        )
        
    ),
    
    
    tabPanel("Conclusion"),
    
    
    tabPanel("About Us")
)
