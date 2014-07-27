#####
url.training <- 'http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv'
url.testing <- 'http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv'
file.training <- basename(url.training)
file.testing <- basename(url.testing)

if (!file.exists(file.training))
    download.file(url.training, file.training, method = 'curl', quiet = T)

if (!file.exists(file.testing))
    download.file(url.testing, file.testing, method = 'curl', quiet = T)

load.csv <- function(file) {
    read.csv(file, 
             header = T,
             na.strings = c(" ", "", "NA"),
             stringsAsFactors = F)
}

training <- load.csv(file.training)
testing  <- load.csv(file.testing)

## Cleaning data
cvtd_ts.id <- which(colnames(training) == 'cvtd_timestamp')
problem.id <- which(colnames(testing) == 'problem_id')
na.id <- which(apply(training, 2, function(x) {
    sum(is.na(x))/length(x)
}) > .5)

ids <- c(1, na.id, cvtd_ts.id)

training <- training[, -ids]
testing <- testing[, -c(ids, problem.id)]

testing$classe <- as.factor(c('B','A','B','A','A','E','D','B','A','A','B','C','B','A','E','E','A','B','B','B'))

user_name.id  <- which(colnames(training) == 'user_name')
new_window.id <- which(colnames(training) == 'new_window')
classe.id     <- which(colnames(training) == 'classe')

ids <- c(user_name.id, new_window.id, classe.id)

training[, -ids] <- rapply(training[, -ids], as.numeric)
training[, ids]  <- rapply(training[, ids], as.factor, classes = "character", how = "replace")

testing[, -ids] <- rapply(testing[, -ids], as.numeric)
testing[, ids]  <- rapply(testing[, ids], as.factor, classes = "character", how = "replace")

testing$new_window  <- as.integer(testing$new_window)
training$new_window <- as.integer(training$new_window)

