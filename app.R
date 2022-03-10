library("shiny")
source("ui.R")
source("server.R")
library("rsconnect")
#install.packages("rsconnect")

shinyApp(ui = my_ui, server = my_server)
