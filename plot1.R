#load packages

library(data.table)
library(dplyr)
library(stringr)

# set working directory to where the orgiinal data "powerConsumption" is...
setwd("~/Documents/OneDrive/DataSci/ExData")

# Read the data use 'fread()'.#fread is good for if all variables have the same numbers of observations
#and it automatically detect sep and quote.
#from here
system.time(DT<-fread("powerConsumption.txt", 
                      header=TRUE,
                      na.strings="?",
                      stringsAsFactors=FALSE,
                      colClasses=list(character=1:9)))
# estimated time is [user  system elapsed 
                #  2.775   0.186   3.042] 
                          
## subset the two dates that we are interested in
feb2007<-filter(DT, Date=="1/2/2007"|Date=="2/2/2007") 

## set the subset data as a dataframe for later data manupilation.
feb2007<-as.data.frame(feb2007)

#set the variable "Date" from character to 'Date' vector
feb2007$Date<-as.Date(feb2007$Date,"%d/%m/%Y")

#combine the 'Date' and 'Time' column use paste(), as a result, generate a new variable called"Dates" 
feb2007$Dates<-paste(feb2007$Date,feb2007$Time,"")

# remove the "Date" and "Time" Columns because  I just created a new column called "Dates" 
feb2007new<-select(feb2007,-c(Date,Time))
feb2007final<-select(feb2007new,Dates,everything()) #move the variable "Dates" from last to the first column 

## convert column 2-8 from character to numeric vectors

namelist<-colnames(feb2007final)[-1] # get a name list for variable 2 -8.
feb2007final[namelist]<-sapply(feb2007final[namelist],as.numeric) # convert to variable 2-8 from character to numeric class.
str(feb2007final) # check the dataframe

# set the dates column as POSIXLt 
feb2007final$Dates<-strptime(feb2007final$Dates,"%Y-%m-%d %H:%M:%S")

# write a data table and save on your working directory. This subset data will be used for making plots 2,3,and 4.
write.table(feb2007final,file="finalDT.txt",quote=FALSE, sep=",",row.names=FALSE,col.names=TRUE)

#to here

#generate Plot1 and save it to a specific folder
png(filename = "Plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,bg="white")
plot1<-hist(feb2007final$Global_active_power, col="red",
     main="Global Active Power",
     xlab="Global Active Power(Kilowatts)",
     ylab="Frequency")
dev.off() ## close the PNG device!




