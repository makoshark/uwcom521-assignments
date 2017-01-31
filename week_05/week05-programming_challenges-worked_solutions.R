## PC0. I've provided the full dataset from which I drew each of your
## samples in a TSV file in the directory week_05 in class assignment
## git repository. These are tab delimited, not comma delimited. TSV,
## is related to CSV and is also a common format. Go ahead and load it
## into R (HINT: read.delim()).

setwd("~/com521/problem_sets/week_05")
full.dataset <- read.delim("com521_population.tsv")

## Take the mean of the variable x in that dataset. That is the true
## population mean — the thing we have been creating estimates of in
## week 2 and week 3.

mean(full.dataset$x)

##  PC1. Go back to the dataset I distributed for the week 3 problem
##  set. You've already computed the mean for this in week 2. You
##  should compute the 95% confidence interval for the variable x in
##  two ways:
##
## (a) By hand using the normal formula for standard error

# i'm going to define my own confidence interval function
normal.confint <- function (x, alpha=0.05) {
    probs <- c(alpha/2, 1-alpha/2)
    critical.values <- qnorm(probs, mean=0, sd=1)
    
    se <- sd(x)/sqrt(length(x))
    mean(x) + critical.values * se
}

## now i'm going to load anissa's dataset from week_03
d.sample <- read.csv("../week_03/week3_dataset-anissa.csv")
normal.confint(d.sample$x)

## here's a command that will generate it once for everybody
function.to.file <- function (filename, my.fun, var.name="x") {
    full.filename <- paste("../week_03/", filename, sep="")
    d.tmp <- read.csv(full.filename)
    my.fun(d.tmp[, var.name])
}

sapply(list.files("../week_03"), function.to.file, normal.confint)

## (b) Using the appropriate built-in R function. These number should
## be the same or very close. After reading the OpenIntro, can you
## explain why they might not be exactly the same?
t.test(d.sample$x)

ttest.confint <- function (x) {
    test.result <- t.test(x)
    test.result[["conf.int"]]
}

sapply(list.files("../week_03"), function.to.file, ttest.confint)

## PC2. Let's look beyond the mean. Compare the distribution from your
## sample of x to the true population. Draw histograms and compute
## other descriptive and summary statistics. What do you notice? Be
## ready to talk for a minute or two about the differences.
hist(d.sample$x)
hist(full.dataset$x)

## PC3. Compute the mean of y from the true population and then create
## the mean and confidence interval from the y in your sample. Is it
## in or out?
mean(full.dataset$y)

sapply(list.files("../week_03"), function.to.file, ttest.confint,
       var.name="y")

## (a) Create a vector of 10,000 randomly generated numbers that are
## uniformly distributed between 0 and 9.

pop.unif <- sample(seq(0, 9), 10000, replace=TRUE)

## (b) Take the mean of that vector. Draw a histogram.
mean(pop.unif)
hist(pop.unif)

## (c) Create 100 random samples of 2 items each from your randomly
## generated data and take the mean of each sample. Create a new
## vector that contains those means. Describe/display the distribution
## of those means.

hist(sapply(rep(1, 100), function (x) { mean(sample(pop.unif, 2))}))

## (d) Do (c) except make the items 10 items in each sample instead of
## 2.

hist(sapply(rep(1, 100), function (x) { mean(sample(pop.unif, 10))}))

## Then do (c) again except with 100 items. Be ready to describe how the histogram changes as the sample size increases. (HINT: You'll make me very happy if you write a function to do this.)

hist(sapply(rep(1, 100), function (x) { mean(sample(pop.unif, 100))}))

## PC5. Do PC4 again but with random data drawn from a normal
## distribution ( N ( μ = 42 , σ = 42 ) instead of a uniform
## distribution.  How are you results different than in PC4?
pop.norm <- rnorm(n=10000, mean=42, sd=42)

hist(sapply(rep(1, 100), function (x) { mean(sample(pop.norm, 2))}))
hist(sapply(rep(1, 100), function (x) { mean(sample(pop.norm, 10))}))
hist(sapply(rep(1, 100), function (x) { mean(sample(pop.norm, 100))}))

