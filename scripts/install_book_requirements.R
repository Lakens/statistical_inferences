required_packages <- c(
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

installed <- rownames(installed.packages())
missing_cran <- setdiff(required_packages, installed)

if (length(missing_cran) > 0) {
  message("Installing missing CRAN packages: ", paste(missing_cran, collapse = ", "))
  install.packages(missing_cran, repos = "https://cloud.r-project.org")
} else {
  message("All CRAN packages already installed.")
}

message("Done. You can now render with: quarto render")
