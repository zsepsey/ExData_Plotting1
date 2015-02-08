plot2 <- function() {
  downlaodAndUncompressZip("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                           "./householdPowerConsumption.zip", 
                           "./PowerConsumption")
  
  ppdata <- read.table("./household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", as.is=TRUE)
  
  ppdata[,1] <- as.Date(as.character(ppdata[,1]), "%d/%m/%Y")
  ppdata <- subset(ppdata, ppdata[,1] >= as.Date("01-02-2007", "%d-%m-%Y") & ppdata[,1] <= as.Date("02-02-2007","%d-%m-%Y"))
  
  ppdata[,1] <- paste(ppdata[,1], ppdata[,2], sep=" ")
  png("plot2.png")
  plot(strptime(ppdata[,1], "%Y-%m-%d %H:%M:%S"), ppdata$Global_active_power, type="l",
       xlab="", ylab="Global Active power (kilowatts)")
   
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