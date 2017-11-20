# Read in assignment files using readRDS function
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate Emissions by Year
PM25Totals <- aggregate(NEI$Emissions, list(NEI$year), sum)

# Simple line plot (Base package) of the result
plot(PM25Totals$Group.1,PM25Totals$x, type = "l", xlab = "Year", ylab = "PM2.5 Emissions", main = "Total emissions from PM2.5 in the US from 1999 to 2008")

# Save to png image file
dev.copy(png, file = "plot1.png")
dev.off()