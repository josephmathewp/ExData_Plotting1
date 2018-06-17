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

subMetering1 <- as.numeric(dataSubset$Sub_metering_1)
subMetering2 <- as.numeric(dataSubset$Sub_metering_2)
subMetering3 <- as.numeric(dataSubset$Sub_metering_3)

# Generating Chart
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()