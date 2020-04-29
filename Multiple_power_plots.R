

par(mfrow=c(2,2))

#Global active power by hour

with(feb_data, {
  plot(Date, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
  lines(Date, Global_active_power)
  plot(Date, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  plot(Date, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
  lines(feb_data$Date, feb_data$Sub_metering_2, col = "red")
 
  lines(feb_data$Date, feb_data$Sub_metering_3, col = "blue")
  legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), bty = "n", cex = 0.5,  bg = "transparent", lty = c(1,1), lwd=c(2.5,2.5),col=c("black", "blue", "red"))
 plot(Date, Global_reactive_power, type = "l")
})

dev.copy(png, file ="Multiple_power_plots")
dev.off()
