library(rdhs)
library(tidyverse)
library(survey)


datasets <- dhs_datasets(fileFormat = "FL", fileType = c("PR", "IR"))

datasets <-
  datasets %>%
  filter(CountryName=="Nepal") %>%
  filter(SurveyYearLabel==2011)

## login
set_rdhs_config(email = "eric.green@duke.edu",
                project = "open source textbook on global health research methods",
                config_path = "rdhs.json",
                global=FALSE)

downloads <- get_datasets(datasets$FileName)
str(downloads)

# read in first dataset
nepdhs11PR <- readRDS(downloads$NPPR60FL)
nepdhs11IR <- readRDS(downloads$NPIR60FL)

# DHS 6
# https://dhsprogram.com/pubs/pdf/DHSG4/Recode6_DHS_22March2013_DHSG4.pdf

nepdhs11PR <-
nepdhs11PR %>%
  dplyr::select(hhid, hv001, hv002, hvidx, hv116, hv105, hv117)

nepdhs11IR <-
nepdhs11IR %>%
  dplyr::select(caseid, v001, v002, v003, v005, v313)

nepdhs11 <-
  # merge PR and IR
  nepdhs11PR %>%
  right_join(nepdhs11IR, by = c("hv001" = "v001",
                               "hv002" = "v002",
                               "hvidx" = "v003"),
             keep = TRUE) %>%
  # eligible for women's survey
  filter(haven::as_factor(hv117) == "eligible") %>%
  # filter to currently married
  filter(haven::as_factor(hv116) == "currently married") %>%
  # filter age
  filter(hv105 >= 15 & hv105 <= 49) %>%
  mutate(modern = ifelse(haven::as_factor(v313) == "modern method", 1, 0)) %>%
  mutate(age = as.numeric(hv105)) %>%
  mutate(weight = v005/1e6)

des <- svydesign(~hv001, data=nepdhs11, weights=~weight)

# logistic
  #des <- update(des, v106 = relevel(v106, "primary"))
  m <- svyglm(modern ~ age, des, family="binomial")
  ggpredict(m, c("age")) %>%
    plot(limits = c(0, 1),
         colors = c("#1f9ac9ff")
         ) +
      labs(
        x = "Age",
        y = "Probability of current use",
        title = "Predicted probabilities of use of modern method of contraception"
      )
