library(dplyr);

power <- read.table("household_power_consumption.txt", sep=';', header=T, nrow=100, na.strings='?');
classes <- sapply(power, class);
power <- read.table("household_power_consumption.txt", sep=';', header=T, colClasses = classes, na.strings='?');
power$Date <- as.Date(power$Date, format='%d/%m/%Y');

day1 <- as.Date('2007-02-01', format="%Y-%m-%d");
day2 <- as.Date('2007-02-02', format="%Y-%m-%d");

feb2007_01_02 <- filter(power, Date >= day1 & Date <= day2);

feb2007_01_02 <- mutate(feb2007_01_02, timestamp=paste(Date, Time))
feb2007_01_02$timestamp <- strptime(feb2007_01_02$timestamp, format="%Y-%m-%d %H:%M:%S")
feb2007_01_02$Global_active_power <- as.numeric(feb2007_01_02$Global_active_power);
##feb2007_01_02$Time <- strptime(feb2007_01_02$Time, format="%H:%M:%S");

plot(feb2007_01_02$timestamp, feb2007_01_02$Global_active_power, lty="solid", type='l', xlab="", ylab="Global Active Power (kilowatts)");

dev.copy(png, "plot2.png", height=480, width=480);
dev.off();