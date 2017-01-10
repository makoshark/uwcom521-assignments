# build a matrix with the information
microcontrollers <- matrix(c(890,6724,810,
                             17,178,61,
                             52,382,279),
                           ncol=3)

colnames(microcontrollers) <- c("Arduino", "Both", "Lilypad")
rownames(microcontrollers) <- c("Unknown", "Male", "Female")
microcontrollers

# Q7. Given that a US customer in the dataset has bought a LilyPad
# (either alone or in combination with a "normal" Arduino), what is
# the probability of that that they are female?
sum(microcontrollers["Female",c("Both", "Lilypad")]) / sum(microcontrollers[,c("Both", "Lilypad")])

# Q8. Given that a US customer in the dataset is female, what is the
# probability that they bought a LilyPad (either alone or in
# combination with a "normal" Arduino)?
sum(microcontrollers["Female",c("Both", "Lilypad")]) / sum(microcontrollers["Female",])

# this wasn't part of the problem set but i think it's instructive (I wish I had includded it!)
sum(microcontrollers["Female",c("Arduino")]) / sum(microcontrollers[,c("Arduino")])
sum(microcontrollers["Female",c("Arduino")]) / sum(microcontrollers["Female",])
