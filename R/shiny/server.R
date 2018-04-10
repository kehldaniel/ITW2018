library(shinydashboard)
library(shiny)
library(rvest)
library(magrittr)
library(lubridate)

# load help file
# get basic data
source("help.R")

shinyServer(function(input, output) {
  # table
  output$table <- renderDataTable({
  tmp_table
  })
  # infobox with the oldest data
  output$oldest <- renderInfoBox({
    infoBox(
      "Oldest...", tmp_table[order(tmp_table$Est.),][1, 4],
      icon = icon("list"),
      color = "red"
    )
  })
  # infobox with the newest data
  output$newest <- renderInfoBox({
    infoBox(
      "Newest..", tmp_table[order(tmp_table$Est., decreasing = TRUE),][1, 4],
      icon = icon("calendar"),
      color = "purple"
    )
  })
  # create basic R plot
  output$distPlot <- renderPlot({
    # create plot
    plot(x = tmp_table$`Est.`,
         y = tmp_table$`Beer Count`)
    # add mean as horizontal line
    abline(h = mean(tmp_table$`Beer Count`))
  })
  # create googleVis scatterPlot
  output$view <- renderGvis({
    tmp_gvis <- tmp_table
    gvisScatterChart(tmp_gvis[, c("Est.", "Beer Count")])
  })
  # create table
  output$gvis <- renderDataTable({
    tmp_df <- pecs_beer_tbl[grep(input$select, pecs_beer_tbl$Name), ]
    tmp_df
  })
  # create googleVis scatterPlot
  # define title, xlab and ylab
  output$view_tbl <- renderGvis({
    tmp_df_view <- pecs_beer_tbl[grep(input$select, pecs_beer_tbl$Name), ]
    gvisScatterChart(tmp_df_view[, c("ABV", "Score")], options = list(
      title = input$select,
      vAxis = "{title:'Score (score by users)'}",
      hAxis = "{title:'ABV (Alcohol by Volume)'}"
    )
                     )
  })
  # create gauge 
  output$view_gauge <- renderGvis({
  tmp_df_view_gauge <- pecs_beer_tbl[grep(input$select, pecs_beer_tbl$Name), ]
  gvisGauge(tmp_df_view_gauge[1:8, 1:2], 
            options=list(min = 0, max = 10,
                         greenFrom = 0, greenTo = 4,
                         yellowFrom = 4, yellowTo = 7,
                         redFrom = 7, redTo = 10
                         )
            )
  })

}) # end of server function
