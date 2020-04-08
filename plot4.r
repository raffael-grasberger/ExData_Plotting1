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

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

plot(x = data$DateTime, 
     y = data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")

plot(x = data$DateTime, 
     y = data$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

plot(x = data$DateTime, 
     y = data$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend(legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), x = "topright",
       col = c("black", "red", "blue"), lty = 1, bty = "n")

plot(x = data$DateTime, 
     y = data$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()
