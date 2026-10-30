# Iris Dashboard - a simple Shiny app using R's built-in iris data set.
#
# Dashboard: 3 visualizations (scatter plot, histogram, box plot)
# Interactive function: pick the species and the measurement to explore;
# all three plots update automatically.

library(shiny)
library(ggplot2)

# Column names we let the user choose from (the 4 numeric columns of iris).
measurements <- names(iris)[1:4]

# ---- UI: what the user sees -------------------------------------------------
ui <- fluidPage(
  titlePanel("Iris Dashboard"),

  sidebarLayout(
    # Interactive controls
    sidebarPanel(
      selectInput("measure", "Measurement:", choices = measurements,
                  selected = "Sepal.Length"),
      checkboxGroupInput("species", "Species:",
                         choices = levels(iris$Species),
                         selected = levels(iris$Species)),
      helpText("Change the options and all three charts update.")
    ),

    # The dashboard: three visualizations
    mainPanel(
      plotOutput("scatter", height = "280px"),
      fluidRow(
        column(6, plotOutput("histogram", height = "260px")),
        column(6, plotOutput("boxplot", height = "260px"))
      ),
      tags$p(style = "color: gray; margin-top: 10px;", "Submitted by Steven David")
    )
  )
)

# ---- Server: the logic behind the charts ------------------------------------
server <- function(input, output, session) {

  # Filter iris to the species the user ticked (reactive = reruns when input changes).
  filtered <- reactive({
    req(input$species)  # wait until at least one species is selected
    iris[iris$Species %in% input$species, ]
  })

  # 1. Scatter plot: the chosen measurement vs. Petal.Width
  output$scatter <- renderPlot({
    ggplot(filtered(), aes(x = .data[[input$measure]], y = Petal.Width, color = Species)) +
      geom_point(size = 2) +
      labs(title = paste(input$measure, "vs. Petal.Width"),
           x = input$measure, y = "Petal.Width") +
      theme_minimal()
  })

  # 2. Histogram: distribution of the chosen measurement
  output$histogram <- renderPlot({
    ggplot(filtered(), aes(x = .data[[input$measure]], fill = Species)) +
      geom_histogram(bins = 15, alpha = 0.7, position = "identity") +
      labs(title = paste("Distribution of", input$measure), x = input$measure) +
      theme_minimal()
  })

  # 3. Box plot: the chosen measurement by species
  output$boxplot <- renderPlot({
    ggplot(filtered(), aes(x = Species, y = .data[[input$measure]], fill = Species)) +
      geom_boxplot() +
      labs(title = paste(input$measure, "by Species"), y = input$measure) +
      theme_minimal() +
      theme(legend.position = "none")
  })
}

shinyApp(ui = ui, server = server)
