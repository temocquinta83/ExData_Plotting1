### Read required data for dates 2007-02-01 to 2007-02-02
### The dates in the file appear in format d/M/yyyy

### Using the functions grep and readLines, find the first line on the date 2007-02-01
### Because the file contains a header, skip the first found line minus 1
### Use the nrows to read 2 days of data
data <- read.table("household_power_consumption.txt", skip=grep("1/2/2007", readLines("household_power_consumption.txt"))[1]-1, header = FALSE, sep =";", nrows=60*24*2, col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

### Add Datetime column to dataframe
data <- transform(data, Datetime = strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

### Set Charting Layout
par(mfcol = c(1,1))

### Plot Sequence
with(data, plot(Datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(Datetime, Sub_metering_2, col="red"))
with(data, lines(Datetime, Sub_metering_3, col="blue"))
legend("topright", lwd=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

### Save to PNG
dev.copy(png, "plot3.png")
dev.off()
