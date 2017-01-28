par(mfrow=c(1,2))

gender_by_seniority <- table(lawyers_data$Seniority, lawyers_data$Gender)
barplot(gender_by_seniority, main="Gender by Seniority",
        xlab="Gender", ylab="Seniority", col=c("darkblue","red"),
        legend = rownames(gender_by_seniority))

age_by_gender <- table(lawyers_data$Gender, lawyers_data$Age)
barplot(age_by_gender, main="Age by Gender",
        xlab="Age", ylab="Gender", col=c("darkblue","red"),
        legend = rownames(age_by_gender))
