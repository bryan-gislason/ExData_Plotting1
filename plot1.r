library(dplyr);

power <- read.table("household_power_consumption.txt", sep=';', header=T, nrow=100, na.strings='?');
classes <- sapply(power, class);
power <- read.table("household_power_consumption.txt", sep=';', header=T, colClasses = classes, na.strings='?');
power$Date <- as.Date(power$Date, format='%d/%m/%Y');

day1 <- as.Date('2007-02-01', format="%Y-%m-%d");
day2 <- as.Date('2007-02-02', format="%Y-%m-%d");

feb2007_01_02 <- filter(power, Date >= day1 & Date <= day2);
Global_active_power <- as.numeric(feb2007_01_02$Global_active_power);
hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)");

dev.copy(png, "plot1.png", height=480, width=480);
dev.off();