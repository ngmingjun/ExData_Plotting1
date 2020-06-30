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

## Plot the line graphs in .png file
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

## Graph 1
plot(x = power$dateTime, y = power$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power")

## Graph 2
plot(x = power$dateTime, y = power$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")

## Graph 3
plot(x = power$dateTime, y = power$Sub_metering_1, type = "l", 
     col = "black", xlab = "", ylab = "Energy sub metering")
points(x = power$dateTime, y = power$Sub_metering_2, col = "red", type = "l")
points(x = power$dateTime, y = power$Sub_metering_3, col = "blue", type = "l")
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Graph 4
plot(x = power$dateTime, y = power$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()