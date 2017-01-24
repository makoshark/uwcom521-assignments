## PC2. Load both datasets into R as separate data frames. Explore the
## data to get a sense of the structure of the data. What are the
## columns, rows, missing data, etc? Write code to take (and then
## check/look at) several random subsamples of the data.

list.files()

mobile <- read.csv("COS-Statistics-Mobile_Sessions.csv")
total <- read.csv("COS-Statistics-Top5000-Pages.csv")

summary.df <- function (d) {
    print(nrow(d))
    print(ncol(d))
    print(head(d))
    print(d[sample(seq(1, nrow(d)), 5),])
}

## run these two lines a few times to look at the numbers
summary.df(mobile)
summary.df(total)
    
## PC3. Using the top 5000 dataset, create a new data frame that one
## column per month (as described in the data) and a second column is
## the total number of views made to all pages in the dataset over
## that month.

## first create a table/array using tapply
total.views.bymonth.tbl <- tapply(total$Pageviews, total$Month, sum)
total.views.bymonth.tbl

## now construct a data frame
total.views <- data.frame(months=names(total.views.bymonth.tbl),
                          total=total.views.bymonth.tbl)

## zero out the rownames so it looks a bit better (this would all work
## the same if i didn't do this part)
rownames(total.views) <- NULL

head(total.views)

## PC4. Using the mobile dataset, create a new data frame where one
## column is each month described in the data and the second is a
## measure (estimate?) of the total number of views made by mobiles
## (all platforms) over each month. This will will involve at least
## two steps since total views are included. You'll need to first use
## the data there to create a measure of the total views per platform.

## first, multiply sessions by pages per session to get an estimate of
## total pages
mobile$total.pages <- mobile$Sessions * mobile$PagesPerSession 

# see above, this is more or less copy/pasted from above
mobile.views.bymonth.tbl <- tapply(mobile$total.pages, mobile$Month, sum)
mobile.views.bymonth.tbl

mobile.views <- data.frame(months=names(mobile.views.bymonth.tbl),
                           mobile=mobile.views.bymonth.tbl)


## PC5. Merge your two datasets together into a new dataset with
## columns for each month, total views (across the top 5000 pages) and
## total mobile views. Are there are missing data? Can you tell why?

views <- merge(mobile.views, total.views, all.x=TRUE, all.y=TRUE, by="months")

## these don't sort well at the moment because they're not really
## dates, so lets recode them
views$months <- as.Date(views$months, format="%m/%d/%Y %H:%M:%S")

## as then sort them
views <- views[sort.list(views$months),]

## there's one line that is all missing, so lets drop that
views <- views[apply(views, 1, function (x) {!all(is.na(x))}),]

## inspect it, looks like there's some missing data. lets drop
## that. there are a few ways but complete.cases() might make most
## cases
views.complete <- views[complete.cases(views),]

## PC6. Create a new column in your merged dataset that describes your
## best estimate of the proportion (or percentage, if you really
## must!) of views that comes from mobile. Be able to talk about the
## assumptions you've made here. Make sure that date, in this final
## column, is a date or datetime object in R.

views.complete$pct.mobile <- views.complete$mobile / views.complete$total
    
## PC6. Graph this over time and be ready to describe: (a) your best
## estimate of the proportion of views from mobiles to the Seattle
## City website over time and (b) an indication of whether it's going
## up or down.

library(ggplot2)
ggplot(data=views.complete) + aes(x=months, y=pct.mobile) + geom_point() + scale_y_continuous(limits=c(0, 1))



