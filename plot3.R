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
with(hpc, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, "plot3.png", height=480, width=480)
dev.off()