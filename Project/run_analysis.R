#Your working directory here:
WD <- ""
if (WD == "") WD <- getwd()
setwd(WD)

#Create necessary folders and download files
if(!dir.exists("data")) dir.create("data")
DATA_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = DATA_URL, destfile = "data/raw_data.zip")
unzip("data/raw_data.zip", exdir = "data")

#Libraries
libs <- c("data.table", "dplyr", "mgsub", "plyr")
if (libs %in% rownames(install.packages()) == FALSE) {
  install.packages(libs)
}
library(libs)

#Reading data
train_x_df <- fread("data/UCI HAR Dataset/train/X_train.txt")
train_y_df <- fread("data/UCI HAR Dataset/train/y_train.txt")
train_id_df <- fread("data/UCI HAR Dataset/train/subject_train.txt")
test_id_df <- fread("data/UCI HAR Dataset/test/subject_test.txt")
test_x_df <- fread("data/UCI HAR Dataset/test/X_test.txt")
test_y_df <- fread("data/UCI HAR Dataset/test/y_test.txt")
feature_names <- fread("data/UCI HAR Dataset/features.txt")

#Cleaning Column Names
#remove curly brackets, replace - and , with underscores,
#puts underscore between lowercase and uppercase letters,
#transform to uppercase, replace T with TIME and F with FREQ
feature_names <- feature_names %>%
  mutate(V2 = gsub(x = V2, pattern = "\\(|\\)", replacement = "")) %>%
  mutate(V2 = gsub(x = V2, pattern = "-|,", replacement = "_")) %>%
  mutate(V2 = gsub(x = V2,
                   pattern = "([a-z])([A-Z])",
                   replacement = "\\1_\\2")
         ) %>%
  mutate(V2 = toupper(V2)) %>% 
  mutate(V2 = mgsub(string = V2,
                    pattern = c("^T_", "^F_"),
                    replacement = c("TIME_", "FREQ_"))
         )

#Task 1
#Merges the training and the test sets to create one data set.
X_df <- rbind(train_x_df, test_x_df)
Y_df <- rbind(train_y_df, test_y_df)
id_df <- rbind(train_id_df, test_id_df)
colnames(X_df) <- feature_names$V2
colnames(Y_df) <- "ACTIVITY"
colnames(id_df) <- "ID_SUBJECT"
merged_data <- cbind(id_df, X_df, Y_df)

#It turns out that there are duplicate column names. The columns themselves are
#not duplicated. It seems like prefixes of X, Y and Z were not added. Having the
#same columns names causes errors in later data processsing. Here,we assume that
#the first occurence of duplicated column name means X, the second - Y, the
#third - Z

col_names <- colnames(merged_data)
#Find duplicate values
dup_col_values <- table(col_names) %>% data.frame() %>% filter(Freq > 1) %>% 
  mutate(col_names = as.character(col_names)) %>% pull(col_names)

#Add prefix X to the first occurence of duplicate column name, Y to 2nd, Z - 3rd
for (col in col_names) {
  if (col %in% dup_col_values) {
    dup_indexes <- which(col_names == col)
    col_names[dup_indexes[1]] = paste0(col, "_X")
    col_names[dup_indexes[2]] = paste0(col, "_Y")
    col_names[dup_indexes[3]] = paste0(col, "_Z")
  }
}

#Replace column names
colnames(merged_data) <- col_names

#Task 2
#Extracts only the measurements on the mean and standard deviation for each
#measurement.
final_data <- merged_data %>%
  select(ACTIVITY, ID_SUBJECT, matches("MEAN|STD"))

#Task 3
activity_labels <- fread("data/UCI HAR Dataset/activity_labels.txt")
final_data <- final_data %>%
  mutate(ACTIVITY = plyr::mapvalues(x = ACTIVITY,
                                    from = activity_labels$V1,
                                    to = activity_labels$V2)
         )

#Task 4
#The task has been performed in lines 27-38, here we just save the dataset
write.csv(x = final_data, file = "data/clean_data.txt")

#Task 5
summary_act_df <- final_data %>%
  group_by(ACTIVITY) %>%
  summarise_at(vars(-ACTIVITY, -ID_SUBJECT), mean)
summary_id_df <- final_data %>%
  group_by(ID_SUBJECT) %>%
  summarise_at(vars(-ACTIVITY, -ID_SUBJECT), mean)

write.csv(x = summary_act_df, file = "data/summary_activity_data.txt")
write.csv(x = summary_id_df, file = "data/summary_id_data.txt")
