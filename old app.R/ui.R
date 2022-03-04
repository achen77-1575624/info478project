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

introduction <- tabPanel(
    titlePanel("Introduction"),
    sidebarLayout(
        h1("Introduction"),
        p("this is where we talk about the project.")
    )
)

panel1<- tabPanel(
    titlePanel("panel 1"),
    sidebarLayout(
        h1("panel 1"),
    )
)

panel2<- tabPanel(
    titlePanel("panel 2"),
    sidebarLayout(
        h1("panel 2"),
    )
)

panel3<- tabPanel(
    titlePanel("panel 3"),
    sidebarLayout(
        h1("panel 3"),
    )
)

insights<- tabPanel(
    titlePanel("Insights"),
    sidebarLayout(
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

