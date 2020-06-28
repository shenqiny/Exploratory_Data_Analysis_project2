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
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(dplyr)
libary(ggplot2)
baltimore<-subset(NEI, fips=="24510")
######generate motor vehicle SCC codes, including on-road and off-road vehicle
motor<-SCC[grep("Mobile", SCC$EI.Sector, ignore.case =TRUE),]
motor<-motor[!grepl("aircraft", motor$SCC.Level.Two, ignore.case =TRUE),]
motor<-motor[!grepl("railroad", motor$SCC.Level.Two, ignore.case =TRUE),]
motor<-motor[!grepl("marine", motor$SCC.Level.Two, ignore.case =TRUE),]
motor<-motor[!grepl("Pleasure Craft", motor$SCC.Level.Two, ignore.case =TRUE),]

NEI5<-subset(baltimore, SCC%in%motor$SCC )
png("plot5.png", height = 480, width = 600)
sum_motor<-tapply(NEI5$Emissions, NEI5$year, sum)
barplot( sum_motor, main = "Sum of PM2.5 emission from motor vehicle in Baltimore", xlab = "Year", ylab="PM2.5 emitted (tons)")
dev.off()
