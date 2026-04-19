script_args <- commandArgs(trailingOnly = FALSE)
script_file_arg <- grep("^--file=", script_args, value = TRUE)
script_file <- if (length(script_file_arg) > 0) {
	basename(sub("^--file=", "", script_file_arg[[1]]))
} else {
	""
}

if (!identical(script_file, "install_book_requirements.R")) {
	source("R/booktem_setup.R")
	source("R/webex.R")
	source("R/my_setup.R")
}
