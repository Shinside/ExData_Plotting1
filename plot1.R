## Required dataset: "Electric power consumption" downloaded from here => 
## https://class.coursera.org/exdata-034/human_grading/view/courses/975129/assessments/3/submissions
## 
## This script plots a histogram of Global Active Power for the observations within
## two days:  2007-02-01 and 2007-02-02

plot1<-function(){
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
# Plot and export picture
        plotpath <- file.path(getwd(),"plot1.png")
        with(WorkingData, {
                png(file=plotpath, width = 480, height = 480, bg="transparent")
                hist(Global_active_power,col=2,main="Global Active Power",
                     xlab="Global Active Power(kilowatts)")
                dev.off()
        })
#-------------------------------------------------------------------------------
}