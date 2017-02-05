setwd("~/com521/problem_sets/week_06")

## PC0. Download the dataset from from this webpage. You'll find that
## the it's not in an ideal setup. It's an Excel file (XLS) with a
## series of columns labeled X1.. X4. The format is not exactly
## tabular.

## mako: I downloaded the XLS and use LibreOffice to change it into a
## CSV file. There are other ways you could have done this.

##PC1. Load the data into R. Now get to work on reshaping the
##dataset. I think a good format would be a data frame with two
##columns: group, time of death (i.e., lifespan).

d <- read.csv("owan03.csv")

## X1 = time of death for control group
## X2 = time of death for group with low dosage
## X3 = time of death for group with medium dosage
## X4 = time of death for group with high dosage
colnames(d) <- c("control", "low", "medium", "high")

## there are a bunch of weays to do this but I like the melt()
## function from the reshape library
library(reshape)
d <- melt(d, na.rm=TRUE)
colnames(d) <- c("group", "death.time")

## PC2. Create summary statistics and visualizations for each
## group. Write code that allows you to generate a useful way to both
## (a) get a visual sense both for the shape of the data and its
## relationships (b) the degree to which the assumptions for t-tests
## and ANOVA hold. What is the global mean of your dependent variable?

hist(d$death.time)

library(ggplot2)
ggplot(data=d) + aes(x=death.time, fill=group) + geom_bar() + stat_bin(binwidth=10)

ggplot(data=d) + aes(x=death.time, fill=group) + geom_bar() + stat_bin(binwidth=10) + facet_grid(group ~.)

## PC3. Do a t-test between mice with any RD40 and mice with at least
## a small amount. Run a t-test between the group with a high dosage
## and control group.

t.test(d$death.time[d$group == "control"], d$death.time[d$group != "control"])

## How would you go about doing it using formula notation?
d$control <- d$group == "control"
t.test(death.time ~ control, data=d)

## PC4. Run an anova using aov() to see if there is a difference
## between the groups. Be ready to report, interpret, and discuss the
## results in substantive terms.
summary(aov(death.time ~ group, data=d))
