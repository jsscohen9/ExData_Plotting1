#Script to import data into R

library(tidyverse)

op <- options(stringsAsFactors=F)  #set to F

# create a temporary directory
td = tempdir()
# create the placeholder file
tf = tempfile(tmpdir=td, fileext=".zip")

#save the url
energyurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# download into the placeholder file
download.file(energyurl, tf)

# get the name of the first file in the zip archive
fname = unzip(tf, list=TRUE)$Name[1]

# unzip the file to the temporary directory
unzip(tf, files=fname, exdir=td, overwrite=TRUE)

# fpath is the full path to the extracted file
fpath = file.path(td, fname)

#extract column names
data <- read.table(fpath, sep = ";", header = T, nrow=30)
col_names <- colnames(data)

# load file as table, capturing 2007-02-01 to 2007-02-02
data <- read.table(fpath, sep = ";", skip=40000, nrow=30000, na.strings = "?")

#add back column names
colnames(data) = col_names


#extract from dates 2007-02-01 and 2007-02-02.
subset(data, Date == "1/2/2007") -> data_temp1
subset(data, Date == "2/2/2007") -> data_temp2

rbind(data_temp1, data_temp2) -> feb_data

#convert date 
strptime(paste(feb_data$Date, feb_data$Time, sep = ""), format = "%d/%m/%Y %H:%M:%S") -> feb_data$Date

#Rename date column
rename(feb_data, "DateTime" = "Date")



#Global active power by hour

with(feb_data, plot(Date, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
with(feb_data, lines(Date, Global_active_power))

dev.copy(png, file ="Global_active_power_linegraph.png")
dev.off()
)