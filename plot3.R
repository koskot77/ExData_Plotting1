if( !file.exists("household_power_consumption.txt") ){
   print("Downloading original data")
   download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
   unzip("household_power_consumption.zip")
}

df <- read.csv(file="household_power_consumption.txt",sep=";",header=T)
df$Date <- as.Date(as.character(df$Date),format="%d/%m/%Y")
nf <- subset(df, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02") )
nf$ts <- strptime(paste( as.character(nf$Date), as.character(nf$Time) ), "%Y-%m-%d %H:%M:%S")
nf$Sub_metering_1 <- as.numeric(as.character(nf$Sub_metering_1))
nf$Sub_metering_2 <- as.numeric(as.character(nf$Sub_metering_2))
nf$Sub_metering_3 <- as.numeric(as.character(nf$Sub_metering_3))

plot(nf$ts, nf$Sub_metering_1,"l",col="black",ylim=c(0,38), ylab="Energy sub metring",xlab="")
par(new = TRUE)
plot(nf$ts, nf$Sub_metering_2,"l",col="red",  ylim=c(0,38), ylab="Energy sub metring",xlab="")
par(new = TRUE)
plot(nf$ts, nf$Sub_metering_3,"l",col="blue", ylim=c(0,38), ylab="Energy sub metring",xlab="")
legend("topright", lty=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,'plot3.png')
dev.off()
