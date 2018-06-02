hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc <- subset(hpc, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
hpc <- hpc[complete.cases(hpc),]
dateTime <- paste(hpc$Date, hpc$Time)
dateTime <- setNames(dateTime, "DateTime")
hpc <- hpc[ ,!(names(hpc) %in% c("Date","Time"))]
hpc <- cbind(dateTime, hpc)
hpc$dateTime <- as.POSIXct(dateTime)
### building of first plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(hpc, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png, "plot4.png", height=480, width=480)
dev.off()