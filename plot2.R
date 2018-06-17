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

# Generating Chart
png("plot2.png", width=480, height=480)
plot(datetime, activePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
