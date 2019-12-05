library(shiny)
library(markdown)
library(shinythemes)
source("source/analysis.R")

navbarPage(
    theme = shinythemes::shinytheme("flatly"),
    title = "Project Life",
    
    tabPanel(
        "Home",
        h2(
            "How does individual and government spending relate to life expectancy?"
        ),
        p(
            "The problem situation is investigating how individual and government spending relates to life expectancy.
            Some of the direct stakeholders in this situation are the general population, healthcare companies, and government
            agencies that determine funding for healthcare."
        ),
        p(
            " The background for this is the frequent policy discussions in US government on universal healthcare. Some of the ethics and tensions involved are that some groups would not want to pay increased taxes to fund universal healthcare, while other groups struggle to afford healthcare and believe it is a human right to have access to such resources. Some indirect stakeholders could be pharmaceutical companies or insurance companies that would lobby against
            universal healthcare, and also the people affected by overpriced healthcare."
        ),
        p(
            " Different countries around the world might see the
            data and adjust new laws in their country to help their life expectancy go in the direction they want. The non-targeted use of
            this data can be beneficial to countries around the world."
        ),
        hr(),
        h2(p("Our main research questions are:")),
        p(
            "Does government spending on healthcare per person
          in a country has a direct correlation with the life expectancy of that
          same country?"
        ),
        p(
            "What are some patterns and relationships regarding life
        expectancy of different countries with the spending of those countries?"
        ),
        hr(),
        h3("Important Links"),
        h4(
            p(tags$a(href = "https://github.com/ColinKwiecinski/INFO201_AB06_Project", "Github Repo")),
            
            p(tags$a(href = "https://github.com/ColinKwiecinski/INFO201_AB06_Project/wiki/Proposal", "Project Proposal")),
            
            p(tags$a(href = "https://github.com/ColinKwiecinski/INFO201_AB06_Project/wiki/Report", "Technical Report"))
        )
    ),
    
    tabPanel(
        "Visualizations",
        titlePanel("Data Visualizations"),
        
        # Using tabsetPanel to subdivide the plots tab into the main plot and the table
        tabsetPanel(
            type = "tabs",
            tabPanel("Plot",
                     strong(
                         p(
                             "This section shows the correlation between several independent
                           variables and the dependent variable of life expectancy. Each
                           plot is a scatterplot that has been fit to a loess curve to
                           highlight the trend in the data. The user can select between
                           five different independent variables, chose to plot a specific
                           country on the chart, chose whether or not to show the difference
                           between countries with Universal Healthcare laws, and can adjust
                           the confidence interval of the curve (the shaded region).
                           "
                         ) 
                         
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
                                 label = "Choose to separate based on if a country
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
            tabPanel(
                "Bar Chart",
                strong(
                    p(
                        "This visualization is so that the user can compare the relative
                             healthcare spending of multiple countries. Using the sidebar, one
                             can select any country in the dataset, and plot it on the bar chart.
                             By default, some prominent countries are selected to give a quick comparison.
                             The user can also hover over each bar to see the exact amount spent, and the
                             average lifespan for that country. Also, the user may click on the
                             labels in the legend to only show one type of spending. "
                    )
                ),
                sidebarLayout(sidebarPanel(
                    selectInput(
                        inputId = "get_countries",
                        label = "Select Countries",
                        choices = big_table$Country,
                        multiple = TRUE,
                        selected = default_countries
                    )
                ),
                mainPanel(plotlyOutput("bar_plot")))
            )
        )
    ),
    
    
    tabPanel("Conclusion",
             strong(
                 p(
                     "This project is able to take in 2 values that are very crucial in the field of healthcare -
                     its cost and how effective the healthcare system which is shown by life expectancy.
                    This project is also did a good job at examining private spending versus government spending and included data sets to represent most countries in the world,
                    not just the U.S. Its comprehensiveness is definitely one of the project's strength.
                     However, the project still has weaknesses,
                     the most significant is that the dataset can only give us a correlation between spending and life expectancy rather
                     than finding a cause-and-effect relationship between these two values. Thus, we must remember that correlation does not imply causation.
                     There could be external factors at play that are not being considering in this evaulation, for example in wealthier countries, people with more disposable income may opt to choose high standards of healthcare 
                     through private spending, and they may have better overall health habits, leading to a higher life expectancy that isn't tied to government spending."
                 ),
                 p(
                     "From the trend of the data, we learned is that there is a direct positive correlation between spending, no what private or 
                     through the government, and life expectancy. Life expectancy is much higher in a country when individuals spend more overall for it. 
                     However, individual spending seems to have lesser of an impact on increasing life expectancy than government spending, but the
                     differences between government and private spending are minimal.
                     On the other hand, to a certain point the correlation between spending and life expectancy plateau out around 80 years, for both government
                     spending and individual spending. More spending to a certain extent simply doesn't extend human life expectancy but can only
                     help to maximize individuals' health. Lastly, it's important to notice the difference between countries with universal health care
                     and countries without, as countries with universal healthcare tend to spend more on healthcare overall and have a longer lifespan.
                     This is seen by using the split function in the visualization, which shoes the countries without UHC as the red line, which tends to have
                     lower life expectancy in all categories. "
                 ),
                 p(
                     "This project has a lot of potential for more future research in the field of healthcare and government spending.
                     Future works can include a deeper look into how healthcare spending is allocated or what some of the other factors affect
                     life expectancy. This can help develop insights into when healthcare spending is effective or not."
                 )
             )),
    
    
    tabPanel("About Us",
             h2("Group Members"),
             strong(
                 p("Khoi Khong (khoik@uw.edu)"),
                 p("Colin Kwiecinski (colinkwi@uw.edu)"),
                 p("Shivaum Kumar (kumars7@uw.edu)")
             ))
)
