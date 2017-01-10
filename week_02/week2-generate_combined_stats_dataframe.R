# this file will create a new dataframe with the list of students and
# some basic summary stats for each students variable

com521.students <- c("anissa", "beth", "emilia", "janny", "kevin",
                      "kyle", "lauren", "luyue", "maggie", "matthew", "polly", "tanya")

generate.summary.stats.for.student <- function (student.name) {
    file.name <- paste("week2_dataset-", student.name, ".RData", sep="")
    load(file.name)
    
    sum.stats.df <- data.frame(student=student.name,
                               mean=mean(week2.dataset),
                               median=median(week2.dataset),
                               var=var(week2.dataset),
                               sd=sd(week2.dataset),
                               IQR=IQR(week2.dataset))
    return(sum.stats.df)
}


do.call("rbind", lapply(com521.students, generate.summary.stats.for.student))

