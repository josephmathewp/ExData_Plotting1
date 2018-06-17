## Downloading and Unzipping of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./PowerData.zip")){download.file(fileUrl,destfile="./PowerData.zip",method="curl")}
unzip(zipfile="./PowerData.zip",exdir="./PowerData")

## Preparing data
dataFilePath <- "./PowerData/household_power_consumption.txt"
powerData <- read.table(dataFilePath ,header = TRUE, sep = ";")
powerData$Date <-as.Date(powerData$Date, format='%d/%m/%Y')
dataSubset <- powerData[powerData$Date %in%  as.Date(c('2007-02-01','2007-02-02')), ]
remove(powerData)

## Getting the plot
png("plot1.png", width=480, height=480)
hist(as.numeric(as.character(dataSubset[,3])),xlab="Global Active Power(Kilowatts))",col = "red",main = "Global Active Power")
dev.off()