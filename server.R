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
    plot2 <- ggplot(mean_deaths_df, aes_string(x = mean_deaths_df$covid, y = input$plot2var, fill = mean_deaths_df$covid)) +
      geom_bar(stat="identity",position="dodge") +
      scale_fill_discrete(name="Year",
                          breaks=c(1, 2),
                          labels=c("Pre-Covid", "Covid"))
    if (input$plot2var == "Intentional.Self.Harm..Suicide.") {
      plot2 = plot2 + labs(title = "Suicide Death Means During Covid and Pre-Covid", x = "Years during Covid or Pre-Covid", y = "Death Means")
    } else if (input$plot2var == "suicide_percent_total_deaths") {
      plot2 = plot2 + labs(title = "Mean Percent Suicide Deaths During Covid and Pre-Covid", x = "Years during Covid or Pre-Covid", y = "Percent Death Means")
    }
    print(plot2)
  })
  
}

shinyServer(my_server)
