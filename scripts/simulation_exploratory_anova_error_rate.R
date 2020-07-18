# Error Simulations

nsims = 10000
alpha_level = 0.05
library(Superpower)

#8.1
string <- "2b*2b*2b"
n <- 50
mu <- c(20, 20, 20, 20, 20, 20, 20, 20) 
# All means are equal - so there is no real difference.
# Enter means in the order that matches the labels below.
sd <- 5
p_adjust = "none"
# "none" means we do not correct for multiple comparisons
labelnames <- c("condition1", "a", "b", 
                "condition2", "c", "d", 
                "condition3", "e", "f") #
# The label names should be in the order of the means specified above.
design_result <- ANOVA_design(design = string,
                              n = n, 
                              mu = mu, 
                              sd = sd, 
                              labelnames = labelnames)
alpha_level <- 0.05
#We set the alpha level at 0.05. 

simulation_result_8.1 <- ANOVA_power(design_result,
                                     alpha_level = alpha_level,
                                     verbose = FALSE,
                                     nsims = nsims)

#8.2
string <- "2b*2b*2b"
n <- 50
mu <- c(20, 20, 20, 20, 20, 20, 20, 20) 
#All means are equal - so there is no real difference.
# Enter means in the order that matches the labels below.
sd <- 5
p_adjust = "holm"
# Changed to Holm-Bonferroni
labelnames <- c("condition1", "a", "b", 
                "condition2", "c", "d", 
                "condition3", "e", "f") #
# the label names should be in the order of the means specified above.
design_result <- ANOVA_design(design = string,
                              n = n, 
                              mu = mu, 
                              sd = sd, 
                              labelnames = labelnames)
alpha_level <- 0.05


simulation_result_8.2 <- ANOVA_power(design_result, 
                                     alpha_level = alpha_level,
                                     p_adjust = p_adjust,
                                     verbose = FALSE,
                                     nsims = nsims)

save.image("data/error_data.Rdata")