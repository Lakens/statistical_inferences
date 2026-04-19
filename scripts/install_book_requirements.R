requirements_file <- "requirements-r.txt"

if (!file.exists(requirements_file)) {
  stop("Could not find requirements file: ", requirements_file)
}

required_packages <- readLines(requirements_file, warn = FALSE)
required_packages <- trimws(required_packages)
required_packages <- required_packages[nzchar(required_packages)]
required_packages <- required_packages[!grepl("^#", required_packages)]

installed <- rownames(installed.packages())
missing_cran <- setdiff(required_packages, installed)

if (length(missing_cran) > 0) {
  message("Installing missing CRAN packages: ", paste(missing_cran, collapse = ", "))
  install.packages(
    missing_cran,
    repos = "https://cloud.r-project.org",
    dependencies = TRUE
  )
} else {
  message("All CRAN packages already installed.")
}

installed_after <- rownames(installed.packages())
still_missing <- setdiff(required_packages, installed_after)

if (length(still_missing) > 0) {
  stop(
    "Failed to install required packages: ",
    paste(still_missing, collapse = ", ")
  )
}

message("Done. You can now render with: quarto render")
