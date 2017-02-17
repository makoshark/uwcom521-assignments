## PC1. Download this dataset in Stata DTA format which contains an
## anonymized and reduced version of the data visualized in the
## Buechley and Hill paper on Lilypad.

library(foreign)
lilypad.data <- read.dta("lilypad_anonymized.dta")

## recode the colnames to change _ to .
colnames(lilypad.data) <- gsub("_", ".", colnames(lilypad.data))

## (a) Reproduce both Table 1 and Table 2 (just US users) using the
## dataset (as closely as possible).
lilypad.data$gender <- factor(lilypad.data$gender, c("male", "female", "unknown"))
tbl.1 <- table(lilypad.data$gender, lilypad.data$order.type)
tbl.1

## the second tabler is just the us
lilypad.data.us <- lilypad.data[lilypad.data$country == "United States",]
tbl.2 <- table(lilypad.data.us$gender, lilypad.data.us$order.type)
tbl.2

## (b) Run a χ² test on both tables
chisq.test(tbl.1)
chisq.test(tbl.2)

## (c) Install the package "gmodels" and try to display the table
## using the function CrossTable(). This will give you output very
## similar to SPSS.
library(gmodels)
CrossTable(tbl.1)
CrossTable(tbl.2)

## (d) It's important to be able to import tables directly into your
## word processor without cutting and pasting individual cells. Can
## you export the output of your table? There are a bunch of functions
## you can use to do this. I used the "xtable" package but I think
## that write.table() and Excel would do the job just as well.
print(xtable(tbl.1), type="html")
print(xtable(tbl.2), type="html")

## PC2. At the Community Data Science Workshops we had two parallel
## afternoon sessions on Day 1. In my session, there were 42
## participants. In Tommy Guy's session, there were only 19. The next
## week (Day 2), we asked folks to raise their hands if they had been
## in Tommy's session (14 did ) and how many had been in mine (31
## did). There was clearly attrition in both groups! Was there more
## attrition in one group than another?  Try answering this both with
## a test of proportions (prop.test()) and with a χ². Compare your answers. Is
## there convincing evidence that there is a dependence between
## instructor and attrition?

cdsw.tbl <- matrix(c(42, 19, 31, 14), ncol=2)
rownames(cdsw.tbl) <- c("mako", "tommy")
colnames(cdsw.tbl) <- c("day.1", "day.2")

## first look at the raw proportions
cdsw.tbl[,"day.2"] / cdsw.tbl[,"day.1"]

## now the prop.test
prop.test(cdsw.tbl[,"day.2"], cdsw.tbl[,"day.1"])

## now the chi-squared.test
chisq.test(cdsw.tbl)

## PC3. Download this dataset that was just published on "The Effect
## of Images of Michelle Obama’s Face on Trick-or-Treaters’ Dietary
## Choices: A Randomized Control Trial." The paper doesn't seem to
## have even been published yet so I think the abstract is all we
## have. We'll come back to it again next week.

## (a) Download and import the data into R. I needed to install the
## "readstata13" package to do so.

library(readstata13)
halloween <- read.dta13("Halloween2012-2014-2015_PLOS.dta")

## recode the colnames to change _ to .
colnames(halloween) <- gsub("_", ".", colnames(halloween))

## (b) Take a look at the codebook if necessary. Recode the data on
## being presented with Michelle Obama's face and the data on whether
## or not kids picked up fruit. we'll leave it at that for now.
halloween$obama <- as.logical(halloween$obama)
halloween$fruit <- as.logical(halloween$fruit)

obama.tbl <- table(fruit=halloween$fruit, obama=halloween$obama)
obama.tbl
CrossTable(obama.tbl)

## (c) Do a simple test on whether or not the two groups are
## dependent. Be ready to report those tests. The results in the paper
## will use linear regression. Do you have a sense, from your reading,
## why your results using the coding material we've learned might be

total.saw.obama <- apply(obama.tbl, 2, sum)

## calculate the proportion of folks who did and didn't see obama's
## face who took fruit
obama.tbl["TRUE",] / total.saw.obama

## the results with the two tests are the same
prop.test(obama.tbl["TRUE",], total.saw.obama)
chisq.test(obama.tbl)
