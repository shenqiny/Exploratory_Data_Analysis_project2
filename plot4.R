library(dplyr)
###Data download
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "exdata_data_FNEI_data.zip", method="curl")
##unzip and save files in the "assignment2" folder
if(!file.exists("assignment2")) {
  unzip("exdata_data_FNEI_data.zip", exdir="./assignment2")
}

NEI <- readRDS("assignment2/summarySCC_PM25.rds")
SCC <- readRDS("assignment2/Source_Classification_Code.rds")

#Assignment
#The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. 
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
str(NEI)
str(SCC)
coal<-SCC[grep("coal|Coal", SCC$Short.Name),]
NEI4<-subset(NEI, SCC%in%coal$SCC )
png("plot4.png", height = 480, width = 480)
sum_coal<-tapply(NEI4$Emissions, NEI4$year, sum)
barplot( sum_coal/10^6, main = "Sum of PM2.5 emission from coal", xlab = "Year", ylab="PM2.5 emitted (10^6 tons)")
dev.off()
