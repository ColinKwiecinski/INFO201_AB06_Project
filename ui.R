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
                     "1. This project is able to take in 2 values that are very crucial in the field of healthcare,
                    which are its cost and how effective the healthcare system which is show through life expectancy.
                    This project is also did a good job at looking at private spending versus government spending and included data set throughout the world,
                    not just the U.S. Its comprehensiveness is definitely one of the project's strength.
                     However, the project still have weaknesses,
                     the most important is that the dataset can only give us a correlation between spending and life expectancy rather
                     than finding a cause-and-effect relationship between these two values."
                 ),
                 p(
                     "2. From the trend of the data, we learned is that there is a direct positive correlation between spending, no what private or 
                     through the government, and life expectancy. Life expectancy is much higher is a country or individuals spend more for it. 
                     However, individuals spending seems to have lesser of an impact on increasing life expectancy than government spending, but the
                     differences between government and private spendings are minimal.
                     On the other hand, to a certain point the correlation between spendings to life expectancy plateau out around 80 years, for both government
                     spendings and individual spendings. As more spendings to a certain extent simply doesn't extend human life expectancy but can only
                     help to maximize individuals' health. Lastly, it's important to notice the different between countries with universal health care
                     and countries without, as countries without universal healthcare tends to do better. Universal healthcare might not be as effective due to 
                     its quality as lesser than private healthcare which is more extensive and appropriate for each individual"
                 ),
                 p(
                     "3. This project has a lot of potential for more future research in the field of healthcare and government spendings.
                     Future works can include deeper look into how healthcare spending is allocated or if there is other factor involved in 
                     correlation with life expectancy. This give an insight into whether healthcare spendings are effective or not."
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
