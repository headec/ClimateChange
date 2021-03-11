library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("CO2 levels and Canadian Climate"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      #GENERAL
      helpText(HTML("<h4>Input Values</h4>")),
      radioButtons("dataSource", "",
                   c("CO2 Worldwide" = "co2WW",
                     "CO2 Northern Hemisphere" = "co2NH")),
      selectInput("Lat", "Select Latitude of Northern Hemisphere", c(30,33,37,41,44,49,53,58,64,72,90),selected=30),
      
      sliderInput(inputId = "yearRange",
                  label = "Year Range",
                  min = 1840,
                  max = 2019,
                  value = c(1979,2017)),
      helpText(HTML("<h5>For CO2 plots, range from 1979 to 2017(8) is available</h>")),
      radioButtons("varSource", "",
                   c("CO2 Level"="co2",
                     "Mean Temperature" = "meanTemp",
                     "Maximum Temperature"="maxTp",
                     "Minimum Temperature"="minTp",
                     "Average Snowfall" = "snow", 
                     "Precipitation"="precip")),
      selectInput("Term", "Select Term", c("Spring","Summer","Autumn","Winter","Annual"),selected="Annual"),
      helpText(HTML("<h5>For each term, a mean value of observations from different parts of Canada is calculated</h5>")),
      checkboxInput("Scatter", strong("Make it Scattered"), FALSE),
      conditionalPanel(
        condition = "input.Scatter == true",  
        checkboxInput("RegLine", strong("Add a Regression Line"), FALSE)  
      )
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      tabsetPanel(type="tabs",
                  tabPanel("About",source("about.R")$value()), #This is the new tab with some info
                 # tabPanel("CO2 Level Density", plotOutput(outputId = "distPlot")),
                  tabPanel("Plots with Inputs",
                           plotOutput(outputId= "dataPlot"),verbatimTextOutput("summary")
                           ,verbatimTextOutput("summary1")),
                 tabPanel("Analaysis of Data", plotOutput(outputId="a_coPlot"),
                          HTML(paste("Here, we could see that both the worldwide level of CO2 and the level of
                                     CO2 at Latitude 49 are increasing every year.")),
                               plotOutput(outputId="a_caPlot"),plotOutput(outputId="a_caPlot2"),plotOutput(outputId="a_caPlot3"),
                          HTML(paste("Using the same range of years that worldwide CO2 data uses, we could see that the overall temperature,
                                     mean, minimum, and maximum temperature, are increasing. As the temperature increases annually, the rate of snowfall
                                     can be influenced; as the temperature increases, the rate and the amount of snowflake formation can be decreased.
                                     Thereby, we could assume that there is less likely chance to have snowfall. 
                                     Let's refer to the snowfall data and check what's happening.")), 
                                    plotOutput(outputId="a_caPlot4"),
                                    HTML(paste("As we all have expected, the rate of snowfall is decreasing every year. In other words, we could also
                                               assume that the precipitation might have been decreased as well due to an increase in temperature. 
                                               Water will tend to evaporate easily under a higher temperature resulting in less precipitation. For example,
                                               desert environments are extremely dry, sparse in water, and precipitation rarely occurs.")), 
                                    plotOutput(outputId="a_caPlot5"),HTML(paste("Again, as our assumption above indicates, there is a visible decrease in
                                                                                precipitation from increasing temperature where temperature is increased 
                                                                                proportional to the level of CO2.<br>In summary, we could state that
                                                                                an <strong>increase in CO2 level</strong> results in an 
                                                                                <strong>increase in temperature</strong> and
                                                                                a <strong>decrease in snowfall and precipitation</strong> according to the
                                                                                provided data.")))
                          )
                  
      )
      
    )
  )


