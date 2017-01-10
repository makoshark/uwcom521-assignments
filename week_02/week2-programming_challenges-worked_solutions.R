# change this line so that it's the name/location of your dataset
file.name <- "week2_dataset-anissa.RData"

# PC2. Once you have it, find the RData file in the subdirectory
# week <- 02 with your name associated with it. Load that file
# into R. It should load up one variable. Find that variable!

# load file in
load(file.name)

# look for files! looks like the file is called week2.dataset
ls()

# PC3. Once you've found the variable, compute and present a
# series of statistics on it that you should already be familiar
# with. Use functions to compute the mean, median, variance,
# standard deviation, and interquartile range?

mean(week2.dataset)
median(week2.dataset)
var(week2.dataset)
sd(week2.dataset)
IQR(week2.dataset)

# another approach that give sus some of these
summary(week2.dataset)

# PC4. Although these basic functions all exist, many things you
# will want to do in the future won't have functions. Write R code
# to compute these three statistics by hand: mean, median, and
# mode. It's OK if getting the answer involves some eyeballing or
# counting this by hand. But do get the answer and be ready to
# walk us through how you did it.

# mean is the sum divided by the length
sum(week2.dataset)/length(week2.dataset)

# median is the piece that is at the halfway point
# but... what happens if there are only 99 items?
sort(week2.dataset)[length(week2.dataset)/2]

# mode is the most common.... hmmm, there are no repeats
max.count <- rev(sort(table(week2.dataset)))
table(week2.dataset)[table(week2.dataset) == max.count]

# PC5. Create a number of visualizations of your dataset: at the
# very least, create a boxplot and histogram.
boxplot(week2.dataset)
hist(week2.dataset)
plot(density(week2.dataset))

# PC6. Some of you will have negative numbers. Whoops! Those were
# not supposed to be there. Recode all negative numbers as missing
# (i.e. NA) in your dataset. Now create compute a new mean and
# standard deviation. How does it change? (Hint: the basic mean
# function will give you an error. You have use a named argument
# na.rm=TRUE to work around this.)
week2.dataset.nozero <- week2.dataset
week2.dataset.nozero[week2.dataset.nozero < 0] <- NA
mean(week2.dataset.nozero, na.rm=TRUE)
sd(week2.dataset.nozero, na.rm=TRUE)

# PC7. Log transform your dataset. Create new histograms,
# boxplots, and means, median, and standard deviations.

# this causes errors for negative numbers! a logarithm is not
# defined for negative numbers!
week2.dataset.log <- log(week2.dataset)

mean(week2.dataset.log, na.rm=TRUE)
median(week2.dataset.log, na.rm=TRUE)
sd(week2.dataset.log, na.rm=TRUE)

# PC8. Commit the code that does all of these into a folder called
# "week_02" in your git repository. Publish this on Github and
# email me with the link to your published Github folder.

# if you're reading this, this was done successfully :)
