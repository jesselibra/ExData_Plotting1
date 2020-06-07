
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


##plot4
png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))
  #plot2
  plot(dataset$datetime,dataset$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "",)

  #voltage
  plot(dataset$datetime,dataset$Voltage, type = "l", ylab = "Voltage", xlab = "datetime",)

  #plot3
  plot(dataset$datetime,dataset$Sub_metering_1, type = "l", ylab = "Energy submetering", xlab = "",col = "black")
  points(dataset$datetime,dataset$Sub_metering_2, type = "l",  col ="red")
  points(dataset$datetime,dataset$Sub_metering_3, type = "l", col = "blue")
  legend("topright",c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

  #global reactive power
  plot(dataset$datetime,dataset$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime",)



dev.off()