#load ggplot2 library
library(ggplot2)

# Read in assignment files using readRDS function
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore City fips = 24510
BaltimoreCity <- subset(NEI, NEI$fips == "24510")

# Aggregate Emissions by Year and Type
BaltimoreCityPM25Totals <- aggregate(BaltimoreCity$Emissions, list(BaltimoreCity$year, BaltimoreCity$type), sum)
colnames(BaltimoreCityPM25Totals) <- c("Year", "Type", "Emissions")

# Construct Plot
p <- ggplot(BaltimoreCityPM25Totals, aes(Year, Emissions, color = Type)) + geom_line() + facet_grid(~ Type)
p <- p + facet_wrap(~ Type, scales = "free")
p <- p + ggtitle("Baltimore City Emissions by Type from 1999 to 2008") + theme(plot.title = element_text(hjust = 0.5)) + xlab("Year") + ylab("Baltimore City PM2.5 Emissions")
print(p)

# Save to png image file
dev.copy(png, file = "plot3.png")
dev.off()