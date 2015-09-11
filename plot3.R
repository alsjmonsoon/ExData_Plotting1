library(data.table)
library(dplyr)
library(stringr)
setwd("~/Documents/OneDrive/DataSci/ExData")

#contruct a function sourcePartial() here to read partial line from plot1.R to read the file in.
sourcePartial <- function(fn,startTag='#from here',endTag='#to here') {
        lines <- scan(fn, what=character(), sep="\n", quiet=TRUE)
        st<-grep(startTag,lines)
        en<-grep(endTag,lines)
        tc <- textConnection(lines[(st+1):(en-1)])
        source(tc)
        close(tc)
}

sourcePartial("ExData_Plotting1/plot1.R", "#from here", "#to here")

#Reading subset data.

power07<-read.table("finalDT.txt",header=TRUE,sep=",", stringsAsFactors=FALSE,check.names=FALSE)

#convert 'Dates' variable from character to POSIXlt

power07$Dates<-strptime(power07$Dates,"%Y-%m-%d %H:%M:%S")

# making `Plot.3`
png(filename = "Plot3.png",
    width = 480, height = 480, units = "px",bg="white")
with(power07,plot(Dates, Sub_metering_1,type="l",ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)), col="black",ylab="Engergy sub metering", xlab=""))
with(power07,lines(Dates, Sub_metering_2,type="l", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)), col="red"))
with(power07,lines(Dates, Sub_metering_3,type="l", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)), col="blue"))
legend("topright", lty=1,col = c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off() # turn of png device and the figure is save in the directory
