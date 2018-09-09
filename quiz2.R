library(readr)
library(httr)
library(jsonlite)
library(XML)

setwd("C:\\Users\\kiryl.varanovich\\Documents\\Knowledge\\Data Science\\Courses\\Coursera_Getting_and_Cleaning_Data")
if (!file.exists("./Week2")) {
  dir.create("Week2")
}

#Question1
#Register an application with the Github API here https://github.com/settings/applications.
#Access the API to get information on your instructors repositories
#(hint: this is the url you want "https://api.github.com/users/jtleek/repos").
#Use this data to find the time that the datasharing repo was created. What time was it created?
#This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r).
#You may also need to run the code in the base R package and not R studio.

oauth_endpoints("github")

myapp <- oauth_app(appname = "coursera-test",
                   key = read_file("Week2/client_id.txt"),
                   secret = read_file("Week2/client_secret.txt"))

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json_github <- fromJSON(toJSON(content(req)))
json_github[json_github$name=="datasharing",]$created_at

#1 - 2014-03-05T16:11:46Z
#2 - 2013-08-28T18:18:50Z
#3 - 2013-11-07T13:25:07Z
#4 - 2012-06-20T18:39:06Z
#Answer:3

#Question2
#The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf
#package to practice the queries we might send with the dbSendQuery command in RMySQL.
#Download the American Community Survey data and load it into an R object called acs
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
#Which of the following commands will select only the data for the probability weights
#1 - pwgtp1 with ages less than 50?
#2 - sqldf("select pwgtp1 from acs where AGEP \lt< 50")
#3 - sqldf("select * from acs")
#4 - sqldf("select pwgtp1 from acs")
#5 - sqldf("select * from acs where AGEP \lt< 50")
#Answer 1

#Question3
#Using the same data frame you created in the previous problem, what is the
#equivalent function to unique(acs$AGEP)
#sqldf("select distinct AGEP from acs")
#sqldf("select distinct pwgtp1 from acs")
#sqldf("select unique * from acs")
#sqldf("select AGEP where unique from acs")
#Answer 1

#Question4
#How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
#http://biostat.jhsph.edu/~jleek/contact.html
#(Hint: the nchar() function in R may be helpful)
#1 - 45 0 2 2
#2 - 45 31 2 25
#3 - 45 31 7 31
#4 - 45 92 7 2
#5 - 43 99 7 25
#6 - 43 99 8 6
#7 - 45 31 7 25
html4 <- GET(url = "http://biostat.jhsph.edu/~jleek/contact.html")
cont4 <- content(x = html4,
                 type = "text")
cont4_split <- strsplit(cont4, split = "\n")[[1]]
sapply(cont4_split[c(10,20,30,100)], nchar)

#Answer: 7

#Question5
#Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
#https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
#Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
#(Hint this is a fixed width file format)

library(foreign)
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url = file_url,
              destfile = "Week2/ex4.for")
df <- read.fwf("Week2/ex4.for",
               widths = c(-1, 9, -5, 4, -1, 3, -5, 4, -1, 3, -5, 4, -1, 3, -5, 4, -1, 3),
               skip = 4)
sum(df$V4)

#1 - 222243.1
#2 - 101.83
#3 - 35824.9
#4 - 28893.3
#5 - 36.5
#6 - 32426.7

#Answer: 6