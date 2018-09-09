library(dplyr)

setwd("C:\\Users\\kiryl.varanovich\\Documents\\Knowledge\\Data Science\\Courses\\Coursera_Getting_and_Cleaning_Data")
if (!file.exists("./Week1")) {
  dir.create("Week1")
}

#Question 1
# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = fileUrl,
              destfile = "Week1/survey.csv")

df <- read.csv("Week1/survey.csv")

#We are looking for a variable called VAL with a value of 24 which represent property price over 1kk
df %>% select(VAL) %>% filter(VAL == 24) %>% dim()

#Answer: 53 observations

#Question2
#Use the data you loaded from Question 1. Consider the variable FES in the code book. 
#Which of the "tidy data" principles does this variable violate?

df %>% select(FES) %>% View()
#Actually we don't need to even look at the data, we just need to look at the codebook
#Variable FES represents Familty Type AND Employment Status
#Of of the principles of clean data is that tidy data has one variable per column

#Question3
#Download the Excel spreadsheet on Natural Gas Aquisition Program here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
#Read rows 18-23 and columns 7-15 into R and assign the result to a variable called: dat
#What is the value of:sum(dat$Zip*dat$Ext,na.rm=T)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url = fileUrl,
              destfile = "Week1/ex3.xlsx",
              mode = "wb") #we need to specify the mode to download the file as binary

library("xlsx")
dat <- read.xlsx(file = "Week1/ex3.xlsx",
                 sheetName = "NGAP Sample Data",
                 rowIndex = 18:23,
                 colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)
#Answer: 36534720

#Question4
#Read the XML data on Baltimore restaurants from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
#How many restaurants have zipcode 21231?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(url = fileUrl,
              destfile = "Week1/ex4.xml")

library(XML)
doc <- xmlTreeParse(file = "Week1/ex4.xml",
                    useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
rootNode[[1]][[1]]
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue) %>% as.numeric()
(zipcode == 21231) %>% table()
#Answer: 127

#Question5
#The American Community Survey distributes downloadable data about United States communities.
#Download the 2006 microdata survey about housing for the state of Idaho using download.file()
#from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
#using the fread() command load the data into an R object
#DT
#The following are ways to calculate the average value of the variable
#pwgtp15
#1 - mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
#2 - tapply(DT$pwgtp15,DT$SEX,mean)
#3 - mean(DT$pwgtp15,by=DT$SEX)
#4 - DT[,mean(pwgtp15),by=SEX]
#5 - rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
#6 - sapply(split(DT$pwgtp15,DT$SEX),mean)
#broken down by sex. Using the data.table package, which will deliver the fastest user time?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url = fileUrl,
              destfile = "Week1/ex5.csv")

library(data.table)
DT <- fread("Week1/ex5.csv")

mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15) #not using data.table
tapply(DT$pwgtp15,DT$SEX,mean) #not using data.table
mean(DT$pwgtp15,by=DT$SEX) #Not valid syntax, shows just 1 value, and not 2
DT[,mean(pwgtp15),by=SEX] #Using data.table
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] #throws an error
sapply(split(DT$pwgtp15,DT$SEX),mean) #not using data.table

#Answer: DT[,mean(pwgtp15),by=SEX]