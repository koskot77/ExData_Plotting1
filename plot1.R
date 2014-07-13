if( !file.exists("household_power_consumption.txt") ){
   print("Downloading original data")
   download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
   unzip("household_power_consumption.zip")
}

df <- read.csv(file="household_power_consumption.txt",sep=";",header=T)
df$Date <- as.Date(as.character(df$Date),format="%d/%m/%Y")
nf <- subset(df, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02") )
nf$ts <- strptime(paste( as.character(nf$Date), as.character(nf$Time) ), "%Y-%m-%d %H:%M:%S")
nf$Global_active_power <- as.numeric(as.character(nf$Global_active_power))

hist(nf$Global_active_power, main = "Global Active Power", breaks=20, col="red", xlab="Global Active Power (kilowatts)")

dev.copy(png,'plot1.png')
dev.off()
