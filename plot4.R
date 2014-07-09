# Run plot4() function to create the historgram.
# This script extracts data from household_power_consumption.txt
# for the days of 01 & 02 Feb2007 and plots a histogram.

plot4=function(){
#Clean the global environment of all clutter to maximize memory
rm(list=ls())

#Establish directory path for the file househod....txt
Dir.Path=list.files(pattern="house.*\\.txt",recursive=T,include.dirs=T)

# Read the data into r
fpower=read.table(Dir.Path,header=T,colClasses=
                   c(rep("character",2),rep("numeric",7)),sep=";",na="?")
#Extract only for reqd dates of Feb 1,2,2007
fpower=fpower[fpower$Date%in%c("1/2/2007","2/2/2007"),]

# Date and Time col to Date/Time data class
fpower$Time=strptime(paste(fpower$Date,fpower$Time),"%d/%m/%Y %H:%M:%S")
fpower$Date=as.Date(fpower$Date,"%d/%m/%Y")

#Open the png driver and plot histogram
png("plot4.png",width=480,height=480)

par(mfcol=c(2,2))

plot(fpower$Time,fpower$Global_active_power,
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type="l")

plot(fpower$Time,fpower$Sub_metering_1,
     xlab="",
     ylab="Energy sub metering",
     type="l")
lines(fpower$Time,fpower$Sub_metering_2,col="red")
lines(fpower$Time,fpower$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),
                c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

plot(fpower$Time,fpower$Voltage,
     xlab="datetime",
     ylab="Voltage",
     type="l")

plot(fpower$Time,fpower$Global_reactive_power,
     xlab="",
     ylab="Global reactive power",
     type="l")

dev.off()
}