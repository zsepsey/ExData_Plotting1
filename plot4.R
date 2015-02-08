plot4 <- function() {
  downlaodAndUncompressZip("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                           "./householdPowerConsumption.zip", 
                           "./PowerConsumption")
  
  ppdata <- read.table("./household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", as.is=TRUE)
  
  # Subset data to select the desired dates
  ppdata[,1] <- as.Date(as.character(ppdata[,1]), "%d/%m/%Y")
  ppdata <- subset(ppdata, ppdata[,1] >= as.Date("01-02-2007", "%d-%m-%Y") & ppdata[,1] <= as.Date("02-02-2007","%d-%m-%Y"))
  
  # Create date-time data in the first column
  ppdata[,1] <- paste(ppdata[,1], ppdata[,2], sep=" ")
  
  png("plot4.png")
  par(mfrow = c(2, 2))
  # plot1 (= plot2)
  plot(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Global_active_power, type="l",
       xlab="", ylab="Global Active power (kilowatts)") 
  # plot2
  plot(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Voltage, type="l",
       xlab="datetime", ylab="Voltage")
  #plot3
  plot(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Sub_metering_1, type="n", ylim=c(0,40),
       xlab="", ylab="Energy Sub Metering (kilowatts)")
  lines(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Sub_metering_1, type="l", col="black", 
        xlab="", ylab="Energy Sub Metering (kilowatts)")
  
  par(new=TRUE)
  plot(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Sub_metering_2, type="n", ylim=c(0,40),
             xlab="", ylab="Energy Sub Metering (kilowatts)")
  lines(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Sub_metering_2, type="l", col="red",
        xlab="", ylab="Energy Sub Metering (kilowatts)")
  
  par(new=TRUE)
  plot(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Sub_metering_3, type="n", ylim=c(0,40),
       xlab="", ylab="Energy Sub Metering (kilowatts)")
  lines(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Sub_metering_3, type="l", col="blue",
        xlab="", ylab="Energy Sub Metering (kilowatts)")
  
  par(new=TRUE)
  legend('topright', c("Sub_metering_1","Sub_metering_2", "Sub_metering_3") , 
         lty=1, col=c('black', 'red', 'blue'), bty='n')
  
  #plot4
  plot(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Global_reactive_power, type="l",
       xlab="datetime", ylab="Global reactive power (kilowatts)") 
   
  # create PNG
  dev.off()
}

# download zip file from a URL and uncompress in a given directory??
downlaodAndUncompressZip <- function(fileURL, dataFileZIP, dir) {
  # Download the dataset (. ZIP), which does not exist
  if (file.exists(dataFileZIP) == FALSE) {
    download.file(fileURL, destfile = dataFileZIP, method="curl")
  }
  
  # Uncompress data file
  if (file.exists(dir) == FALSE) {
    unzip(dataFileZIP)
  }
}