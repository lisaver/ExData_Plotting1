
## load file into R and change name dataframe
household_power_consumption <- read.csv("~/cursussen/R/exploring data/exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", na.strings="?")
hpc <- household_power_consumption

## change of date and time factors into date with strptime and as.Date
hpc$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
hpc$DateTime <- paste(household_power_consumption$Date, household_power_consumption$Time)
hpc$DateTime <- strptime(hpc$DateTime, "%d/%m/%Y %H:%M:%S")

## subsetting 2 days of Feb 2007
hpcfeb1 <- subset(hpc, hpc$Date=="2007-02-01") 
hpcfeb2 <- subset(hpc, hpc$Date=="2007-02-02")
hpcfeb <- rbind(hpcfeb1, hpcfeb2)

# set language in the plot to english instead of dutch
Sys.setlocale(category = "LC_ALL", locale = "english")

# make 4 plots in one.
par(mar=c(5,4,4,2))
par(mfrow=c(2,2))

# make graph without data and adding content line of plot2
with(hpcfeb, plot(DateTime, Global_active_power, type = "n", xlab="" , ylab="Global active power"))
with(hpcfeb, lines(DateTime,Global_active_power,type = "l"))

# graph upper right, datetime and voltage
with(hpcfeb, plot(DateTime, Voltage, type = "n"))
with(hpcfeb, lines(DateTime,Voltage,type = "l"))

# graph lower left, plot3
with(hpcfeb, plot(DateTime, Sub_metering_1, type = "n", xlab="" , ylab="Energy sub metering"))
lines(hpcfeb$DateTime, hpcfeb$Sub_metering_1, type = "l", col= "black")
lines(hpcfeb$DateTime, hpcfeb$Sub_metering_2, type = "l", col= "red")
lines(hpcfeb$DateTime, hpcfeb$Sub_metering_3, type = "l", col= "blue")
legend("topright", lwd=c(0.5,0.5,0.5), cex = 0.7, bty="n", x.intersp = 1.5, adj = c(0.15, 0.25), col=c("black", "blue","red"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# graph lower right, datetime and global reactive power
with(hpcfeb, plot(DateTime, Global_reactive_power, type = "n"))
with(hpcfeb, lines(DateTime,Global_reactive_power,type = "l"))

## copy to file png plot4
dev.copy(png, file= "plot4.png")
dev.off()
