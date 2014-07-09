# Run plot3() function to create the historgram.
# This script extracts data from household_power_consumption.txt
# for the days of 01 & 02 Feb2007 and plots a histogram.

plot3=function(){
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
png("plot3.png",width=480,height=480)

plot(fpower$Time,fpower$Sub_metering_1,
     xlab="",
     ylab="Energy sub metering",
     type="l")
lines(fpower$Time,fpower$Sub_metering_2,col="red")
lines(fpower$Time,fpower$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),
                c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)
dev.off()
}