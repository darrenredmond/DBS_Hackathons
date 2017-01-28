# For compatibility with 2.2.21
.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) {file.path(find.package("swirl"),"Courses")}
  )
}

# lawyers data
lawyers_data <- read.csv(file.path(.get_course_path(), "DBS_Hackathons", "LawyersData", "LawyersData.csv"))

