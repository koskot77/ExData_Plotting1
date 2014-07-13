if( !file.exists("household_power_consumption.txt") ){
   print("Downloading original data")
   download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
   unzip("household_power_consumption.zip")
}

df <- read.csv(file="household_power_consumption.txt",sep=";",header=T)
df$Date <- as.Date(as.character(df$Date),format="%d/%m/%Y")
nf <- subset(df, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02") )
nf$ts <- strptime(paste( as.character(nf$Date), as.character(nf$Time) ), "%Y-%m-%d %H:%M:%S")
nf$Global_active_power   <- as.numeric(as.character(nf$Global_active_power))
nf$Voltage               <- as.numeric(as.character(nf$Voltage))
nf$Global_reactive_power <- as.numeric(as.character(nf$Global_reactive_power))
nf$Sub_metering_1        <- as.numeric(as.character(nf$Sub_metering_1))
nf$Sub_metering_2        <- as.numeric(as.character(nf$Sub_metering_2))
nf$Sub_metering_3        <- as.numeric(as.character(nf$Sub_metering_3))

par(mfrow=c(2,2))

plot(nf$ts, nf$Global_active_power,"l",ylab="Global Active Power (kilowatts)",xlab="")
plot(nf$ts, nf$Voltage            ,"l",ylab="Voltage",xlab="daytime")

plot(nf$ts, nf$Sub_metering_1,"l",col="black",ylim=c(0,38), ylab="Energy sub metring",xlab="")
par(new = TRUE)
plot(nf$ts, nf$Sub_metering_2,"l",col="red",  ylim=c(0,38), ylab="Energy sub metring",xlab="")
par(new = TRUE)
plot(nf$ts, nf$Sub_metering_3,"l",col="blue", ylim=c(0,38), ylab="Energy sub metring",xlab="")
legend("topright", lty=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(nf$ts, nf$Global_reactive_power,"l",ylab="Global_reactive_power",xlab="daytime")

dev.copy(png,'plot4.png')
dev.off()
