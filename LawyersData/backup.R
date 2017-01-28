
# (a) Load the lawyers’ data into R. What proportion of the lawyers practice litigation law?
# (Give your answer to 2 decimal places.)
litigation_lawyer_proportion <- round(nrow(subset(lawyers_data, Practice == 'Litigation'))/nrow(lawyers_data), 2)
print(litigation_lawyer_proportion)
# 0.58
print_answer('1.a.1 - proportion of lawyers who practice litigation', litigation_lawyer_proportion)

# Is the proportion of lawyers in the Boston office that practice corporate law higher than
# the proportion of lawyers in the Providence office that practice corporate law? [6/2 marks]
boston_corporate_lawyer_proportion <- round(nrow(subset(lawyers_data, Practice == 'Corporate' & Office== 'Boston'))/nrow(lawyers_data), 2)
print(boston_corporate_lawyer_proportion)
providence_corporate_lawyer_proportion <- round(nrow(subset(lawyers_data, Practice == 'Corporate' & Office== 'Providence'))/nrow(lawyers_data), 2)
print(providence_corporate_lawyer_proportion)
max_proportion_town <- ifelse(boston_corporate_lawyer_proportion > providence_corporate_lawyer_proportion, 'Boston',
    ifelse(boston_corporate_lawyer_proportion < providence_corporate_lawyer_proportion, 'Providence', 'Same'))
print(max_proportion_town)
# "Boston"
print_answer('1.a.2 - higher proportion of lawyers who practice corporate law between Boston and Providence', max_proportion_town)

# (b) Use the aggregate function to compute the average age of lawyers who
# practice corporate law and of lawyers who practice litigation law, across
# the different levels of seniority. Label the columns of the resulting data
# frame appropriately.

lawyer_practice_seniority_for_age_data = aggregate(Age~Practice+Seniority, data=lawyers_data, mean)
print_answer('1.b.1 - compute the average age of lawyers who practice corporate law and of lawyers who practice litigation law, across the different levels of seniority', '')
print(lawyer_practice_seniority_for_age_data)
#Practice Seniority      Age
#1  Corporate Associate 36.71429
#2 Litigation Associate 34.61905
#3  Corporate   Partner 48.50000
#4 Litigation   Partner 47.70000

# Are associates who practice litigation law younger or older than associates who practice corporate law?
associate_lawyers <- subset(lawyer_practice_seniority_for_age_data, Seniority == 'Associate')$Age
min_litigation_associates_v_corporate_associates <- ifelse(associate_lawyers[1] < associate_lawyers[2], 'Older',
    ifelse(associate_lawyers[1] > associate_lawyers[2], 'Younger', 'Same'))
print(min_litigation_associates_v_corporate_associates)
# "Younger"
print_answer('1.b.2 - Are associates who practice litigation law younger or older than associates who practice corporate law?', min_litigation_associates_v_corporate_associates)

# Which office has the youngest median age? [6/2 marks]
lawyer_office_median_for_age_data = aggregate(Age~Office, data=lawyers_data, median)
print(lawyer_office_median_for_age_data)
# Office  Age
# 1     Boston 39.5
# 2    Harvard 38.0
# 3 Providence 46.0
youngest_media_age <- lawyer_office_median_for_age_data[lawyer_office_median_for_age_data$Age == min(lawyer_office_median_for_age_data$Age),]
print(youngest_media_age$Office)
# Harvard
print_answer('1.b.c - Which office has the youngest median age?', youngest_media_age$Office)

# (c) Use par(mfrow=c(1,2)) to create a 1 × 2 plotting matrix.
# The left-hand plot should contain a bar plot of the lawyers’ gender, by their seniority.
# The right hand plot should contain a box plot of the age of the lawyers, by gender.
# Label axes, include titles and legends, and use colour.
# Comment on the resulting plots. [8/3 marks]
par(mfrow=c(1,2))

gender_by_seniority <- table(lawyers_data$Seniority, lawyers_data$Gender)
print(gender_by_seniority)
summary(gender_by_seniority)
barplot(gender_by_seniority, main="Gender by Seniority",
        xlab="Gender", ylab="Seniority", col=c("darkblue","red"),
        legend = rownames(gender_by_seniority))

