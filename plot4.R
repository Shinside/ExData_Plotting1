## Required dataset: "Electric power consumption" downloaded from here => 
## https://class.coursera.org/exdata-034/human_grading/view/courses/975129/assessments/3/submissions
## 
## This script plots several timeseries for the observations within
## two days:  2007-02-01 and 2007-02-02, specifying the day of the week

plot4<-function(){
        Sys.setlocale("LC_TIME", "C") # this is to override automatic change to Russia

# Read required subset (assuming full dataset on your hard drive)        
        DataPath <- file.path('c:','_My folder','stuff','Data','Coursera',
                              '04 - Exploratory data', 'Week 1', 'Project 1',
                                'household_power_consumption.txt')
        StartRow <- grep("1/2/2007;00:00:00", readLines(DataPath))[1]
        EndRow <- grep("2/2/2007;23:59:00", readLines(DataPath))[1]
        WorkingData <- read.table(DataPath,skip=(StartRow-1) ,
                                  nrows=(EndRow-StartRow+1),na.strings="?",sep=";")
        names(WorkingData)<-c("Date","Time", "Global_active_power",
                              "Global_reactive_power", "Voltage",
                              "Global_intensity", "Sub_metering_1",
                              "Sub_metering_2", "Sub_metering_3")
#-------------------------------------------------------------------------------
# Make adjustments to Date and Time and append DateTime column of POSIXlt type
        WorkingData$Date<-as.character(WorkingData$Date)
        WorkingData$Date<-sub("1/","01/",WorkingData$Date)
        WorkingData$Date<-sub("2/","02/",WorkingData$Date)
        WorkingData$Time<-as.character(WorkingData$Time)
        WorkingData<-cbind(WorkingData,DateTime=paste(WorkingData$Date,
                                                      WorkingData$Time,sep=" "))
        WorkingData$DateTime<-as.character(WorkingData$DateTime)
        WorkingData$DateTime<-strptime(WorkingData$DateTime,"%d/%m/%Y %H:%M:%S")
#-------------------------------------------------------------------------------
# Plot and export picture
        plotpath <- file.path(getwd(),"plot4.png")        
        png(file=plotpath, width = 480, height = 480, bg="transparent")
        par(mfrow=c(2,2),oma=c(0,0,0,0),mar=c(4,4,4,2))
        
        #plot 1st chart
        with(WorkingData, {
                plot(DateTime, Global_active_power,type="l",
                     ylab = "Global Active Power",xlab="")
        })
        
        #plot 2d chart
        with(WorkingData, {
                plot(DateTime, Voltage,type="l",
                     ylab = "Voltage",xlab="datetime")
        })
        
        #plot 3d chart
        with(WorkingData, {
                plot(DateTime, Sub_metering_1,type="n",
                        ylab = "Energy sub metering",xlab="")
                points(DateTime, Sub_metering_1,type="l",col="black")
                points(DateTime, Sub_metering_2,type="l",col="red")
                points(DateTime, Sub_metering_3,type="l",col="blue")
        })
        legend("topright",lty=1,col=c("black","red","blue"),bty="n",
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        #plot 4th chart
        with(WorkingData, {
                plot(DateTime, Global_reactive_power,type="l",
                     xlab="datetime")
        })
        
        dev.off()
#-------------------------------------------------------------------------------
}