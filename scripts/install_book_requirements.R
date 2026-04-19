required_packages <- c(
  "BEST",
  "binom",
  "BUCSS",
  "cocor",
  "effectsize",
  "extrafont",
  "gert",
  "ggplot2",
  "gridExtra",
  "JustifyAlpha",
  "kableExtra",
  "knitr",
  "MBESS",
  "metafor",
  "MOTE",
  "patchwork",
  "puniform",
  "pwr",
  "pwrss",
  "reshape2",
  "rmarkdown",
  "rpact",
  "Superpower",
  "tidyr",
  "TOSTER",
  "truncnorm",
  "zcurve"
)

cran_only <- setdiff(required_packages, "BEST")
installed <- rownames(installed.packages())
missing_cran <- setdiff(cran_only, installed)

if (length(missing_cran) > 0) {
  message("Installing missing CRAN packages: ", paste(missing_cran, collapse = ", "))
  install.packages(missing_cran, repos = "https://cloud.r-project.org")
} else {
  message("All CRAN packages already installed.")
}

# BEST 0.5.4 is used in this book and depends on rjags/JAGS.
if (!"BEST" %in% rownames(installed.packages())) {
  if (!"remotes" %in% rownames(installed.packages())) {
    install.packages("remotes", repos = "https://cloud.r-project.org")
  }

  message("Attempting to install BEST 0.5.4 from CRAN archive.")
  message("If this fails, install JAGS first: https://sourceforge.net/projects/mcmc-jags/files/")
  remotes::install_version("BEST", version = "0.5.4", repos = "https://cloud.r-project.org")
} else {
  message("BEST already installed.")
}

message("Done. You can now render with: quarto render")
