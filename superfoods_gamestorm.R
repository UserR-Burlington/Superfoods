
## ----opts----------------------------------------------------------------
#library(RCurl)
library(knitr)
library(ggplot2)


## ----loaddata------------------------------------------------------------
# read data
# skip first 3 rows, then import first row as header
superfoods <- read.csv("Superfood.csv", skip = 3, header = FALSE)
superfoods_header <- read.csv("Superfood.csv", skip = 1, nrow = 1, header = FALSE, stringsAsFactors = FALSE)
colnames(superfoods) <- superfoods_header

# For a challenge, download data from GoogleDocs using RCurl
# skip first 3 rows, then import first row as header
#myCSV <- getURL("https://docs.google.com/spreadsheet/pub?key=0Ar5IymziRJ_9dDl1aTdSRlZKakpnNXVjT2ZmVzdaQ1E&single=true&gid=2&output=csv")
#superfoods <- read.csv(textConnection(myCSV), skip = 3, header = FALSE, stringsAsFactors = FALSE)
#dim(superfoods)
#superfoods_header <- read.csv(textConnection(myCSV), nrows = 1, stringsAsFactors = FALSE)
#colnames(superfoods) <- superfoods_header


## ----explore-------------------------------------------------------------
dim(superfoods)
superfoods[1:5,1:10]
superfoods[1:5,11:20]

superdata <- superfoods[ , c("Food", "alternative name", "EVIDENCE", "condition", "HEALTH CONDITION", "TYPE", "One to watch", "POPULARITY", "NO OF STUDIES WE EXAMINED", "SCIENTIFIC INTEREST")]
str(superdata)


## ----, fig.align='center'------------------------------------------------
# base plot
barplot(superdata$EVIDENCE)

# point plot
p <- ggplot(superdata, aes(Food, EVIDENCE))
p + geom_point()

p <- ggplot(superdata, aes(EVIDENCE, Food))
p + geom_point()


## ----close---------------------------------------------------------------
sessionInfo()
purl("superfoods_gamestorm.Rmd")


