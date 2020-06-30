## Check for necessary dataset
if (!file.exists("./household_power_consumption.txt")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, destfile = "./household_power_consumption.zip")
        unzip("./household_power_consumption.zip")
}

## Filter the dataset by dates and times and convert them to POSIXct
library(data.table)
power <- fread("./household_power_consumption.txt", na.strings = "?")
power <- rbind(power[Date == "1/2/2007", ], power[Date == "2/2/2007", ])
power$dateTime <- as.POSIXct(paste(power$Date, power$Time), 
                             format = "%d/%m/%Y %H:%M:%S")

## Plot line graph on .png file
png("plot2.png", width = 480, height = 480)
plot(x = power$dateTime, y = power$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()