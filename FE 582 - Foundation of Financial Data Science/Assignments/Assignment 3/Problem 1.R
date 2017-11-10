# Environment Setup#
rm(list = ls())
setwd("E:/FE Assignment/") 

# Read data (downloaded from yahoo)
# URLs: 
#   PEP: https://finance.yahoo.com/quote/PEP/history?period1=1167627600&period2=1509854400&interval=1d&filter=history&frequency=1d
#   KO:  https://finance.yahoo.com/quote/KO/history?period1=1167627600&period2=1509854400&interval=1d&filter=history&frequency=1d
#   DPS: https://finance.yahoo.com/quote/DPS/history?period1=1167627600&period2=1509854400&interval=1d&filter=history&frequency=1d
pepData <- read.table(file="PEP.CSV", header = TRUE, sep = ",")
koData <- read.table(file="KO.CSV", header = TRUE, sep = ",")
dpsData <- read.table(file="DPS.CSV", header = TRUE, sep = ",")

head(pepData)
head(koData)
head(dpsData)

# Loaded data summary
summary(pepData)
pepData$Date = as.Date(pepData$Date)
summary(pepData)

summary(koData)
koData$Date = as.Date(koData$Date)
summary(koData)

summary(dpsData)
dpsData$Date = as.Date(dpsData$Date)
summary(dpsData)

# Combine stocks
formStocksPair = function(df1, df2, stockNames = c(deparse(substitute(df1)), 
                                                   deparse(substitute(df2)))) {
  inter = intersect(df1$Date, df2$Date)
  df1.sub = df1[which(df1$Date %in% inter), ]
  df2.sub = df2[which(df2$Date %in% inter), ]
  structure(data.frame(Date = as.Date(df1.sub$Date), 
                       df1.sub$Adj.Close, 
                       df2.sub$Adj.Close), 
            names = c("Date", stockNames))
}

# 
nextTrade = function(pair, k = 1, start = 1) {
  mpairs = mean(pair)
  sdpairs = sd(pair)
  if (start > 1) {
    pair <- pair[-(1:start - 1)]
  }
  upperband = mpairs + k * sdpairs
  lowerband = mpairs - k * sdpairs
  meanupband = pair > mpairs
  meandownband = pair < mpairs
  conditionsSatisfied = pair > upperband | pair < lowerband
  if (!any(conditionsSatisfied)) {
    return(NA)
  }
  tstart = which(conditionsSatisfied)[1]
  temppair = pair > mpairs | pair < mpairs
  if (pair[tstart] > mpairs) {
    tend = which(!meanupband[tstart:length(meanupband)])[1] +
      tstart
  } else {
    tend = which(!meandownband[tstart:length(meandownband)])[1] +
      tstart
  }
  if (is.na(tend)) {
    tend = length(pair)
  }
  return(c(tstart, tend) + (start - 1))
}

tradePoints = function(pair, k = 1) {
  options(warn = -1)
  start = 1
  tpoint = data.frame(Start = integer(), End = integer())
  while (start < length(pair)) {
    temp = nextTrade(pair, k, start)
    if (is.na(temp)) {
      break
    }
    tpoint = rbind(tpoint, temp)
    start = temp[2]
  }
  names(tpoint) = c("Start", "End")
  options(warn = 0)
  return(tpoint)
}

plotPos = function(stk1, stk2, k = 1, title = c(deparse(substitute(stk1)), deparse(substitute(stk2)))) {
  title = paste(paste(title, collapse = " "), "pair", sep = " ")
  stk1stk2 = formStocksPair(stk1, stk2)
  pair = stk1stk2$stk1/stk1stk2$stk2
  mpairs = mean(pair)
  sdpairs = sd(pair)
  plot(stk1stk2$Date, pair, type = "l", col = "grey", ylab = "Price Ration",
       xlab = "Date", main = title)
  abline(h = c(mpairs, mpairs + k * sdpairs, mpairs - k * sdpairs),
         col = c("darkgreen", rep("red", 2 * length(k))), lty = 2)
  tpoints = tradePoints(pair, k)
  invisible(lapply(tpoints$Start, function(x) showPosition(stk1stk2$Date[x],
                                                           pair[x])))
  invisible(lapply(tpoints$End, function(x) showPosition(stk1stk2$Date[x],
                                                         pair[x], fg = "red")))
}

showPosition = function(x, y, fg = "green") {
  symbols(x, y, fg = fg, circles = 30, add = TRUE, inches = FALSE,
          bg = fg)
}

pofPostion = function(position, pair, stk1stk2, c = 0.01) {
  if (is.data.frame(position)) {
    position = as.vector(as.matrix(position))
  }
  mpair = mean(pair)
  trade = if (pair[position[1]] > mpair) {
    1
  } else {
    0
  }
  unitstk1 <- 1/stk1stk2$stk1[position[1]]
  unitstk2 <- 1/stk1stk2$stk2[position[1]]
  amt <- sum(unitstk1 * stk1stk2$stk1[position[2]], unitstk2 *
               stk1stk2$stk2[position[2]])
  if (trade == 1) {
    prof <- sum(c(1 - unitstk1 * stk1stk2$stk1[position[2]],
                  unitstk2 * stk1stk2$stk2[position[2]] - 1, -1 * c *
                    amt))
  } else {
    prof <- sum(c(unitstk1 * stk1stk2$stk1[position[2]] -
                    1, 1 - unitstk2 * stk1stk2$stk2[position[2]], -1 *
                    c * amt))
  }
  return(c(prof))
}

calTotalProfit <- function(stk1, stk2, k = 1, c = 0.01) {
  stk1stk2 <- formStocksPair(stk1, stk2)
  pair <- stk1stk2$stk1/stk1stk2$stk2
  mpairs <- mean(pair)
  sdpairs <- sd(pair)
  tpoints <- tradePoints(pair, k)
  tprofits <- vector()
  for (i in 1:nrow(tpoints)) {
    tprofits <- c(tprofits, pofPostion(tpoints[i, ], pair, stk1stk2, c = c))
  }
  return(tprofits)
}

# Adjusting for stock split of 1:2 in coke before August 10,
k <- 1
commision <- 0.010

# For pepsico, coke pair
plotPos(pepData, koData, k, title = "Pepsico and Coke")
calTotalProfit(pepData, koData, k = k, c = commision) #Profit

# For pepsico, dr pepper pair
plotPos(pepData, dpsData, k, title = "Pepsico and Dr Pepper")
calTotalProfit(pepData, dpsData, k = k, c = commision) #Profit

# For coke, dr pepper pair
plotPos(koData, dpsData, k, title = "Coke and Dr Pepper")
calTotalProfit(koData, dpsData, k = k, c = commision) #Profit
