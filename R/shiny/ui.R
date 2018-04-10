library(shinydashboard)
library(shiny)
library(rvest)
library(magrittr)
library(lubridate)
library(googleVis)

shinyUI(dashboardPage(
  # app's header
  dashboardHeader(title = "Hungarian Breweries ",titleWidth = 500),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Breweries", tabName = "breweries", icon = icon("dashboard")),
      menuItem("Established", tabName = "established", icon = icon("bar-chart")),
      menuItem("Pécs Beer", tabName = "pecs", icon = icon("dashboard"))
    )#end of sidBarMenu
  ),# end of dashboarSideBar
  # dashboardbody
  dashboardBody(
    tabItems(
      # 1st widget
      tabItem(tabName = "breweries",
              fluidRow(
                # Dynamic boxes, infoBoxes
                box(title="Hello :)",
                    solidHeader = TRUE,
                    status="success",
                    "This is a simple app to show some capabilities of Shiny",
                    width = 12),
                box(title="Breweries in Hungary",
                    solidHeader = TRUE,
                    status = "info",
                    dataTableOutput("table")
                    ),
                # oldest and newest brewery
                infoBoxOutput("oldest"),
                infoBoxOutput("newest")
              )), # end of fluidRow
      # 2nd widget
      tabItem(tabName = "established",
              fluidRow(
                # Dynamic Boxes
                box(title="Basic R plot....",
                    solidHeader = TRUE,
                    status="success",
                    plotOutput("distPlot"),
                    width = 12),
                box(title = "GoogleVis scatter plot",
                    solidHeader = TRUE,
                    status = "danger",
                    htmlOutput("view"),
                    width = 12)
              )), # end of tabItem established
      # 3rd widget
      tabItem(tabName = "pecs",
              fluidRow(
                # select by beer type,
              selectInput("select", label = h3("Select beer type"), 
                          choices = list("Pale" = "Pale",
                                         "Radler" = "Radler",
                                         "Pécsi Radler" = "Pécsi Radler",
                                         "Retired" = "retired"), 
                          selected = 1),
                box(title = "Beers in Pécs",
                    solidHeader = TRUE,
                    status = "success",
                    dataTableOutput("gvis"),
                    width = 6
                    ),
              box(title = "GoogleVis",
                  solidHeader = TRUE,
                  status = "danger",
                  htmlOutput("view_tbl"),
                  width = 6),
              box(title = "Beers",
                  solidHeader = FALSE,
                  status = "warning",
                  htmlOutput("view_gauge"),
                  width = 6)
              )) # end of fluidRow

    ) # end of tabImtems
  )# end of dashBoardBody
  
  
) # dashboardPage
) # shinyUI