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

<<<<<<< HEAD
mental_healthcare <- read.csv("../data/mental_care.csv",
  stringsAsFactors = FALSE)
=======
mental_care <- read.csv("./data/mental_care.csv",
                        stringsAsFactors = FALSE) 
>>>>>>> 9925664a62a1bc92aa82b3cc81cbdfab79b08bc0

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

## Calculating and graphing the mean suicide rates precovid and 2020
pre_mean <- mean(deaths_pre_covid$Intentional.Self.Harm..Suicide.)
covid_mean <- mean(deaths_covid$Intentional.Self.Harm..Suicide., na.rm = TRUE)

pre_mean_percent <- mean(deaths_pre_covid$suicide_percent_total_deaths)
covid_mean_percent <- mean(deaths_covid$suicide_percent_total_deaths, na.rm = TRUE)

#Making dataframe from values to graph
covid <- c("Pre-Covid", "Covid")
mean_deaths <- c(pre_mean, covid_mean)

mean_deaths_df <- data.frame(covid, mean_deaths)

#percent dataframe
perc_deaths <- c(pre_mean_percent, covid_mean_percent)
perc_deaths_df <- data.frame(covid, perc_deaths)

#Graphs
mean_plot <- ggplot(mean_deaths_df, aes(x = covid, y = mean_deaths)) +
  geom_bar(stat="identity",position="dodge") +
  scale_fill_discrete(name="Year",
                      breaks=c(1, 2),
                      labels=c("Pre-Covid", "Covid"))+
  xlab("Years")+ylab("Death Means")
## the means do not differ, if anything, covid deaths were slightly more prevalent

perc_plot <- ggplot(perc_deaths_df, aes(x = covid, y = perc_deaths)) +
  geom_bar(stat="identity",position="dodge") +
  scale_fill_discrete(name="Year",
                      breaks=c(1, 2),
                      labels=c("Pre-Covid", "Covid"))+
  xlab("Years")+ylab("Percent Death Means")
## the means of death percentages show a significant difference between pre-covid and covid years 

