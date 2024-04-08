library(shiny)
library(readxl)
library(dplyr)

CVdata <- read_excel("C:/Users/josyeat/Documents/FeathersAnalyticsCV/ResumeRShiny.xlsx")
CVdata

# Define UI for application that draws a histogram
ui <- fluidPage(
   
  #Title Panel 
  titlePanel("Joseph Yeates CV"),

  #Sidebar Layout
   sidebarLayout(
     
    #Highlights of Qualifications
     sidebarPanel(h2("Highlights of Qualifications"),
                  p("The list of highlights"),
     
      #Select Inputs
                  dateRangeInput("DateRange", label = "Date Range", start = min(CVdata$StartDate), end = max(CVdata$EndDate), min = min(CVdata$StartDate), max = max(CVdata$EndDate)),
                  selectInput("SelectSection", label = "Select CV Section", choices = unique(CVdata$Section), selected = "Work Experience")
      ),
      #Main Panel
      mainPanel(textOutput("selected_section"))
   )
)

# Define server logic
server <- function(input, output) {
   
  output$selected_section <- renderText({
    section_desc <- CVdata %>% 
                    filter(Section == input$SelectSection & StartDate >= as.POSIXct(input$DateRange[1]))
                           })
}

# Run the application 
shinyApp(ui = ui, server = server)

