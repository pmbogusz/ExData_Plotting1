

# Set working directory - folder with "household_power_consumption.txt" data file
setwd("D:/Coursera/13. Exploratory Data Analysis/Course Project 1")

# reading whole dataset in to dataframe "data_temp"
data_temp <- read.csv("household_power_consumption.txt", sep=";", header = T)

# creating new column with POSIX timestamp based on data_temp$Date and data_temp$Time
# this step is optional (but elegant) since you can filter data based on simple string
# filtering of Date column
data_temp$TimeStamp <- strptime(paste(as.character(data_temp$Date),as.character(data_temp$Time)), format="%d/%m/%Y %H:%M:%S")


# subseting data in to new table "data_power", taking data only 2 days 2007-02-01 and 2007-02-02.
# this will speed up whole processing 
data_power <- data_temp[as.Date(data_temp$TimeStamp) >= as.Date("2007-02-01") & as.Date(data_temp$TimeStamp) < as.Date("2007-02-03"), ]

# converting factors in to numeric values - columns from 3 to 9 will be converted
for( x in 3:9){ 
	data_power[ ,x]  <-as.numeric(as.character(data_power[ ,x]))
}


# Creating plot 4
png(filename="plot4.png")
par(mfrow = c(2, 2))

# Panel 1
plot(data_power$Global_active_power, type="o", cex=0, ylab="Global Active Power", xlab="", xaxt="n")
axis(1, at=c(0,1440,2880), label=c("Thu","Fri","Sat"))

# Panel 2
plot(data_power$Voltage, type="o", cex=0, ylab="Voltage", xlab="datetime", xaxt="n")
axis(1, at=c(0,1440,2880), label=c("Thu","Fri","Sat"))

# Panel 3
# 	bty='n'		- remove box from legend
# 	cex=.85   	- smaller font
plot(data_power$Sub_metering_1, type="o", cex=0, ylab="Energy sub metering", xlab="", xaxt="n",  col="black")
lines(data_power$Sub_metering_2,  col="red")
lines(data_power$Sub_metering_3,  col="blue")
axis(1, at=c(0,1440,2880), label=c("Thu","Fri","Sat"))
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "blue", "red"), lty=c(1:1), bty='n', cex=.85);

# Panel 4
plot(data_power$Global_reactive_power, type="o", cex=0, ylab="Global_reactive_power", xlab="datetime", xaxt="n")
axis(1, at=c(0,1440,2880), label=c("Thu","Fri","Sat"))

dev.off()

