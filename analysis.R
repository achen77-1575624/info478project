library(tidyr)
library(dplyr)
library(tidyverse)
# Need to install.packages("zoo")
library(zoo)

# Data Prep

deaths_pre_covid <- read.csv("./data/deaths_pre_covid.csv",
                             stringsAsFactors = FALSE) %>%
  select(Year, Month, All.Cause, Intentional.Self.Harm..Suicide.) %>%
  mutate(suicide_percent_total_deaths = (Intentional.Self.Harm..Suicide. / All.Cause) * 100)
  
deaths_covid <- read.csv("./data/deaths_covid.csv",
                         stringsAsFactors = FALSE) %>%
  select(Year, Month, All.Cause, Intentional.Self.Harm..Suicide.) %>%
  mutate(suicide_percent_total_deaths = (Intentional.Self.Harm..Suicide. / All.Cause) * 100)

## Combines both Deaths dataframes into one.
deaths_pre_post_covid <- rbind(deaths_pre_covid, deaths_covid)
deaths_pre_post_covid$Date <- as.yearmon(paste(deaths_pre_post_covid$Year, deaths_pre_post_covid$Month), "%Y %m")

mental_care <- read.csv("./data/mental_care.csv",
                        stringsAsFactors = FALSE)
mental_care$Start.Date <- strptime(mental_care$Time.Period.Start.Date, format = "%m/%d/%Y")
mental_care$Start.Date = as.Date(mental_care$Start.Date, format = "%m/%d%/%Y")

## Filters the mental_care dataset by receiving counseling/therapy and within all subgroups.
therapy_rate <- mental_care %>%
  filter(Indicator == "Received Counseling or Therapy, Last 4 Weeks", Subgroup == "United States")

## Filters the mental dataset by receiving counseling/therapy and by race.
race_therapy <- mental_care %>%
  filter(Indicator == "Received Counseling or Therapy, Last 4 Weeks", Group == "By Race/Hispanic ethnicity") %>%
  filter(Start.Date == "2020-08-19" | Start.Date == "2022-01-26") %>%
  select(Subgroup, Value, Start.Date) %>%
  pivot_wider(names_from = Start.Date, values_from = Value)

# Graphs and Visualizations

## These averages show an increase in suicides until 2020, when it drops.
average_suicides_2014 <- deaths_pre_covid %>%
  filter(Year == "2014")
average_suicides_2014 <- round(mean(average_suicides_2014$Intentional.Self.Harm..Suicide.))

average_suicides_2017 <- deaths_pre_covid %>%
  filter(Year == "2017")
average_suicides_2017 <- round(mean(average_suicides_2017$Intentional.Self.Harm..Suicide.))

average_suicides_2020 <- deaths_covid %>%
  filter(Year == "2020")
average_suicides_2020 <- round(mean(average_suicides_2020$Intentional.Self.Harm..Suicide.))



## Rates of suicide seem to be going up due to higher numbers
suicide_death_plot <- ggplot(deaths_pre_post_covid, aes(x = Date, y = Intentional.Self.Harm..Suicide., group = 1)) +
  geom_line() +
  geom_point() +
  geom_smooth() +
  labs(title = "Number of Suicides Over Time", x = "Date", y = "Deaths by SUicide or Intentional Harm")
## But if you plot the percent of total deaths from suicide, you can see a large drop in suicide rates! Could this be from higher telehealth usage?
suicide_percent_plot <- ggplot(deaths_pre_post_covid, aes(x = Date, y = suicide_percent_total_deaths, group = 1)) +
  geom_line() +
  geom_point() +
  geom_smooth() +
  labs(title = "Percentage of All Deaths Due to Suicide Over Time", x = "Date", y = "Percentage of All Deaths Due to Suicide or Intentional Harm")

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
mean_plot <- ggplot(mean_deaths_df, aes(x = covid, y = mean_deaths, fill = covid)) +
  geom_bar(stat="identity",position="dodge") +
  scale_fill_discrete(name="Year",
                      breaks=c(1, 2),
                      labels=c("Pre-Covid", "Covid"))+
  xlab("Years")+ylab("Death Means")
## the means do not differ, if anything, covid deaths were slightly more prevalent

perc_plot <- ggplot(perc_deaths_df, aes(x = covid, y = perc_deaths, fill = covid)) +
  geom_bar(stat="identity",position="dodge") +
  scale_fill_discrete(name="Year",
                      breaks=c(1, 2),
                      labels=c("Pre-Covid", "Covid"))+
  xlab("Years")+ylab("Percent Death Means")
## the means of death percentages show a significant difference between pre-covid and covid years 


## Rates of Counseling over COVID. Clear upward trend!
therapy_over_covid_plot <- ggplot(therapy_rate, mapping = aes(x = Start.Date, y = Value, group = 3)) +
  geom_line(size = 1.1, aes(color = Value)) +
  geom_point(size = 2) +
  theme(legend.position = "none") +
  geom_smooth() +
  labs(title = "Percentage of Population Who had Received Therapy/Counseling in the Last 4 Weeks Across COVID", x = "Date", y = "Percent of Population Who had Received Therapy/Counseling")

## Histogram(?) of Races, comparing 2 different time points and those who had attended counseling/therapy
race_therapy_histogram <- race_therapy %>%
  gather(Start.Date, val, -Subgroup) %>%
  ggplot(aes(Subgroup, val, fill = Start.Date)) +
  geom_col(position = "dodge2") +
  scale_x_discrete(guide = guide_axis(n.dodge=3)) +
  labs(title = "Rates of Population Attending Counseling/Therapy Throughout COVID Across Race", x = "Race", y = "Percentage of Population Attending Counseling/Therapy")