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
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
library(dplyr)
libary(ggplot2)
baltimore<-subset(NEI, fips=="24510")
la<-subset(NEI, fips=="06037")
######generate motor vehicle SCC codes, including on-road and off-road vehicle
motor<-SCC[grep("Mobile", SCC$EI.Sector, ignore.case =TRUE),]
motor<-motor[!grepl("aircraft", motor$SCC.Level.Two, ignore.case =TRUE),]
motor<-motor[!grepl("railroad", motor$SCC.Level.Two, ignore.case =TRUE),]
motor<-motor[!grepl("marine", motor$SCC.Level.Two, ignore.case =TRUE),]
motor<-motor[!grepl("Pleasure Craft", motor$SCC.Level.Two, ignore.case =TRUE),]
##########make NEI5 for baltimore data and NEI6 for LA data
NEI5<-subset(baltimore, SCC%in%motor$SCC )
NEI6<-subset(la, SCC%in%motor$SCC )
png("plot6.png", height = 480, width = 600)
sum_motor_b<-tapply(NEI5$Emissions, NEI5$year, sum)
sum_motor_l<-tapply(NEI6$Emissions, NEI6$year, sum)
par(mfrow=c(1,2))
barplot(sum_motor_b, main = "Emission from motor vehicle in Baltimore", xlab = "Year", ylab="PM2.5 emitted (tons)",cex.main=0.8, cex.lab=0.8, cex.names = 0.8)

barplot(sum_motor_l, main = "Emission from motor vehicle in LA", xlab = "Year", ylab="PM2.5 emitted (tons)",cex.main=0.8,cex.lab=0.8, cex.names = 0.8)

dev.off()
