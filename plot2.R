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
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
baltimore<-subset(NEI, fips=="24510")
sum_emission<-tapply(baltimore$Emissions, baltimore$year, sum)
png("plot2.png", height = 480, width = 480)
barplot(sum_emission, main = "Sum of PM2.5 emission-Baltimore", xlab = "Years", ylab="PM2.5 emitted (tons)")
dev.off()
