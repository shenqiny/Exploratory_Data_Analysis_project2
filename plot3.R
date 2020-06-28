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
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
library(dplyr)
libary(ggplot2)
baltimore<-subset(NEI, fips=="24510")
NEI1<-group_by(baltimore, type, year)%>%summarise(Total=sum(Emissions))
png("plot3.png", height = 480, width = 600)

p<-ggplot(NEI1, aes(x=as.factor(year), y=Total, fill=type))+geom_col(position="dodge")+facet_grid(cols= vars(type))+xlab("Year")+ylab("PM2.5 emitted (tons)")+labs(title="PM2.5 emission per type-Baltimore")+theme(axis.text.x = element_text(angle = 90))
p
dev.off()
