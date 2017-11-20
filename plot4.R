# Read in assignment files using readRDS function
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grep on SCC.Level.Three column to subset anything which contains the word "Coal"
SCCCoal <- SCC[grep("Coal", SCC$SCC.Level.Three), ]

# Merge / Lookup the results of SCCCoal against the Emissions Data (NEI)
merged = merge(NEI[, c("SCC", "Emissions","year")], 
               SCCCoal[, c("SCC", "SCC.Level.Three")])

# Aggregate Emissions by Year
MergedTotals <- aggregate(merged$Emissions, list(merged$year), sum)

# Simple line plot (Base package) of the result
plot(MergedTotals$Group.1,MergedTotals$x, type = "l", xlab = "Year", ylab = "Emissions", main = "Coal combustion-related Emissions across the US 1999 to 2008")

# Save to png image file
dev.copy(png, file = "plot4.png")
dev.off()