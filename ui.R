#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
#install shinythemes
library("shinythemes")
data(mpg)

introduction <- tabPanel(
    titlePanel("Introduction"),
    mainPanel(
        h1("Introduction"),
        p("In a time of crisis, a population largely suffering from mental health problems can have far-reaching
          adverse effects. It can affect the healthcare sector with increased hospitalizations from self-harm,
          especially if there aren't enough therapy resources available. It can affect the community, where
          hopelessness can translate into depression. Most drastic of all, suicide rates can increase. According
          to the CDC, suicide is the 10th leading cause of death in the United States. The COVID pandemic has
          closed many people off from social contact. Quarantines and social isolation wear away at mental health,
          and suicide has the risk of following. In particular, the question we wish to answer is: How has the
          COVID pandemic affected suicide rates in the U.S.? Has this been affected by therapy-seeking behaviors?")
    )
)

panel1<- tabPanel(
    titlePanel("Suicide Rates and Percent Rates"),
    sidebarLayout(
      sidebarPanel(
        selectInput('plot1var', 'plot1var', choices = c("Intentional.Self.Harm..Suicide.", "suicide_percent_total_deaths"), 
                    selected = "Intentional.Self.Harm..Suicide.")
      ),
      mainPanel(
        plotOutput("plot1"),
        p("Based on these graphs, we can interpret that in general, the rates of suicide are decreasing over
          time (higher suicide rates pre-Covid than during Covid). Although the death rates caused by intentional
          self harm or suicide seem to be increasing compared to 2014, the percentage of all deaths due to suicide
          has decreased significantly since the Covid pandemic has started."),
        p("Looking at the specifics, the average number of suicides in 2014 was `r average_suicides_2014`.
          In 2017, it was `r average_suicides_2017`, which showed an increase. In 2020, however, it dropped to
          `r average_suicides_2020`.")
      )
    )
)



panel2<- tabPanel(
    titlePanel("Means of Total Suicides and Percentage of Deaths"),
    sidebarLayout(
      sidebarPanel(
        selectInput('plot2var', 'plot2var', choices = c("Intentional.Self.Harm..Suicide.", "suicide_percent_total_deaths"), 
                    selected = "Intentional.Self.Harm..Suicide.")
      ),
      mainPanel(
        plotOutput("plot2"),
        p("These bar graphs visualize the mean differences between Covid and Pre-Covid deaths and percent
        deaths. In the graph showcasing the number of deaths by suicide or intent of self-harm, the number of
        suicides during the Covid pandemic inches ahead slighty with `r round(mean_deaths_df$mean_deaths[2], 2)`,
        while it was `r round(mean_deaths_df$mean_deaths[1], 2)` deaths pre-Covid. However, judging from the
        line graph that showcases the number of suicides over time, the number of suicides in the United States
        was steadily increasing over the years before Covid. The fact that the average number of deaths by
        suicide is so close during the Covid pandemic and before the pandemic can mean that the rate has slowed
        dramatically. This is evident in the second bar graph that shows the mean suicide rate (measured in
        percentage of all deaths attributed to suicide) before and during Covid, where a much higher percentage
        of all deaths in a year were attributed to suicide pre-Covid, with `r round(perc_deaths_df$perc_deaths[1], 2)`
        percent compared to `r round(perc_deaths_df$perc_deaths[2], 2)` percent.")
      )
    )
)

panel3<- tabPanel(
    titlePanel("panel 3"),
    mainPanel(
        h1("panel 3"),
    )
)

insights<- tabPanel(
    titlePanel("Insights"),
    mainPanel(
        h1("Insights"),
    )
)

my_ui <- navbarPage(
    theme = shinytheme("flatly"),
    tags$div("Final Deliverable"),
    introduction,
    panel1,
    panel2,
    panel3,
    insights
)
shinyUI(my_ui)

