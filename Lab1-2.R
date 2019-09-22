# 
# Make sure your working directory was set as "Source file location".
# Make sure your data files are in the same folder as this R script.
#
# Uncomment install.packages if the error message says the package is not found
# install.packages(c("dplyr", "ggplot2", "GGally", "broom"))
library(dplyr)
library(ggplot2)
library(GGally)
#install.packages("car")
library(car) # for VIF

# Load data:
wine <- read.csv("wine_agg.csv") 

str(wine)
head(wine)

# Plot scatter matrix
# density plots on the diagonal and correlation printed in the upper triangle
ggscatmat(wine, columns = 2:9, alpha = 0.8)


# split into training and test sets 

wine.train <- filter(wine, Year <= 1985) 
head(wine.train)
tail(wine.train)
wine.test <- filter(wine, Year > 1985)

# train the model
#lm(y~x1+x2+...,data)
mod1 <- lm(LogAuctionIndex ~ WinterRain + HarvestRain + GrowTemp + HarvestTemp + Age + FrancePop + USAlcConsump, 
           data = wine.train)
summary(mod1)

# compute Out-of-sample R^2 (OSR^2)

winePredictions <- predict(mod1, newdata=wine.test)
# this builds a vector of predicted values on the test set
# SSE = \sum_i (y_i - y_i_pred)^2
# SST = \sum_i (y_i - y_mean)^2
SSE = sum((wine.test$LogAuctionIndex - winePredictions)^2)
SST = sum((wine.test$LogAuctionIndex - mean(wine.train$LogAuctionIndex))^2)
OSR2 = 1 - SSE/SST
OSR2

# Confidence interval plot
ggcoef(
  mod1,
  vline_color = "red",
  vline_linetype =  "solid",
  errorbar_color = "blue",
  errorbar_height = .25,
  exclude_intercept = TRUE
)



################################
# The variance inflation factor (VIF) quantifies the severity of multicollinearity in an ordinary least squares regression analysis.
# It provides an index that measures how much the variance of an estimated regression coefficient is increased because of collinearity.
vif(mod1)

# A better model...
# Remove FrancePop
mod2 <- lm(LogAuctionIndex ~ WinterRain + HarvestRain + GrowTemp + HarvestTemp + Age + USAlcConsump, 
           data = wine.train)
summary(mod2)
vif(mod2)

# Remove USAlcConsump
mod3 <- lm(LogAuctionIndex ~ WinterRain + HarvestRain + GrowTemp + HarvestTemp + Age, 
           data = wine.train)
summary(mod3)
vif(mod3)

# Remove HarvestTemp
mod4 <- lm(LogAuctionIndex ~ WinterRain + HarvestRain + GrowTemp + Age, 
           data = wine.train)
summary(mod4)
vif(mod4)