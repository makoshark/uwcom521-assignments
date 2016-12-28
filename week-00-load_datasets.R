# load up the initial packages
install.packages("UsingR")
install.packages("openintro")

library(openintro)
library(UsingR)

# test code to try something out
median(rivers)
mean(rivers)
sd(rivers)
range(rivers)

# draw a boxplot
boxplot(rivers)

# draw a histogram
hist(rivers)

# draw a histogram of the log rivers
hist(log(rivers))
