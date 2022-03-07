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
    titlePanel("Rates"),
    sidebarLayout(
      sidebarPanel(
        selectInput('plot1var', 'Suicide Measurement', choices = c("Intentional.Self.Harm..Suicide.", "suicide_percent_total_deaths"), 
                    selected = "Intentional.Self.Harm..Suicide.")
      ),
      mainPanel(
        plotOutput("plot1"),
        p("Based on these graphs, we can interpret that in general, the rates of suicide are decreasing over
          time (higher suicide rates pre-Covid than during Covid). Although the death rates caused by intentional
          self harm or suicide seem to be increasing compared to 2014, the percentage of all deaths due to suicide
          has decreased significantly since the Covid pandemic has started."),
        p("Looking at the specifics, the average number of suicides in 2014 was 3569.
          In 2017, it was 3931, which showed an increase. In 2020, however, it dropped to
          3843.")
      )
    )
)



panel2<- tabPanel(
    titlePanel("Means"),
    sidebarLayout(
      sidebarPanel(
        selectInput('plot2var', 'Suicide Measurement', choices = c("Intentional.Self.Harm..Suicide.", "suicide_percent_total_deaths"), 
                    selected = "Intentional.Self.Harm..Suicide.")
      ),
      mainPanel(
        plotOutput("plot2"),
        p("These bar graphs visualize the mean differences between Covid and Pre-Covid deaths and percent
        deaths. In the graph showcasing the number of deaths by suicide or intent of self-harm, the number of
        suicides during the Covid pandemic inches ahead slighty with 3858.37, while it was 3819.61 deaths pre-Covid. However, judging from the
        line graph that showcases the number of suicides over time, the number of suicides in the United States
        was steadily increasing over the years before Covid. The fact that the average number of deaths by
        suicide is so close during the Covid pandemic and before the pandemic can mean that the rate has slowed
        dramatically. This is evident in the second bar graph that shows the mean suicide rate (measured in
        percentage of all deaths attributed to suicide) before and during Covid, where a much higher percentage
        of all deaths in a year were attributed to suicide pre-Covid, with 1.67 percent compared to 1.4 percent.")
      )
    )
)

panel3<- tabPanel(
    titlePanel("Rates of Therapy"),
    sidebarLayout(
      sidebarPanel(
        selectInput('plot3var', 'Rates of Therapy Across:', choices = c("Across Time", "Across Race/Ethnicity"), 
                    selected = "Across Time")
      ),
      mainPanel(
          plotOutput("plot3"),
          p("Based on this graph, we see a steady increase of rates of therapy throughout the Covid Years.
            This data highly correlates with the previous graphs that indicate the percentage of all deaths due
            to suicide has been decreasing since the Covid pandemic. We speculate that the percentage of all
            deaths due to suicide may be decreasing over time due to the increased accessibility to
            therapy - telehealth delivery methods have been rapidly progressing during the stay-at-home order
            since 2019 in order to safely and better deliver health services to individuals.")
      )
    )
)

insights<- tabPanel(
    titlePanel("Insights"),
    sidebarLayout(
      sidebarPanel(
      ),
      mainPanel(
          h1("Insights"),
          p("Taking all of these graphs and data into account, we can see that not only is there a trend in a decrease 
            suicide rates over time (during Covid), but that there is a trend in an increase of rates of therapy over time.
            In addition to this, from our dataset, every ethnicity has seen at least a slight increase in therapy rates during
            January 2022 compared to August 2020 (pre-Covid). In particular, Hispanic or Latino and Non-Hispanic, other races
            and multiple races have seen a greater difference compared to pre-Covid therapy rates."),
          p("From these trends, we can identify that there may be a relationship between suicide rates and therapy rates 
            during Covid. In this observation, we can identify that there has been a great push towards the acceptance of mental
            health and finding resources for mental crises. During the Covid pandemic, telehealth has been a rapidly developing
            method of therapy delivery that has been able to increase accessibility towards attaining mental health care. 
            Therefore, we speculate that these factors may have a role with the decrease in suicide rates and increase in 
            rates of therapy over time.")
      )
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

