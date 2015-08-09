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

par(mfrow = c(2,2))

plot(feb2007_01_02$timestamp, feb2007_01_02$Global_active_power, lty="solid", type='l', xlab="", ylab="Global Active Power (kilowatts)");
plot(feb2007_01_02$timestamp, feb2007_01_02$Voltage, lty="solid", type='l', xlab="datetime", ylab="Voltage");

sub_metering <- select(feb2007_01_02, Sub_metering_1, Sub_metering_2, Sub_metering_3, timestamp);

with(sub_metering, plot(sub_metering$timestamp, sub_metering$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", main=""))
points(sub_metering$timestamp, sub_metering$Sub_metering_2, col="red",  type="l")
points(sub_metering$timestamp, sub_metering$Sub_metering_3, col="blue",  type="l")
legend("topright", lty="solid", col=c("black", "red", "blue"), legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"))

plot(feb2007_01_02$timestamp, feb2007_01_02$Global_reactive_power, lty="solid", type='l', xlab="datetime", ylab="Global_reactive_power");

dev.copy(png, "plot4.png", height=480, width=480);
dev.off();