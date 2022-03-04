#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
source("./analysis.R")

my_server <- function(input, output) {
  
  output$plot1 <- renderPlot({
    plot1 <- ggplot(deaths_pre_post_covid, aes_string(x = deaths_pre_post_covid$Date, y = input$plot1var, group = 1)) +
      geom_line() +
      geom_point() +
      geom_smooth()
    if (input$plot1var == "Intentional.Self.Harm..Suicide.") {
      plot1 = plot1 + labs(title = "Number of Suicides Over Time", x = "Date", y = "Deaths by Suicide or Intentional Harm")
    } else if (input$plot1var == "suicide_percent_total_deaths") {
      plot1 = plot1 + labs(title = "Percentage of All Deaths Due to Suicide Over Time", x = "Date", y = "Percentage of All Deaths Due to Suicide or Intentional Harm")
    }
    print(plot1)
  })
  
  output$plot2 <- renderPlot({
    if (input$plot2var == "Intentional.Self.Harm..Suicide.") {
      plot2 <- ggplot(mean_deaths_df, aes(x = covid, y = mean_deaths, fill = covid)) +
        geom_bar(stat="identity",position="dodge") +
        scale_fill_discrete(name="Year",
                            breaks=c(1, 2),
                            labels=c("Pre-Covid", "Covid"))+
        labs(title = "Suicide Death Means During Covid and Pre-Covid", x = "Years during Covid or Pre-Covid", y ="Death Means")
    } else if (input$plot2var == "suicide_percent_total_deaths") {
      plot2 <- ggplot(perc_deaths_df, aes(x = covid, y = perc_deaths, fill = covid)) +
        geom_bar(stat="identity",position="dodge") +
        scale_fill_discrete(name="Year",
                            breaks=c(1, 2),
                            labels=c("Pre-Covid", "Covid"))+
        labs(title = "Mean Percent Suicide Deaths During Covid and Pre-Covid", x = "Years during Covid or Pre-Covid", y = "Percent Death Means")
    }
    print(plot2)
  })
  
  output$plot3 <- renderPlot({
    if (input$plot3var == "Across Time") {
      plot3 <- ggplot(therapy_rate, mapping = aes(x = Start.Date, y = Value, group = 3)) +
        geom_line(size = 1.1, aes(color = Value)) +
        geom_point(size = 2) +
        theme(legend.position = "none") +
        geom_smooth() +
        labs(title = "Percentage of Population Who had Received Therapy/Counseling in the Last 4 Weeks Across COVID", x = "Date", y = "Percent of Population Who had Received Therapy/Counseling")
    } else if (input$plot3var == "Across Race/Ethnicity") {
      plot3 <- race_therapy %>%
        gather(Start.Date, val, -Subgroup) %>%
        ggplot(aes(Subgroup, val, fill = Start.Date)) +
        geom_col(position = "dodge2") +
        scale_x_discrete(guide = guide_axis(n.dodge=3)) +
        labs(title = "Rates of Population Attending Counseling/Therapy Throughout COVID Across Race", x = "Race", y = "Percentage of Population Attending Counseling/Therapy")
    }
    print(plot3)
  })
  
}

shinyServer(my_server)
