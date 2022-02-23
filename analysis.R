library(tidyr)
library(dplyr)
library(tidyverse)
# Need to install.packages("zoo")
library(zoo)

# Data Prep

deaths_pre_covid <- read.csv("../data/deaths_pre_covid.csv",
                             stringsAsFactors = FALSE) %>%
  select(Year, Month, All.Cause, Intentional.Self.Harm..Suicide.) %>%
  mutate(suicide_percent_total_deaths = (Intentional.Self.Harm..Suicide. / All.Cause) * 100)
  
deaths_covid <- read.csv("../data/deaths_covid.csv",
                         stringsAsFactors = FALSE) %>%
  select(Year, Month, All.Cause, Intentional.Self.Harm..Suicide.) %>%
  mutate(suicide_percent_total_deaths = (Intentional.Self.Harm..Suicide. / All.Cause) * 100)

mental_healthcare <- read.csv("../data/mental_care.csv",
  stringsAsFactors = FALSE)

## Combines both Deaths dataframes into one.
deaths_pre_post_covid <- rbind(deaths_pre_covid, deaths_covid)
deaths_pre_post_covid$Date <- as.yearmon(paste(deaths_pre_post_covid$Year, deaths_pre_post_covid$Month), "%Y %m")

therapy_rate <- mental_healthcare %>%
  filter(Indicator == "Received Counseling or Therapy, Last 4 Weeks", Subgroup == "United States")


# Graphs and Visualizations

## These averages show an increase in suicides until 2020, when it drops.
average_suicides_2014 <- deaths_pre_covid %>%
  filter(Year == "2014")
average_suicides_2014 <- mean(average_suicides_2014$Intentional.Self.Harm..Suicide.)

average_suicides_2017 <- deaths_pre_covid %>%
  filter(Year == "2017")
average_suicides_2017 <- mean(average_suicides_2017$Intentional.Self.Harm..Suicide.)

average_suicides_2020 <- deaths_covid %>%
  filter(Year == "2020")
average_suicides_2020 <- mean(average_suicides_2020$Intentional.Self.Harm..Suicide.)





## Rates of suicide seem to be going up due to higher numbers
suicide_death_plot <- ggplot(deaths_pre_post_covid, aes(x = Date, y = Intentional.Self.Harm..Suicide., group = 1)) +
  geom_line() +
  geom_point()
## But if you plot the percent of total deaths from suicide, you can see a large drop in suicide rates! Could this be from higher telehealth usage?
suicide_percent_plot <- ggplot(deaths_pre_post_covid, aes(x = Date, y = suicide_percent_total_deaths, group = 1)) +
  geom_line() +
  geom_point()

