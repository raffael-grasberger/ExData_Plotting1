data <- read.csv("household_power_consumption.txt", sep=";", dec = ".", stringsAsFactors = FALSE)
data$DateTime <- sprintf("%s %s", data$Date, data$Time) 
data$DateTime <- strptime(data$DateTime, format="%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)

data <- subset(data, 
               data$DateTime >= as.POSIXlt(strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")) &
               data$DateTime <= as.POSIXlt(strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S")))

png("plot2.png", width = 480, height = 480)

plot(x = data$DateTime, 
     y = data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

dev.off()
