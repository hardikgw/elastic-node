wtd <- read.table(
  file = "WaitTimesPerDay.csv",
  header = TRUE,
  sep = ","
)

wth <- read.table(
  file = "WaitTimesPerHour.csv",
  header = TRUE,
  sep = ","
)

wtd$Date <- as.Date(wtd$Date, format = "%m/%d/%y")
wth$Date <- as.Date(wth$Date, format = "%m/%d/%y")