
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
lib <- c("shiny", "data.table", "dplyr", "ggplot2")
lapply(lib, library, character.only=T)

salary <- 100
breakdown <- as.data.frame(salary) %>% mutate("Living"= 0.30 * salary, "Network"= 0.20 * salary, "Learn"= 0.15 * salary, "Travel"= 0.10 * salary, "Invest"= 0.25 * salary) %>% select(-salary) %>% melt

shinyServer(function(input, output) {

  output$pieChart <- renderPlot({

    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    #ggplot(breakdown, aes(x="", y="value", fill=variable)) + geom_bar(width=1, stat="identity") + coord_polar("y", start=360)
    pie(breakdown$value, labels = breakdown$variable, clockwise = T)

  })

})
