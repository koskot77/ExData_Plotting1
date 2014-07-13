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

plot(nf$ts, nf$Global_active_power,"l",ylab="Global Active Power (kilowatts)",xlab="")

dev.copy(png,'plot2.png')
dev.off()
