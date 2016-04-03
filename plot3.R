
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

# make graph without data
with(hpcfeb, plot(DateTime, Sub_metering_1, type = "n", xlab="" , ylab="Energy sub metering"))

# content added. 
lines(hpcfeb$DateTime, hpcfeb$Sub_metering_1, type = "l", col= "black")
lines(hpcfeb$DateTime, hpcfeb$Sub_metering_2, type = "l", col= "red")
lines(hpcfeb$DateTime, hpcfeb$Sub_metering_3, type = "l", col= "blue")

# adding the legend
legend("topright", lwd=c(1,1,1), col=c("black", "blue","red"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), x.intersp = 2.0, adj = c(0.15, 0.5))

## copy to file png plot3
dev.copy(png, file= "plot3.png")
dev.off()
