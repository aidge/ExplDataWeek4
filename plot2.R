# Read in assignment files using readRDS function
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore City fips = 24510
BaltimoreCity <- subset(NEI, NEI$fips == "24510")

# Aggregate Emissions by Year
BaltimoreCityPM25Totals <- aggregate(BaltimoreCity$Emissions, list(BaltimoreCity$year), sum)

# Simple line plot (Base package) of the result
plot(BaltimoreCityPM25Totals$Group.1,BaltimoreCityPM25Totals$x, type = "l", xlab = "Year", ylab = "PM2.5 Emissions", main = "Total emissions from PM2.5 in Baltimore City 1999 to 2008")

# Save to png image file
dev.copy(png, file = "plot2.png")
dev.off()