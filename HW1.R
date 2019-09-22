# HW 1
# @Sumaanyu Maheshwari

## Import Packages {
library(dplyr)
library(ggplot2)
library(GGally) 
library(car) # for VIF

## Load data
df <- read.csv("Wrangler142-Fall2019.csv") 

## Explore Data
str(df)
head(df)

# Plot scatter matrix
# density plots on the diagonal and correlation printed in the upper triangle
ggscatmat(df, columns = 2:7, alpha = 0.8)

# split into training and test sets 
df.train <- filter(df, Year <= 2015) 
head(df.train)
tail(df.train)
df.test <- filter(df, Year > 2015)
head(df.test)
tail(df.test)

# train the model
#lm(y~x1+x2+...,data)
mod1 <- lm(WranglerSales ~ Unemployment + WranglerQueries + CPI.Energy + CPI.All,
           data = df.train)
summary(mod1)                  

################################
vif(mod1)

mod2 <- lm(WranglerSales ~ WranglerQueries + CPI.Energy,
           data = df.train)
summary(mod2)   
vif(mod2)

mod3 <- lm(WranglerSales ~ WranglerQueries + CPI.Energy + CPI.All,
           data = df.train)
summary(mod3)                  

################################
vif(mod3)

mod4 <- lm(WranglerSales ~ WranglerQueries + CPI.Energy + Unemployment,
           data = df.train)
summary(mod4)                  

################################
vif(mod4)



mod5 <- lm(WranglerSales ~ WranglerQueries + CPI.Energy + MonthFactor, data =
             df.train)
summary(mod5)
vif(mod5)


m = 1
season = c()
for (monthFact in df.train[,c("MonthFactor")]){
  if (monthFact == "January" || monthFact == "February" || monthFact == "December") {
    season[m] = "Winter"
  } else if (monthFact == "March" || monthFact == "April" || monthFact == "May"){
    season[m] = "Spring"
  } else if (monthFact == "June" || monthFact == "July" || monthFact  == "August"){
    season[m] = "Summer"
  } else {
    season[m] = "Fall"
  }
  m = m+1
}
df.train$Seasons <- season

mod6 <- lm(log(WranglerSales) ~ WranglerQueries + CPI.Energy + Seasons, data
           = df.train)
summary(mod6)
vif(mod6)

m = 1
season = c()
for (monthFact in df.train[,c("MonthFactor")]){
  if (monthFact == "March" || monthFact == "April" || monthFact == "May"
   ){
    season[m] = "Spring"
  } else {
    season[m] = "Rest"
  }
  m = m+1
}
df.train$Seasons <- season

mod78 <- lm(WranglerSales ~ WranglerQueries + CPI.All + Seasons, data =
             df.train)
summary(mod78)
vif(mod78)


m = 1
season.test = c()
for (monthFact in df.test[,c("MonthFactor")]){
  if (monthFact == "January" || monthFact == "February" || monthFact ==
      "December") {
    season.test[m] = "Winter"
  } else if (monthFact == "March" || monthFact == "April" || monthFact
             == "May"){
    season.test[m] = "Spring"
  } else if (monthFact == "June" || monthFact == "July" || monthFact ==
             "August"){
    season.test[m] = "Summer"
  } else {
    season.test[m] = "Fall"
  }
  m = m+1
}
df.test$Seasons <- season.test
dfNewPredictions <- predict(mod6, newdata=df.test)
SSE = sum((df.test$LogAuction - dfNewPredictions)^2)
SST = sum((df.test$LogAuction - mean(df.train$LogAuction))^2)
OSR2 = 1 - SSE/SST


