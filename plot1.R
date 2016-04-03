
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

# make the plot, using with function, adding x-axis and title
with(hpcfeb, hist(Global_active_power, col="red", 
                  xlab="Global_active_power (kilowatts)", main = "Global_active_power"))

## copy to file png plot1
dev.copy(png, file= "plot1.png")
dev.off()