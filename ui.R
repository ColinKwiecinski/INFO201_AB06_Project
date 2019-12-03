library(shiny)
library(markdown)
library(shinythemes)
source("source/analysis.R")

navbarPage(
    theme = shinythemes::shinytheme("flatly"),
    title = "Project Life",
    
    tabPanel(
        "Home",
        h2("Content placeholder for homepage."),
        h4(
            "This section will provide an introduction to the project to help
                familiarize the user with the problem at hand and what prior knowledge
                may be required to understand the information."
        )
    ),
    
    tabPanel(
        "Plot",
        titlePanel("Data Visualizations"),
        
        # Using tabsetPanel to subdivide the plots tab into the main plot and the table
        tabsetPanel(
            type = "tabs",
            tabPanel("Plot",
                     strong(
                         p("This section shows the correlation between several independent
                           variables and the dependent variable of life expectancy. Each
                           plot is a scatterplot that has been fit to a loess curve to
                           highlight the trend in the data. The user can select between
                           five different independent variables, chose to plot a specific
                           country on the chart, chose whether or not to show the difference
                           between countries with Universal Healthcare laws, and can adjust
                           the confidence interval of the curve (the shaded region).
                           ")
                         ),
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
                                 label = "Choose to seperate based on if a country
                                 has Universal Healthcare laws",
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
                     strong(
                         p(
                             "This section is a table of all the data we are using, combined
                             into one large table. The user can chose to search for specific terms,
                             sort each column, and adjust the number of rows shown."
                         )
                     ),
                     dataTableOutput("table")),
            tabPanel("Bar Chart",
                     strong(
                         p(
                             "This visualization is so that the user can compare the relative 
                             healthcare spending of multiple countries. Using the sidebar, one 
                             can select any country in the dataset, and plot it on the bar chart.
                             By default, some prominent countries are selected to give a quick comparison. 
                             The user can also hover over each bar to see the exact amount spent, and the 
                             average lifespan for that country. Additonally, the user may click on the
                             labels in the legend to only show one type of spending. " 
                         )
                     ),
                     sidebarLayout(
                         sidebarPanel(
                             selectInput(
                                 inputId = "get_countries",
                                 label = "Select Countries",
                                 choices = big_table$Country,
                                 multiple = TRUE,
                                 selected = default_countries
                             )
                         ),
                         mainPanel(plotlyOutput("bar_plot"))
                     ))
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
                    which are its cost and how effective the healthcare system which is show through life expectancy.
                    This project is also did a good job at looking at private spending versus government spending and included data set throughout the world,
                    not just the U.S. Its comprehensiveness is definitely one of the project's strength.
                     However, the project still have weaknesses,
                     the most important is that the dataset can only give us a correlation between spending and life expectancy rather
                     than finding a cause-and-effect relationship between these two values."
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
