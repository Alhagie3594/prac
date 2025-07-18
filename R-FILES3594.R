
# Install packages (only needed once)
# install.packages(c("shiny", "readxl", "ggplot2"))

library(shiny)
library(readxl)
library(ggplot2)

# Import data 
student_data <- read_excel("C:/Users/user/Desktop/EXAM3594/DGH.xlsx")


# Remove rows with missing values
student_data <- na.omit(student_data)

# Simplified UI
ui <- fluidPage(
  titlePanel("Student Data Explorer"),
  sidebarLayout(
    sidebarPanel(
      selectInput("x_axis", "X-axis:",
                  choices = c("studying", "sleep", "age", "courses"),
                  selected = "studying"),
      selectInput("y_axis", "Y-axis:",
                  choices = c("gpa", "sleep", "age", "courses"),
                  selected = "gpa"),
      selectInput("color_by", "Color by:",
                  choices = c("sex", "employed"),
                  selected = "sex"),
      sliderInput("size", "Point size:", min = 1, max = 8, value = 3)
    ),
    mainPanel(
      plotOutput("scatter_plot")
    )
  )
)

# Server 
server <- function(input, output) {
  output$scatter_plot <- renderPlot({
    ggplot(student_data, aes_string(x = input$x_axis, y = input$y_axis, color = input$color_by)) +
      geom_point(size = input$size) +
      labs(title = paste(input$y_axis, "vs.", input$x_axis)) +
      theme_minimal()
  })
}

# Run the app
shinyApp(ui = ui, server = server)
renv:restoreInput()

