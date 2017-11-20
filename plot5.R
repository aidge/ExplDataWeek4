# Read in assignment files using readRDS function
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grep on SCC.Level.Three column to subset anything which contains the word "Vehicle"
SCCVehicle <- SCC[grep("Vehicle", SCC$SCC.Level.Two), ]

# Merge / Lookup the results of SCCCoal against the Emissions Data (NEI)
merged = merge(NEI[, c("SCC", "Emissions","year", "fips")], SCCVehicle[, c("SCC", "SCC.Level.Three")])

BaltimoreCityVehicles <- subset(merged, merged$fips == "24510")

# Aggregate Emissions by Year
BaltimoreCityVehicleTotals <- aggregate(BaltimoreCityVehicles$Emissions, list(BaltimoreCityVehicles$year), sum)

# Simple line plot (Base package) of the result
plot(BaltimoreCityVehicleTotals$Group.1,BaltimoreCityVehicleTotals$x, type = "l", xlab = "Year", ylab = "Emissions", main = "Motor Vechicle Emissions in Baltimore City from 1999 to 2008")

# Save to png image file
dev.copy(png, file = "plot5.png")
dev.off()