library(dplyr)

setwd("C:\\Users\\kiryl.varanovich\\Documents\\Knowledge\\Data Science\\Courses\\Coursera_Getting_and_Cleaning_Data")

if (!file.exists("./Week4")) dir.create("Week4")

#Question 1
#The American Community Survey distributes downloadable data about United States communities.
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#and load the data into R. The code book, describing the variable names is here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#Apply strsplit() to split all the names of the data frame on the characters "wgtp".
#What is the value of the 123 element of the resulting list?
#1 - "wgt" "15"
#2 - "" "15"
#3 - "wgtp" "15"
#4 - "w" "15"

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = file_url,
              destfile = "Week4/ex1.csv")
ex1 <- read.csv("Week4/ex1.csv")
ex1_split <- strsplit(x = names(ex1),
                      split = "wgtp")
ex1_split[123]

#Answer: 2

#Question 2
#Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
#Original data sources:
#http://data.worldbank.org/data-catalog/GDP-ranking-table
#1 - 379596.5
#2 - 377652.4
#3 - 387854.4
#4 - 381668.9

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = file_url,
              destfile = "Week4/ex2.csv")
ex2 <- read.csv("Week4/ex2.csv",
                skip = 4,
                stringsAsFactors = FALSE)
ex2 <- ex2 %>% filter(X.1 %in% as.character(1:190)) %>% select(X:X.4, -one_of("X.2"))

ex2 <- ex2 %>% mutate(X.4 = gsub(",", "", X.4) %>% as.numeric())
mean(ex2$X.4)

#Answer: 2

#Question 3
#In the data set from Question 2 what is a regular expression that would allow you to count the number
#of countries whose name begins with "United"? Assume that the variable with the country names in it
#is named countryNames. How many countries begin with United?
#1 - grep("*United",countryNames), 2
#2 - grep("United$",countryNames), 3
#3 - grep("^United",countryNames), 3
#4 - grep("*United",countryNames), 5

ex2[grep(pattern = "^United", x = ex2$X.3), ]

#Answer: 3

#Question 4
#Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#Load the educational data from this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
#Match the data based on the country shortcode. Of the countries for which the end of the
#fiscal year is available, how many end in June?
#Original data sources:
#http://data.worldbank.org/data-catalog/GDP-ranking-table
#http://data.worldbank.org/data-catalog/ed-stats
#1 - 13
#2 - 15
#3 - 7
#4 - 16

file_url_2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(url = file_url_2,
              destfile = "Week4/ex4.csv")
ex4 <- read.csv("Week4/ex4.csv",
                  stringsAsFactors = FALSE)

ex4_join <- inner_join(ex2, ex4, by = c("X"="CountryCode"))

grep(pattern = "fiscal year end: june",
     x = tolower(ex4_join$Special.Notes)) %>% length()

#Answer: 1

#Question 5
#You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for
#publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on
#Amazon's stock price and get the times the data was sampled.
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sample_times = index(amzn)
#How many values were collected in 2012? How many values were collected on Mondays in 2012?
#1 - 252, 50
#2 - 365, 52
#3 - 250, 47
#4 - 251,51


sample_years = format(sample_times, "%Y")
sample_workdays = format(sample_times, "%A")
sample_df = data.frame(sample_years, sample_workdays)
sample_df %>% filter(sample_years == "2012") %>% nrow()
sample_df %>% filter(sample_years == "2012", sample_workdays =="poniedziałek") %>% nrow()

#Answer: 3