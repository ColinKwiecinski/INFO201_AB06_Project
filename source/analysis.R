# INFO AB06 Group Project
# Analysis of healthcare spending in relation to life expectancy and health

library(lintr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(leaflet)
library(rsconnect)

# Load datasets
life_expectancy <-
  read.csv("data/life_expectancy_years.csv", stringsAsFactors = FALSE)
individual_spending_usd <-
  read.csv("data/total_health_spending_per_person_us.csv",
           stringsAsFactors = FALSE)
gov_spending_usd <-
  read.csv("data/government_health_spending_per_person_us.csv",
           stringsAsFactors = FALSE)
gov_spending_ratio <-
  read.csv(
    "data/government_health_spending_of_total_gov_spending_percent.csv",
    stringsAsFactors = FALSE
  )
gov_share <-
  read.csv("data/government_share.csv", stringsAsFactors = FALSE)
private_share <-
  read.csv("data/private_share.csv", stringsAsFactors = FALSE)


# Clean up the datasets
remove_x <- function(df) {
  names <- (gsub("X", "", colnames(df)))
  colnames(df) <- names
  return(df)
}

# Remove the X prefix from all the year columns
life_expectancy <- remove_x(life_expectancy)
individual_spending_usd <- remove_x(individual_spending_usd)
gov_spending_usd <- remove_x(gov_spending_usd)
gov_spending_ratio <- remove_x(gov_spending_ratio)
private_share <- remove_x(private_share)
gov_share <- remove_x(gov_share)

# Reduce to only years between 1995 to 2010 so that all tables match
fix_years <- function(df) {
  years <- c("country", seq(1995, 2010))
  result <- df %>%
    select(years)
  return(result)
}
# Reduce to only 1995:2010 year range
life_expectancy <- fix_years(life_expectancy)

# Averages each value for the 15 year span
# Source for how to use transmute:
# https://stackoverflow.com/questions/10945703/
get_avgs <- function(df) {
  result <- df %>%
    transmute(country, Mean = rowMeans(select(.,-country), na.rm = TRUE))
  return(result)
}

# Applies avg to all dataframes
avg_life <- get_avgs(life_expectancy)
avg_gov_spend_ratio <- get_avgs(gov_spending_ratio)
avg_gov_spending <- get_avgs(gov_spending_usd)
avg_private_share <- get_avgs(private_share)
avg_individual_spend <- get_avgs(individual_spending_usd)
avg_gov_share <- get_avgs(gov_share)

# Creates a plot from two avg df's that can be easily rendered by picking chart
# type.
create_plot <- function(df1, df2) {
  joined_df <- df1 %>%
    inner_join(df2, by = "country", suffix = c(".y", ".x"))
  result <- ggplot(data = joined_df, aes(x = Mean.x, y = Mean.y))
  return(result)
}

get_big_table <- function(main, addon) {
  result <- main %>%
    inner_join(addon, by = "country", suffix = c(".y", ".x"))
  return(result)
}

# Function to easily round mixed char and int dataframes found online
# Credit to Jeromy Anglim
# Link: https://jeromyanglim.tumblr.com/post/50228877196/
round_df <- function(x, digits) {
  # round all numeric variables
  # x: data frame
  # digits: number of digits to round
  numeric_columns <- sapply(x, mode) == 'numeric'
  x[numeric_columns] <-  round(x[numeric_columns], digits)
  x
}

# Inner joining each table with itself to get a table of all categories
big_table <- get_big_table(avg_life, avg_gov_spend_ratio)
big_table <- get_big_table(big_table, avg_gov_spending)
big_table <- get_big_table(big_table, avg_individual_spend)
big_table <- get_big_table(big_table, avg_gov_share)
big_table <- get_big_table(big_table, avg_private_share)

# Format to be more readable
big_table <- round_df(big_table, 1)
colnames(big_table) <- c(
  "Country",
  "Lifespan",
  "Healthcare to GDP Ratio",
  "Government Spending",
  "Individual Spending",
  "Government Share",
  "Private Share"
)

# Labels to use for dynamic label selection in shiny
x_vars <- c(
  "avg_gov_spend_ratio",
  "avg_gov_spending",
  "avg_individual_spend",
  "avg_gov_share",
  "avg_private_share"
)

titles <-
  c(
    "Life Expectancy vs Ratio of Government Health Spending",
    "Life Expectancy vs Government Spending",
    "Life Expectancy vs Individual Spending",
    "Life Expectancy vs Government Share of Health Spending",
    "Life Expectancy vs Private Share of Health Spending"
  )
x_labels <-
  c(
    "Percent of Total Government Spending Used on Healthcare",
    "Amount Spent (USD)",
    "Amount Spent (USD)",
    "Percent of Healthcare Covered by Government",
    "Percent of Healthcare Covered by Private Sources"
  )
y_labels <- c(
  "Average Life Expectancy (years)",
  "Average Life Expectancy (years)",
  "Average Life Expectancy (years)",
  "Average Life Expectancy (years)",
  "Average Life Expectancy (years)"
)
labels <-
  data.frame(
    "x_var" = x_vars,
    "title" = titles,
    "x_label" = x_labels,
    "y_label" = y_labels
  )

# Example static plots used for testing
life_vs_ratio <- create_plot(avg_life, avg_gov_spend_ratio) +
  geom_smooth() +
  labs(title = "Life Expectancy vs Ratio of Government Health Spending",
       x = "Percent of Total Government Spending Used on Healthcare",
       y = "Average Life Expectancy")
life_vs_ratio

life_vs_gov_spend <- create_plot(avg_life, avg_gov_spending) +
  geom_smooth() +
  labs(title = "Life Expectancy vs Government Spending",
       x = "Amount Spent (USD)",
       y = "Average Life Expectancy (years)")
life_vs_gov_spend

life_vs_individial_spend <-
  create_plot(avg_life, avg_individual_spend) +
  geom_smooth() +
  labs(title = "Life Expectancy vs Individual Spending",
       x = "Amount Spent (USD)",
       y = "Average Life Expectancy (years)")
life_vs_individial_spend

life_vs_gov_share <- create_plot(avg_life, avg_gov_share) +
  geom_smooth() +
  labs(title = "Life Expectancy vs Government Share of Health Spending",
       x = "Percent of Healthcare Covered by Government",
       y = "Average Life Expectancy (years)")
life_vs_gov_share

life_vs_private_share <- create_plot(avg_life, avg_private_share) +
  geom_smooth() +
  labs(title = "Life Expectancy vs Private Share of Health Spending",
       x = "Percent of Healthcare Covered by Private Sources",
       y = "Average Life Expectancy (years)")
life_vs_private_share
