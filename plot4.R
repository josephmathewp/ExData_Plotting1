## Downloading and Unzipping of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./PowerData.zip")){download.file(fileUrl,destfile="./PowerData.zip",method="curl")}
unzip(zipfile="./PowerData.zip",exdir="./PowerData")

## Preparing data
dataFilePath <- "./PowerData/household_power_consumption.txt"
powerData <- read.table(dataFilePath, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
dataSubset <- powerData[powerData$Date %in% c("1/2/2007","2/2/2007") ,]
remove(powerData)

datetime <- strptime(paste(dataSubset$Date, dataSubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
activePower <- as.numeric(dataSubset$Global_active_power)
reactivePower <- as.numeric(dataSubset$Global_reactive_power)
voltage <- as.numeric(dataSubset$Voltage)

subMetering1 <- as.numeric(dataSubset$Sub_metering_1)
subMetering2 <- as.numeric(dataSubset$Sub_metering_2)
subMetering3 <- as.numeric(dataSubset$Sub_metering_3)

# Generating Chart
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

plot(datetime, activePower, type="l", xlab="", ylab="Global Active Power")

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", cex=0.9, lty = 1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(datetime, reactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()