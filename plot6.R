#load ggplot2 library
library(ggplot2)

# Read in assignment files using readRDS function
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grep on SCC.Level.Three column to subset anything which contains the word "Vehicle"
SCCVehicle <- SCC[grep("Vehicle", SCC$SCC.Level.Two), ]

# Merge / Lookup the results of SCCCoal against the Emissions Data (NEI)
merged = merge(NEI[, c("SCC", "Emissions","year", "fips")], SCCVehicle[, c("SCC", "SCC.Level.Three")])

BaltimoreCityVehicles <- subset(merged, merged$fips == "24510")
LAVehicles <- subset(merged, merged$fips == "06037")

# Aggregate Emissions by Year
BaltimoreCityVehicleTotals <- aggregate(BaltimoreCityVehicles$Emissions, list(BaltimoreCityVehicles$year,BaltimoreCityVehicles$fips), sum)
colnames(BaltimoreCityVehicleTotals) <- c("Year", "City","Emissions")
BaltimoreCityVehicleTotals$City <- "Baltimore City"

LAVehicleTotals <- aggregate(LAVehicles$Emissions, list(LAVehicles$year, LAVehicles$fips), sum)
colnames(LAVehicleTotals) <- c("Year", "City","Emissions")
LAVehicleTotals$City <- "Los Angeles County"

BaltimoreLAVehicles <- rbind(BaltimoreCityVehicleTotals, LAVehicleTotals)

# Construct Plot
p <- ggplot(BaltimoreLAVehicles, aes(Year, Emissions, color = City)) + geom_line() + facet_grid(~ City)
p <- p + facet_wrap(~ City, scales = "free")
p <- p + ggtitle("Los Angeles County vs. Baltimore City \n Vehicle Emissions from 1999 to 2008") + theme(plot.title = element_text(hjust = 0.5))+ xlab("Year") + ylab("Emissions")
print(p)

# Save to png image file
dev.copy(png, file = "plot6.png")
dev.off()