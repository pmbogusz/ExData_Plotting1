

# Set working directory - folder with "household_power_consumption.txt" data file
setwd("D:/Coursera/13. Exploratory Data Analysis/Course Project 1")

# readind whole dataset in to dataframe "data_temp"
data_temp <- read.csv("household_power_consumption.txt", sep=";", header = T)

# creating new column with POSIX timestamp based on data_temp$Date and data_temp$Time
# this step is optional (but elegant) since you can filter data based on simple string
# filtering of Date column
data_temp$TimeStamp <- strptime(paste(as.character(data_temp$Date),as.character(data_temp$Time)), format="%d/%m/%Y %H:%M:%S")


# subseting data in to new table "data_power", taking data only 2 days 2007-02-01 and 2007-02-02.
# this will speed up whole processing 
data_power <- data_temp[as.Date(data_temp$TimeStamp) >= as.Date("2007-02-01") & as.Date(data_temp$TimeStamp) < as.Date("2007-02-03"), ]

# convering factors in to numeric values - columns from 3 to 9 will be converted
for( x in 3:9){ 
	data_power[ ,x]  <-as.numeric(as.character(data_power[ ,x]))
}



# Creating plot 2
# 	cex=0 		- no data points. Another way is to create empty plot and use "lines"
# 	xaxt="n" 	- no x axis values
png(filename="plot2.png")
plot(data_power$Global_active_power, type="o", cex=0, ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
axis(1, at=c(0,1440,2880), label=c("Thu","Fri","Sat"))
dev.off()

