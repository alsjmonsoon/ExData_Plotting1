library(data.table)
library(dplyr)
library(stringr)
setwd("~/Documents/OneDrive/DataSci/ExData")

#a function here to read partial line from plot1.R"
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

lapply(power07,class)
power07$Dates<-strptime(power07$Dates,"%Y-%m-%d %H:%M:%S")
png(filename = "Plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,bg="white")
Plot2<-plot(power07$Dates,power07$Global_active_power,type="l",ylab="Global Active Power (Kilowatts)",xlab="")
dev.off() 


