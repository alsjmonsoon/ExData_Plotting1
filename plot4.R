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

#Step 2: Reading subset data (that is saved) in your working directory. This subset data is a result of 
#plot1.R or step1 obove.

power07<-read.table("finalDT.txt",header=TRUE,sep=",", stringsAsFactors=FALSE,check.names=FALSE)
power07$dates<-strptime(power07$dates,"%Y-%m-%d %H:%M:%S")

## set up mutilple plots in two row by two column configuration


## create the four plots on a png device
# open the png device
png(filename = "Plot4.png",
    width = 480, height = 480, units = "px",bg="white")

# create four plots as instructed
par(mfcol=c(2,2)) 

#plot top-left graph
with(power07,
plot(Dates,Global_active_power,type="l",ylab="Global Active Power (Kilowatts)",xlab=""))

#plot top-bottom graph
with(power07,plot(Dates, Sub_metering_1,type="l",ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)), col="black",ylab="Engergy sub metering", xlab=""))
par(new=TRUE) # this can be included or excluded, the outcome is the same
with(power07,lines(Dates, Sub_metering_2,type="l", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)), col="red"))
par(new=TRUE)  # this can be included or excluded, the outcome is the same
with(power07,lines(Dates, Sub_metering_3,type="l", ylim=range(c(Sub_metering_1,Sub_metering_2, Sub_metering_3)), col="blue"))
legend("topright", lty=1,col = c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),bty="n",cex=0.9,pt.cex=1)

#plot top-right graph
with(power07,plot(Dates,Voltage, type="l",ylab="Voltage",xlab="datetime"))

#plot top-bottom graph
with(power07,plot(Dates,Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime"))

dev.off() # turn off the png device
