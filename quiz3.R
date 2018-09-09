library(dplyr)
setwd("C:\\Users\\kiryl.varanovich\\Documents\\Knowledge\\Data Science\\Courses\\Coursera_Getting_and_Cleaning_Data")
if (!file.exists("./Week3")) {
  dir.create("Week3")
}

#Question 1
#The American Community Survey distributes downloadable data about United States communities.
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#and load the data into R. The code book, describing the variable names is here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#Create a logical vector that identifies the households on greater than 10 acres who sold more
#than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical.
#Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
#which(agricultureLogical)
#What are the first 3 values that result?
#1 - 25, 36, 45
#2 - 125, 238,262
#3 - 59, 460, 474
#4 - 403, 756, 798

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = file_url,
              destfile = "Week3/ex1.csv")
ex1 <- read.csv("Week3/ex1.csv")
ex1$agricultureLogical <- ifelse((ex1$ACR == 3) & (ex1$AGS == 6), TRUE, FALSE)
which(ex1$agricultureLogical == TRUE)

#Answer: 2

#Question 2
#Using the jpeg package read in the following picture of your instructor into R
#https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
#Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?
#(some Linux systems may produce an answer 638 different for the 30th quantile)
#1: -10904118 -10575416
#2: -15259150 -10575416
#3: -16776430 -15390165
#4: 10904118 -594524
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url = file_url,
              destfile = "Week3/ex2.jpg",
              mode = "wb") #because it's an image, we want to download it as binary file

install.packages("jpeg")
library(jpeg)
ex2 <- readJPEG("Week3/ex2.jpg",
                native = TRUE)
quantile(ex2, probs = c(0.3, 0.8))

#Answer: 2

#Question 3
#Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#Load the educational data from this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
#Match the data based on the country shortcode. How many of the IDs match?
#Sort the data frame in descending order by GDP rank (so United States is last).
#What is the 13th country in the resulting data frame?
#Original data sources:
#http://data.worldbank.org/data-catalog/GDP-ranking-table
#http://data.worldbank.org/data-catalog/ed-stats
#1 - 190 matches, 13th country is Spain
#2 - 189 matches, 13th country is St. Kitts and Nevis
#3 - 190 matches, 13th country is St. Kitts and Nevis
#4 - 189 matches, 13th country is Spain
#5 - 234 matches, 13th country is Spain
#6 - 234 matches, 13th country is St. Kitts and Nevis

file_url_1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file_url_2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = file_url_1,
              destfile = "Week3/ex3_1.csv")
download.file(url = file_url_2,
              destfile = "Week3/ex3_2.csv")
ex3_1 <- read.csv("Week3/ex3_1.csv",
                  skip = 4,
                  stringsAsFactors = FALSE)
ex3_2 <- read.csv("Week3/ex3_2.csv",
                  stringsAsFactors = FALSE)

#First data set requires some cleaning.
#We have already skipped first 4 rows, now we should remove some columns and rows
ex3_1 <- ex3_1 %>% filter(X.1 %in% as.character(1:190)) %>% select(X:X.4, -one_of("X.2"))
ex3 <- inner_join(ex3_1, ex3_2, by = c("X"="CountryCode"))
ex3 %>% dim()
ex3 %>% arrange(desc(as.numeric(X.1))) %>% .[13,"X.3"]

#Answer: 2

#Question 4
#What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
ex3 <- ex3 %>% mutate(X.1 = as.numeric(X.1), Income.Group = as.factor(Income.Group))
ex3 %>% filter(Income.Group %in% c("High income: nonOECD", "High income: OECD")) %>%
  group_by(Income.Group) %>% summarize(AVG = mean(X.1, na.rm = TRUE))

#1 - 23, 30
#2 - 133.72973, 32.96667
#3 - 30, 37
#4 - 23, 45
#5 - 23.966667, 30.91304
#6 - 32.96667, 91.91304

#Answer: 6

#Question 5
#Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
#are Lower middle income but among the 38 nations with highest GDP?
#1 - 0
#2 - 12
#3 - 5
#4 - 13
install.packages("Hmisc")
library(Hmisc)
ex3 <- ex3 %>% mutate(GDP_rank_groups = cut2(X.1, g = 5))
table(ex3[,c("GDP_rank_groups", "Income.Group")])

#Answer: 5