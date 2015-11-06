##Unzip files
unzip("exdata-data-household_power_consumption.zip" )

## Read data
data<-read.csv("household_power_consumption.txt", sep = ";", quote = "", na = "?")

##Add new column "datetime" in "POSIXlt" format
data$datetime=strptime(as.character(paste(data$Date, data$Time)), format = "%d/%m/%Y %H:%M:%S")

##Extract data only from the dates 2007-02-01 and 2007-02-02
d<-rbind(data[data$Date=="1/2/2007",], data[data$Date=="2/2/2007",])

##Create plot
plot(x = d$datetime, y = d$Sub_metering_1, type = "l", xlab = "", ylab ="Energy sub metering")
lines(x = d$datetime, y = d$Sub_metering_2, col = "red")
lines(x = d$datetime, y = d$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col = c("black", "red", "blue"))
