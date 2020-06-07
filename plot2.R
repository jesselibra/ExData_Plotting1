## Load dataset and packages
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
path <- "./data/project.zip"

  download.file(url,path,method="curl")
  unzip("./data/project.zip", exdir = "./data")
  library(lubridate)
  library(dplyr)
  library(stringr)

## clean dataset
  dataset <- tibble(read.table("./data/household_power_consumption.txt", header= TRUE, sep = ';'))
  dataset$Date <- dmy(dataset$Date)
  dataset <- dataset %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02")
  dataset$datetime <- as.POSIXct(paste(dataset$Date, dataset$Time), format="%Y-%m-%d %H:%M:%S")
  dataset[3:8] <- sapply(dataset[3:8],as.numeric)



##plot2 (week abbreviations are in Spanish)
png("plot2.png", width=480, height=480)
par(mfrow = c(1,1))
  plot(dataset$datetime,dataset$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "",)


dev.off()