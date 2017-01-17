# load libraries I'll need later
library(ggplot2)

# PC3. Load the CSV file into R. Also make sure that you loaded the
# week 2 dataset file.

setwd("~/com521/uwcom521-assignments/week_03")
list.files() # just take a look around
week3.dataset <- read.csv("week3_dataset-anissa.csv")

# PC4. Get to know your data! Do whatever is necessary to summarize
# the new dataset. Now many columns and rows are there? What are the
# appropriate summary statistics to report for each variable? What are
# the ranges, minimums, maximums, means, medians, standard deviations
# of the variables of variables? Draw histograms for all of the
# variables to get a sense of what it looks like. Save code to do all
# of these things.

head(week3.dataset)
nrow(week3.dataset)
ncol(week3.dataset)

lapply(week3.dataset, class)
lapply(week3.dataset, summary)
lapply(week3.dataset, sd)

# this code below is not ideal since it makes it hard to figure out
# which variable is being graphed (basically, they're in order, but
# that's all I have since they are all labled as x[[l]])... but it
# sure is expedient and short!
colnames(week3.dataset)
lapply(week3.dataset, hist)

# PC5. Compare the week2.dataset vector with the first column (x) of
# the data frame. I mentioned in the video lecture that they are
# similar? Do you agree? How similar? Write R code to demonstrate or
# support this answer convincingly.

# load the variable week2.dataset
load("../week_02/week2_dataset-anissa.RData")

# the summary stats seems the same. they look like they're the same
# things.
summary(week2.dataset)
summary(week3.dataset$x)

# but they don't match up...
table(week2.dataset == week3.dataset$x)
head(week2.dataset)
head(week3.dataset$x)

# huh, they /still/ don't all match with ==, but they at least now
# look like they could
table(sort(week2.dataset) == sort(week3.dataset$x))
head(sort(week2.dataset))
head(sort(week3.dataset$x))

# rounded to six decimal places, they match!
table(sort(round(week2.dataset, 6)) == sort(round(week3.dataset$x, 6)))

# PC6. Visualize the data using ggplot2 and the geom <- point()
# function. Graphing the x on the x-axis and y on the y-axis seem
# pretty reasonable! If only it were always so easy! Graph i, j, and k
# on other dimensions (e.g., color, shape, and size seems
# reasonable). Did you run into any trouble? How would you work around
# this?

# the big problems i ran into were problems with the fact taht all my
# favorites were numeric and i really wanted discrete scales for
# things like color and size. i converted everything to a factor which
# helped.
ggplot(week3.dataset) + aes(x=x, y=y, color=as.factor(i), size=as.factor(j), shape=as.factor(k)) + geom_point()

# PC7. A very common step when you import and prepare for data
# analysis is going to be cleaning and coding data. Some of that is
# needed here. As is very common, i, j are really dichotomous
# "true/false" variables but they are coded as 0 and 1 in this
# dataset. Recode these columns as logical. The variable k is really a
# categorical variable. Recode this as a factor and change the numbers
# into textual "meaning" to make it easier. Here's the relevant piece
# of the codebook (i.e., mapping): 0=none, 1=some, 2=lots, 3=all. The
# goals is to end up with a factor where those text strings are the
# levels of the factor. I haven't shown you how to do exactly this but
# you can solve this with things I have shown you. Or you can try to
# find a recipe online.
week3.dataset$i <- as.logical(week3.dataset$i)
week3.dataset$j <- as.logical(week3.dataset$j)
week3.dataset$k.factor <- factor(week3.dataset$k,
                                 levels=c(0,1,2,3),
                                 labels=c("none", "some", "lots", "all"))

# spotcheck to make sure it looks good
head(week3.dataset, 10)

week3.dataset$k <- week3.dataset$k.factor
week3.dataset$k.factor <- NULL #delete the old one

# PC8. Take column i and set it equal to NA when if it is FALSE
# (originally 0). Then set all the values that are NA back to
# FALSE. Sorry for the busy work! ;)

table(week3.dataset$i)

week3.dataset$i[!week3.dataset$i] <- NA
table(week3.dataset$i)

week3.dataset$i[is.na(week3.dataset$i)] <- FALSE
table(week3.dataset$i)

head(week3.dataset)

# PC9. Now that you have recoded your data in PC7, generate new
# summaries for those three variables. Also, go back and regenerate
# the visualizations. How have these changed? How are these different
# from the summary detail you presented above?

# summary works much better now
# table might be good too
lapply(week3.dataset, summary)

ggplot(week3.dataset) + aes(x=x, y=y, color=i, size=j, shape=k) + geom_point()

                                                                              
