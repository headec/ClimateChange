#For a better scatter plot
library(car)

#LOAD 7 NECESSARY FILES
load("C02NorthernHemisphere.Rdata")
load("C02Worldwide.Rdata")
load("CanadianMeanTemp.Rdata")
load("CanadianAvgSnow.Rdata")
load("CanadianPrecip.Rdata")
load("CanadianMaxTemp.Rdata")
load("CanadianMinTemp.Rdata")

#REMOVE OUTLIERS
idx = MeanTemp == -9999.9
MeanTemp[idx] = NA
idx1 = AllSnow == -9999.9
AllSnow[idx1] = NA
idx2 = AllPrecip == -9999.9
AllPrecip[idx2] = NA
idx = MinTemp == -9999.9
MinTemp[idx] = NA
idx = MaxTemp == -9999.9
MaxTemp[idx] = NA

server <- function(input, output) {
  
  output$dataPlot <- renderPlot({
    
    if(input$varSource=="co2"){
      
      if (input$dataSource == "co2WW") {
        yrIdx = Co2World$YearDecimal>= input$yearRange[1] & Co2World$YearDecimal <= input$yearRange[2]
        y <- Co2World$Value[yrIdx]
        x <- Co2World$YearDecimal[yrIdx]
      } else {
        if(input$dataSource == "co2NH"){
          if(input$Lat==30) y<-Co2North$Latitude30value
          if(input$Lat==33) y<-Co2North$Latitude33value
          if(input$Lat==37) y<-Co2North$Latitude37value
          if(input$Lat==41) y<-Co2North$Latitude41value
          if(input$Lat==44) y<-Co2North$Latitude44value
          if(input$Lat==49) y<-Co2North$Latitude49value
          if(input$Lat==53) y<-Co2North$Latitude53value
          if(input$Lat==58) y<-Co2North$Latitude58value
          if(input$Lat==64) y<-Co2North$Latitude64value
          if(input$Lat==72) y<-Co2North$Latitude72value
          if(input$Lat==90) y<-Co2North$Latitude90value
          
          yrIdx = Co2North$YearDecimal>= input$yearRange[1] & Co2North$YearDecimal <= input$yearRange[2]
          y <- y[yrIdx]
          x <- Co2North$YearDecimal[yrIdx]
          
        }else{
          y=NULL
        }
      }
      if(!input$Scatter){
        plot(x,y,type="l",
             main = "CO2 levels with the selected option(Worldwide/Northen Hemisphere)",
             xlab = "Year Decimal",ylab="CO2 ppm")
      }else{
        if(!input$RegLine){
          plot(x,y,main = "CO2 levels with the selected option(Worldwide/Northen Hemisphere)",
               col=2,xlab = "Year",ylab="CO2 ppm")
        }else{
          scatter.smooth(x,y,main = "CO2 levels with the selected option(Worldwide/Northen Hemisphere)",
                         col=2,xlab = "Year",ylab="CO2 ppm")
        }
      }
      
    }
    else{
      ##########VARIABLES#############
      
      if(input$varSource=="meanTemp"){
        var = MeanTemp
        year = MeanTemp$Year 
      }
      else{
        if(input$varSource=="snow"){
          var = AllSnow
          year = AllSnow$Year
        }
        else{
          if(input$varSource=="precip"){
            var = AllPrecip
            year = AllPrecip$Year
          }
          else{
            if(input$varSource=="maxTp"){
              var = MaxTemp
              year = MaxTemp$Year
            }
            else{
              if(input$varSource=="minTp"){
                var = MinTemp
                year = MinTemp$Year
              }
              else{
                x=NULL
              }
            }
          }
        }
      }
      
      yrIdx = year>= input$yearRange[1] & year <= input$yearRange[2]
      year = year[yrIdx]
      
      #Average the Canadian climate data
      minYr = min(year)
      maxYr = max(year)
      y1 = 0
      x1 = 0
      
      for(i in minYr:maxYr){
        
        temp = as.numeric(var[year==i,input$Term])
        y1[i] = mean(temp[!is.na(temp)])
        x1[i] = i
      }
      y1 = y1[-(1)]
      x1 = x1[-(1)]
      
      
      if(!input$Scatter){
        plot(x1,y1,type="l", main = "Mean of Selected Options in Canada by Year",
             xlab = "Year",ylab="Temperature/Snowfall")
        
      }else{
        scatterplot(x1,y1,smooth = F,grid = F,main = "Mean of Selected Options in Canada by Year",
                    xlab = "Year",ylab="Temperature/Snowfall/Precipitation", regLine = input$RegLine)
      }
    }  
    
  })
  
  #Summary of y-axis
  output$summary <- renderPrint({
    if(input$varSource=="co2"){
      if (input$dataSource == "co2WW"){
        yrIdx = Co2World$YearDecimal>= input$yearRange[1] & Co2World$YearDecimal <= input$yearRange[2]
        y1 <- Co2World$Value[yrIdx]
      }else{
        if(input$dataSource == "co2NH"){
          if(input$Lat==30) y1<-Co2North$Latitude30value
          if(input$Lat==33) y1<-Co2North$Latitude33value
          if(input$Lat==37) y1<-Co2North$Latitude37value
          if(input$Lat==41) y1<-Co2North$Latitude41value
          if(input$Lat==44) y1<-Co2North$Latitude44value
          if(input$Lat==49) y1<-Co2North$Latitude49value
          if(input$Lat==53) y1<-Co2North$Latitude53value
          if(input$Lat==58) y1<-Co2North$Latitude58value
          if(input$Lat==64) y1<-Co2North$Latitude64value
          if(input$Lat==72) y1<-Co2North$Latitude72value
          if(input$Lat==90) y1<-Co2North$Latitude90value
          yrIdx = Co2North$YearDecimal>= input$yearRange[1] & Co2North$YearDecimal <= input$yearRange[2]
          y1 <- y1[yrIdx]
        }
        else{
          y1=NULL
        }
      }
      summary(y1)
      }else{  
      if(input$varSource=="meanTemp"){
        var = MeanTemp
        year = MeanTemp$Year 
      }
      else{
        if(input$varSource=="snow"){
          var = AllSnow
          year = AllSnow$Year
        }
        else{
          if(input$varSource=="precip"){
            var = AllPrecip
            year = AllPrecip$Year
          }
          else{
            if(input$varSource=="maxTp"){
              var = MaxTemp
              year = MaxTemp$Year
            }
            else{
              if(input$varSource=="minTp"){
                var = MinTemp
                year = MinTemp$Year
              }
              else{
                x=NULL
              }
            }
          }
        }
      }
      
      yrIdx = year>= input$yearRange[1] & year <= input$yearRange[2]
      year = year[yrIdx]
        
      
      minYr = min(input$yearRange[1])
      maxYr = max(input$yearRange[2])
      #value
      y1 = 0
      
      for(i in minYr:maxYr){
        temp = as.numeric(var[year==i,input$Term])
        y1[i] = mean(temp[!is.na(temp)])
      }
      y1 = y1[-(1)]
      
      summary(y1)
    }
  })
  
  #Summary of x-axis
  output$summary1 <- renderPrint({
    if(input$varSource=="co2"){
      if(input$dataSource=="co2WW"){
        yrIdx = Co2World$Year>= input$yearRange[1] & Co2World$Year <= input$yearRange[2]
        x <- Co2World$Year[yrIdx]
      }else{
        if(input$dataSource=="co2NH"){
          yrIdx = Co2North$Year>= input$yearRange[1] & Co2North$Year <= input$yearRange[2]
          x <- Co2North$Year[yrIdx]
        }
      }
    }else{
      if(input$varSource=="meanTemp"){
        yrIdx = MeanTemp$Year>= input$yearRange[1] & MeanTemp$Year <= input$yearRange[2]
        x <- MeanTemp$Year[yrIdx]
      }
      else{
        if(input$varSource=="snow"){
          yrIdx = AllSnow$Year>= input$yearRange[1] & AllSnow$Year <= input$yearRange[2]
          x <- AllSnow$Year[yrIdx]
        }
        else{
          if(input$varSource=="precip"){
            yrIdx = AllPrecip$Year>= input$yearRange[1] & AllPrecip$Year <= input$yearRange[2]
            x <- AllPrecip$Year[yrIdx]          
          }
          else{
            if(input$varSource=="maxTp"){
              yrIdx = MaxTemp$Year>= input$yearRange[1] & MaxTemp$Year <= input$yearRange[2]
              x <- MaxTemp$Year[yrIdx]          
            }
            else{
              if(input$varSource=="minTp"){
                yrIdx = MinTemp$Year>= input$yearRange[1] & MinTemp$Year <= input$yearRange[2]
                x <- MinTemp$Year[yrIdx]          
              }
              else{
                x=NULL
              }
            }
          }
        }
      }
    }
    summary(x)
  })
  
  ##############################################FROM HERE, FOR TAB 3#######################################
  
  output$a_coPlot <- renderPlot({
    par(mfrow=c(1,2))
    x = Co2World$YearDecimal
    y = Co2World$Value
    scatter.smooth(x,y,main = "Worldwide CO2 Level by Year",
                   col=2,xlab = "Year",ylab="CO2 ppm")
    x1 = Co2North$YearDecimal
    y1 = Co2North$Latitude49value
    scatter.smooth(x1,y1,main = "CO2 Level at Latitude 49 by Year",
                   col=2,xlab = "Year",ylab="CO2 ppm")
  })
  
  output$a_caPlot <- renderPlot({
    idx = MeanTemp$Year>=1979 &MeanTemp$Year<=2018
    year = MeanTemp$Year[idx]
    var = MeanTemp
    #Average the Canadian climate data
    minYr = min(year)
    maxYr = max(year)
    y1 = 0
    x1 = 0
    
    for(i in minYr:maxYr){
      
      temp = as.numeric(var[year==i,"Annual"])
      y1[i] = mean(temp[!is.na(temp)])
      x1[i] = i
    }
    y1 = y1[-(1)]
    x1 = x1[-(1)]
    
    scatterplot(x1,y1,smooth = F,grid = F,main = "Mean of Mean Temperature in Canada by Year",
                xlab = "Year",ylab="Temperature")
  })
  
  
  output$a_caPlot2 <- renderPlot({
      
    idx = MinTemp$Year>=1979 &MinTemp$Year<=2018
    year = MinTemp$Year[idx]
    var = MinTemp
    #Average the Canadian climate data
    minYr = min(year)
    maxYr = max(year)
    y1 = 0
    x1 = 0

    for(i in minYr:maxYr){
      
      temp = as.numeric(var[year==i,"Annual"])
      y1[i] = mean(temp[!is.na(temp)])
      x1[i] = i
    }
    y1 = y1[-(1)]
    x1 = x1[-(1)]
    
    scatterplot(x1,y1,smooth = F,grid = F,main = "Mean of Minimum Temperature in Canada by Year",
                xlab = "Year",ylab="Temperature")
  })
  
  
  output$a_caPlot3 <- renderPlot({
      
    idx = MaxTemp$Year>=1979 &MaxTemp$Year<=2018
    year = MaxTemp$Year[idx]
    var = MaxTemp
    #Average the Canadian climate data
    minYr = min(year)
    maxYr = max(year)
    y1 = 0
    x1 = 0
    
    for(i in minYr:maxYr){
      
      temp = as.numeric(var[year==i,"Annual"])
      y1[i] = mean(temp[!is.na(temp)])
      x1[i] = i
    }
    y1 = y1[-(1)]
    x1 = x1[-(1)]
    
    scatterplot(x1,y1,smooth = F,grid = F,main = "Mean of Maximum Temperature in Canada by Year",
                xlab = "Year",ylab="Temperature")
  })
  output$a_caPlot4 <- renderPlot({
    
    idx = AllSnow$Year>=1979 & AllSnow$Year<=2018
    year = AllSnow$Year[idx]
    var = AllSnow
    #Average the Canadian climate data
    minYr = min(year)
    maxYr = max(year)
    y1 = 0
    x1 = 0
    
    for(i in minYr:maxYr){
      
      temp = as.numeric(var[year==i,"Annual"])
      y1[i] = mean(temp[!is.na(temp)])
      x1[i] = i
    }
    y1 = y1[-(1)]
    x1 = x1[-(1)]
    
    scatterplot(x1,y1,smooth = F,grid = F,main = "Mean of Average Snow in Canada by Year",
                xlab = "Year",ylab="Snowfall")
  })
  
  output$a_caPlot5 <- renderPlot({
    
    idx = AllPrecip$Year>=1979 & AllPrecip$Year<=2018
    year = AllPrecip$Year[idx]
    var = AllPrecip
    #Average the Canadian climate data
    minYr = min(year)
    maxYr = max(year)
    y1 = 0
    x1 = 0
    
    for(i in minYr:maxYr){
      
      temp = as.numeric(var[year==i,"Annual"])
      y1[i] = mean(temp[!is.na(temp)])
      x1[i] = i
    }
    y1 = y1[-(1)]
    x1 = x1[-(1)]
    
    scatterplot(x1,y1,smooth = F,grid = F,main = "Mean of Precipitation in Canada by Year",
                xlab = "Year",ylab="Precipitation")
  })
}