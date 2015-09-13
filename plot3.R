library(data.table)
library(dplyr)
library(stringr)
setwd("~/Documents/OneDrive/DataSci/ExData")

# [IMPORTANT:PLEASE READ] Step1: you can start here to read the original data into R and re-subset 
#the data for Feb1 and 2, 2007 from partial script lines in plot1.R". Or you can directly go to step 2 
#and read the subset data, which has been is a result of plot1.R script and saved in the working directory. 
#Starting with Step 2 will prevent you from loading the orginal data multiple times.

sourcePartial <- function(fn,startTag='#from here',endTag='#to here') {
        lines <- scan(fn, what=character(), sep="\n", quiet=TRUE)
        st<-grep(startTag,lines)
        en<-grep(endTag,lines)
        tc <- textConnection(lines[(st+1):(en-1)])
        source(tc)
        close(tc)
}

sourcePartial("ExData_Plotting1/plot1.R", "#from here", "#to here")

#Step 2: Reading subset data (that is saved) in your working directory. This subset data is a result 
#of plot1.R or step1 obove.

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
