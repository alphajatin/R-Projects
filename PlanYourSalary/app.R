
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

lib <- c("shiny", "data.table", "dplyr", "ggplot2", "plotly")
lapply(lib, library, character.only=T)


ui <- fluidPage(

  # Application title
  titlePanel("Li Ka-Shing’s wisdom on money"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    
    sidebarPanel(
      numericInput("salary", "Salary:",190,  min=1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      
      plotlyOutput("pieChart")
    )
  )
)

# This is the server logic for a Shiny web application.

 server <- function(input, output) {

colors <- c('rgb(211,94,96)', 'rgb(128,133,133)', 'rgb(144,103,167)', 'rgb(171,104,87)', 'rgb(114,147,203)')
   
  output$pieChart <- renderPlotly({
    salary <- input$salary
    print(salary)
    breakdown <- as.data.frame(salary) %>% mutate("Living"= 0.30 * salary, "Network"= 0.20 * salary, "Learn"= 0.15 * salary, "Travel"= 0.10 * salary, "Invest"= 0.25 * salary) %>%
      select(-salary) %>% melt()
    #pie(breakdown$value, labels = breakdown$variable, clockwise = T)
    plot_ly(breakdown, labels= ~variable, values= ~value, type='pie', textposition='inside', textinfo='label', marker=list(colors=colors, line=list(color='#FFFFFF', width=1)), showlegend=FALSE)
  })
  
}
 
shinyApp(ui, server)

