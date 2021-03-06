# So swirl does not repeat execution of plot commands

# Returns TRUE if e$val is identical to the value that would
# have been created by the correct expression.
creates_val_identical_to <- function(correctExpr){
  e <- get("e", parent.frame())
  correctVal <- eval(parse(text=correctExpr), cleanEnv(e$snapshot))
  results <- expectThat(e$val,
                        is_identical_to_legacy(correctVal, label=correctExpr),
                        label=deparse(e$expr))
  return(results$passed)
}


# Returns TRUE if e$expr matches any of the expressions given
# (as characters) in the argument.
ANY_of_exprs <- function(...){
  e <- get("e", parent.frame())
  any(sapply(c(...), function(expr)omnitest(expr)))
}

# Get the swirl state
getState <- function(){
  # Whenever swirl is running, its callback is at the top of its call stack.
  # Swirl's state, named e, is stored in the environment of the callback.
  environment(sys.function(1))$e
}

# Get the value which a user either entered directly or was computed
# by the command he or she entered.
getVal <- function(){
  getState()$val
}

# Get the last expression which the user entered at the R console.
getExpr <- function(){
  getState()$expr
}

COURSE = 'regression_residual_variation'

loadDigest <- function(){
  if (!require("digest")) install.packages("digest")
  library(digest)
}

dbs_on_demand <- function(){
  loadDigest()
  selection <- getState()$val
  if(selection == "Yes"){
    course <- COURSE
    email <- readline("What is your email address? ")
    student_number <- readline("What is your student number? ")
    hash <- digest(paste(course, student_number), "md5", serialize = FALSE)

    url <- paste('http:///results.dbsdataprojects.com/course_results/submit?course=', course, '&hash=', hash, '&email=', email, '&student_number=', student_number, sep='')

    respone <- httr::GET(url)
    if(respone$status_code >= 200 && respone$status_code < 300){
      message("Grade submission succeeded!")
    } else {
      message(respone)
      message("Grade submission failed.")
      message("Press ESC if you want to exit this lesson and you")
      message("want to try to submit your grade at a later time.")
      return(FALSE)
    }
  }
  TRUE
}
