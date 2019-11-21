library(shiny)
library(markdown)
library(shinythemes)
source("source/analysis.R")

navbarPage(
    theme = shinythemes::shinytheme("flatly"),
    title = "Project Life",
    
    tabPanel("Home",
             h2("Content placeholder for homepage."),
             h4("This section will provide an introduction to the project to help
                familiarize the user with the problem at hand and what prior knowledge
                may be required to understand the information.")),
    
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
    
    
    tabPanel("Conclusion",
             strong(
                 p(
                     "1. This project is able to take in 2 values that are very crucial in the field of healthcare,
            which are its cost and how effective the healthcare system which is show through life expectancy. This project is also did a good job at looking at private spending versus government spending and included data set throughout the world,
            not just the U.S. Its comprehensiveness is definitely one of the project's strength. However, the project still have weaknesses, the most important is that the dataset can only give us a correlation between spending and life expectancy rather than finding a cause-and-effect relationship between these two values."
                 ),
                 p(
                     "2. So far the main lesson we learned is that there is a direct posstive correlation between spending, no what private or through the government, and life expectancy. Life expectancy is much higher is a country or individuals spend more for it. However, individuals spending seems to have lesser of an impact on increasing life expectancy than government spending."
                 ),
                 p(
                     "3. This project has a lot of potential for more future research in the field of healthcare and government spendings. Future works can include deeper look into how healthcare spending is allocated or if there is other factor involved in correlation with life expectancy."
                 )
             )),
    
    
    tabPanel(
        "About Us",
        h2("Group Members"),
        p(
            "Khoi Khong (khoik@uw.edu), Colin Kwiecinksi (colinkwi@uw.edu), Shivaum Kumar (kumars7@uw.edu)"
        )
    )
)
