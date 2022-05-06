

# Bayesian statistics{#bayes}

>"Logic!" said the Professor half to himself. "Why don't they teach logic at these schools? There are only three possibilities. Either your sister is telling lies, or she is mad, or she is telling the truth. You know she doesn't tell lies and it is obvious that she is not mad. For the moment then and unless any further evidence turns up, we must assume that she is telling the truth."

*[The Lion, The Witch, and The Wardrobe. A Story for Children](https://gutenberg.ca/ebooks/lewiscs-thelionthewitchandthewardrobe/lewiscs-thelionthewitchandthewardrobe-00-h.html) by C. S. Lewis.*

In the children's book The Lion, The Witch, and The Wardrobe, both Lucy and Edmund go through a wardrobe into a country called Narnia. Lucy tells her older brother and sister, Peter and Susan, about Narnia, but Edmund wants to keep it a secret, and tells Peter and Susan he and Lucy were just pretending Narnia exists. Peter and Susan don't know what to believe - does Narnia exist, or not? Is Lucy telling the truth, or is Edmund? Thinking about probabilities in the long run will not help much - this is a unique event, and we will need to think about the probability that Narnia exists, or not, based on the information we have available. 

They ask the Professor, who lives in the house with the wardrobe, for advice. The Professor asks Susan and Peter if in their past experience, Lucy or Edward has been more truthful, to which Peter answers "Up till now, I'd have said Lucy every time." So, they have a stronger prior belief Lucy is telling the truth, relative to Edward telling the truth. The Professor then replies with the quote above. From the three possible options, we don't believe Lucy is lying, as she has not done so in the past, and the Professor believes it is clear just from talking to Lucy that she is not mad. Therefore, the most plausible option is that Lucy is telling the truth. If new evidence is uncovered, these beliefs can be updated in the future. This approach to knowledge generation, where the prior probability of different hypotheses is quantified, and if possible updated in light of new data, is an example of *Bayesian inference*.  

Although frequentist statistics is by far the dominant approach in science, it is important to have had at least rudimentary exposure to Bayesian statistics during any statistics training. Bayesian statistics is especially useful when inferences are made in cases where the data under investigation is unique, and there is no frequentist probability defined as the limit in many trials. For example, the question might not be how often Lucy lies on average, but whether Lucy is lying in this specific instance about the existence of Narnia. When we do research, we often start with a prior belief that a hypothesis is true. After collecting data, we can use this data to update our prior beliefs. Bayesian statistics allows you to update prior beliefs into posterior probabilities in a logically consistent manner. Before we have collected data, the **prior odds** of Hypothesis 1 ($H_1$) over the null-hypothesis ($H_0$) are P($H_1$)/P($H_0$), After we have collected data, we have the **posterior odds** P($H_1$\|D)/P($H_0$\|D), which you can read as the probability of $H_1$, given the data, divided by the probability of $H_0$, given the data. There are different approaches to Bayesian statistics. We will first discuss Bayes factors, and then Bayesian estimation.

## Bayes factors

One approach in Bayesian statistics focuses on the comparison of different models that might explain the data (referred to as **model comparison**). In Bayesian statistics, the probability of data under a specified model (D\|P($H_0$) is a number that expressed what is sometimes referred to as the absolute **evidence**, and more formally referred to as a marginal likelihood. The marginal likelihood uses prior probabilities to average the likelihood across the parameter space. For example, assume we have a simple model *M* that is based on a single parameter, that can take on two values, X and Y, and that a-prior we believe the probability of both values is p(X) = 0.4 and p(Y) = 0.6. We collect data, and calculate the likelihood for both these parameter values, which is p(D\|X) = 0.02 and p(D\|Y) = 0.08. The marginal likelihood of our model *M* is then P(D\|M) = 0.4 × 0.02 + 0.6 × 0.08 = 0.056. Most often, models have continuously varying parameters, and the marginal likelihood formula is based on an integral, but the idea remains the same.

A comparison of two models is based on the relative evidence the data provides for each models we are comparing. The relative evidence is calculated by dividing the marginal likelihood for one model by the marginal likelihood for another model, and this ratio of relative evidence based on these marginal likelihoods is called the **Bayes factor**. Bayes factors are the Bayesian equivalent of hypothesis tests [@dienes_understanding_2008; @kass_bayes_1995]. The Bayes factor represents how much we have updated our beliefs, based on observing the data. We can express Bayes factors to indicate how much more likely $H_1$ is given the data compared to $H_0$ (often indicated by B10) or as how much more likely $H_0$ has become compared to $H_1$ (B01), and B10 = 1/B01. Similar to likelihood ratios of 1, a Bayes factor of 1 did not change our beliefs for one model compared to the other model. A very large Bayes factor for $H_1$ over $H_0$ has increased our belief in $H_1$, and a Bayes Factor close for $H_1$ over $H_0$ to 0 has increased our belief in $H_0$. If our prior belief in $H_1$ was very, very low (e.g., your belief in unicorns) even a large Bayes factor that supports the presence of a unicorn might not yet convince you that unicorns are real – but you have updated your belief in unicorns, and now believe they are at least more likely then they were before (even if you still think unicorns are very unlikely to exist). The contribution of the Bayes Factor and the prior in calculating the posterior odds is clear in the following formula:

$$
\frac{P(H_1|D)}{P(H_0|D)} = \ \frac{P(D|H_1)}{P(D|H_0)}\  \times \ \frac{P(H_1)}{P(H_0)}
$$

$$
Posterior\ Probability = \ Bayes\ Factor\  \times \ Prior\ Probability
$$

A Bayesian analysis of data requires specifying the prior. Here, we will continue our example based on a binomial probability, such as a coin flip. In the likelihood example, we compared two point hypotheses (e.g., *p* = 0.5 vs. *p* = 0.8). In Bayesian statistics, parameters are considered to be random variables, and the uncertainty or degree of belief with respect to the parameters is quantified by **probability distributions**.

A binomial probability lies between 0 and 1. You could draw any probability density you want over 0 and 1, and turn it into a prior, but for good reasons (simplicity, mostly) a beta-prior is often used for binomial probabilities. The shape of the beta-prior depends on two parameters, $\alpha$ and $\beta$. Note that these are the same Greek letters as used for the Type 1 error rate and Type 2 error rate, but that is purely coincidental! The $\alpha$ and $\beta$ in binomial probabilities are unrelated to error rates, and the use of the same letters is mainly due to a lack of creativity among statisticians and the limited choice the alphabet gives us. It also does not help that $\beta$ is one of the parameters of the Beta distribution. Try to keep these different Beta’s apart! The probability density function is:

$$
\int_{}^{}{\left( x,\ \alpha,\ \beta \right) = \ \frac{1}{B(\alpha,\beta)}}x^{\alpha - 1}{(1 - x)}^{\beta - 1}
$$

where *B($\alpha$, $\beta$)* is the beta function. Understanding the mathematical basis of this function is beyond the scope of this chapter, but you can read more on [Wikipedia](https://en.wikipedia.org/wiki/Beta_distribution) or Kruschke's book on Doing Bayesian Data Analysis [@kruschke_doing_2014]. The beta-prior for a variety of values for $\alpha$ and $\beta$ can be seen in the figure below.



(ref:bayes1lab) Four examples of Bayesian priors

<div class="figure" style="text-align: center">
<img src="04-bayes_files/figure-html/bayes1-1.png" alt="(ref:bayes1lab)" width="100%" />
<p class="caption">(\#fig:bayes1)(ref:bayes1lab)</p>
</div>

These beta densities reflect different types of priors. Let’s assume you are approached by a street merchant who tries to sell you a special coin with heads and tails that, when flipped, will almost always turn up heads. The $\alpha$ = 1, $\beta$ = 1 prior is what a newborn baby would have as a prior, without any idea of what to expect when you flip a coin, and thus every value of *p* is equally likely. The $\alpha$ = 1, $\beta$ = 1/2 prior is what a true believer would have as a prior. The sales merchant tells you the coin will turn up heads almost every time, and thus, you believe it will turn up heads almost every time. The $\alpha$ = 4, $\beta$ = 4, and the $\alpha$ = 100, $\beta$ = 100 priors are for slightly and extremely skeptical people. With an $\alpha$ = 4, $\beta$ = 4 prior, you expect the coin will be fair, but you are willing to believe a wide range of other true values is possible (the curve is centered on 0.5, but the curve is wide, allowing for very high and low values of *p*). With the $\alpha$ = 100, $\beta$ = 100 prior you are really convinced coins are fair, and believe there will be only a very slight bias, at most (the curve is again centered on 0.5, and a skeptic believes the *p* will lie between 0.4 and 0.6 – a much narrower range compared to the slightly skeptic individual).

Let’s assume the newborn baby, the true believer, the slightly skeptic and the extreme skeptic all buy the coin, flip it n = 20 times, and observe x = 10 heads. This outcome can be plotted as a binomial distribution with 10 heads out of 20 trials, or as a Beta(11, 11) distribution.

The newborn baby had a prior Beta distribution with $\alpha$ = 1 and $\beta$ = 1, which equals a binomial likelihood distribution for 0 heads out of 0 trials. The posterior is a Beta distribution with Beta($\alpha$\*, $\beta$\*), where:

$\alpha$\* = $\alpha$ + x = 1 + 10= 11

$\beta$\* = $\beta$ + n – x = 1 + 20 – 10 = 11

Or calculating these values more directly from the $\alpha$ and $\beta$ of the prior and
likelihood:

$\alpha$\* = $\alpha$prior + $\alpha$likelihood – 1 = 1 + 11 - 1= 11

$\beta$\* = $\beta$prior + $\beta$likelihood - 1 = 1 + 11 – 1 = 11

Thus, the posterior distribution for the newborn is a Beta(11,11) distribution. This equals a binomial likelihood function for 10 heads out of 20 trials, or Beta(11,11) distribution. In other words, the posterior distribution is identical to the likelihood function when a uniform prior is used.

Take a look at the Figure below. Given 10 heads out of 20 coin flips, we see the prior distribution of the newborn (the horizontal grey line), the likelihood (the blue dotted line) and the posterior (the black line).



(ref:bayes2lab) Four examples of how different priors are updated based on data to the posterior.

<div class="figure" style="text-align: center">
<img src="04-bayes_files/figure-html/bayes2-1.png" alt="(ref:bayes2lab)" width="100%" />
<p class="caption">(\#fig:bayes2)(ref:bayes2lab)</p>
</div>

For the true believer the posterior distribution is not centered on the maximum likelihood of the observed data, but just a bit in the direction of the prior. The slightly skeptic and the strong skeptic end up with a much stronger belief in a fair coin after observing the data, but mainly because they already had a stronger prior that the coin was fair.

## Updating our belief

Now that we have a distribution for the prior, and a distribution for the posterior, we can see in the graphs below for which values of *p* our belief has increased. Everywhere where the black line (of the posterior) is higher than the grey line (of the prior) our belief in that *p* has increased.



(ref:bayes4lab) Plot for the prior, likelihood, and posterior.

<div class="figure" style="text-align: center">
<img src="04-bayes_files/figure-html/bayes4-1.png" alt="(ref:bayes4lab)" width="100%" />
<p class="caption">(\#fig:bayes4)(ref:bayes4lab)</p>
</div>

The Bayes Factor is used to quantify this increase in relative evidence. Let’s calculate the Bayes Factor for the hypothesis that the coin is fair for the newborn. The Bayes Factor is simply the value of the posterior distribution at *p* = 0.5, divided by the value of the prior distribution at *p* = 0.5:

BF10 = Beta(*p* = 0.5, 11, 11)/Beta(*p* = 0.5, 1, 1) = 3.70/1 = 3.70

You can check this in an [online Bayes Factor calculator](http://pcl.missouri.edu/bf-binomial) [@rouder_bayesian_2009]. At successes, fill in 10, at trials, fill in 20. We want to calculate the Bayes Factor for the point null value of *p* = 0.5, so fill in 0.5. The $\alpha$ and $\beta$ for the prior are both 1, given the newborns prior of Beta(1,1). Clicking ‘submit query’ will give you the Bayes factor of 3.70.



(ref:gpower-screenshot-bayeslab) Screenshot of the online calculator for binomially distributed observations

<div class="figure" style="text-align: center">
<img src="images/binombayesonline.png" alt="(ref:gpower-screenshot-bayeslab)" width="100%" />
<p class="caption">(\#fig:gpower-screenshot-bayes)(ref:gpower-screenshot-bayeslab)</p>
</div>

We can calculate and plot the Bayes Factor, and show the prior (grey), likelihood (dashed blue) and posterior (black). For the example of 20 flips, 10 heads, and the newborn prior, the plot looks like this:



(ref:bayes6lab) Plot for the prior, likelihood, and posterior.

<div class="figure" style="text-align: center">
<img src="04-bayes_files/figure-html/bayes6-1.png" alt="(ref:bayes6lab)" width="100%" />
<p class="caption">(\#fig:bayes6)(ref:bayes6lab)</p>
</div>

We see that for the newborn, *p* = 0.5 has become more probable, but so has *p* = 0.4. Now let’s assume the strong skeptic, who believes the coin is fair with a prior of Beta(100, 100), buys the coin and flips it 100 times. Surprisingly, the coin comes up heads 90 out of 100 flips. The plot of the prior, likelihood, and posterior now looks much more extreme, because we had a very informed prior, and extremely different data. We see the grey prior distribution, the dashed blue likelihood based on the data, and the posterior distribution in black. The Bayes Factor of 0 represents the substantial drop in belief that the coin is fair – indeed, this now seems an untenable hypothesis, even for the strong skeptic. It shows how data can update your belief. Where a newborn would now completely believe that the true *p* for the coin is somewhere around 0.9, the strong skeptic has more reason to believe the *p* is around 0.65, due to the strong prior conviction that the coin is fair. Given enough data, even this strong skeptic will become convinced that the coin will return heads most of the time as well.

(ref:bayes7lab) Plot for the prior, likelihood, and posterior.

<div class="figure" style="text-align: center">
<img src="04-bayes_files/figure-html/bayes7-1.png" alt="(ref:bayes7lab)" width="100%" />
<p class="caption">(\#fig:bayes7)(ref:bayes7lab)</p>
</div>

We can now also see the difference between a likelihood inference approach, and a Bayesian inference approach. In likelihood inference, you can compare different values of *p* for the same likelihood curve (e.g., *p* = 0.5 vs *p* = 0.8) and calculate the likelihood ratio. In Bayesian inference, you can compare the difference between the prior and the posterior for the same value of *p*, and calculate the Bayes Factor.

If you have never seen Bayes Factors before, you might find it difficult to interpret the numbers. As with any guideline (e.g., interpreting effect sizes as small, medium, and large) there is criticism on the use of benchmarks. On the other hand, you have to start somewhere in getting a feel for what Bayes Factors mean. A Bayes factor between 1 and 3 is considered ‘not worth more than a bare mention’, larger than 3 (or smaller than 1/3) is considered ‘substantial’, and larger than 10 (or smaller than 1/10) is considered ‘strong’ [@jeffreys_theory_1939]. These labels refer to the increase in how much you believe a specific hypothesis, not in the posterior belief in that hypothesis. If you think extra-sensory perception is extremely implausible, a single study with a BF = 14 will increase your belief, but you will now think extra-sensory perception is pretty much extremely implausible.

Bayes factors are often promoted as an alternative to *p*-values. One stated benefit is that they can provide support both for the alternative, as for the null [@dienes_using_2014]. However, the same can be achieved with frequentist equivalence tests, as we will see in the chapter on [equivalence testing](#equivalencetest), and inferences based on Bayes factors and equivalence tests typically lead to the same conclusions [@lakens_improving_2020]. Another reason that some people give to switch to Bayes factors instead of *p*-values is that, as we saw in the chapter on [*p*-values](#misconceptions), *p*-values are often misunderstood. However, not surprisingly, Bayes factors are at least as often misunderstood and misused [@wong_potential_2021]. Statistical inferences are hard, and thinking about probabilities is not something we get right by trusting our intuition. We need to train ourselves to draw correct inferences, and switching to a different statistic will not prevent misuse. 

## Bayesian Estimation {#bayesest}

The posterior distribution summarizes our belief about the expected number of heads when flipping a coin after seeing the data, by averaging over our prior beliefs and the data (or the likelihood). The mean of a Beta distribution can be calculated by $\alpha$/($\alpha$+$\beta$). We can thus easily calculate the mean of a posterior distribution, which is the expected value based on our prior beliefs and the data.

We can also calculate a **credible interval** around the mean, which is a Bayesian version of a confidence interval with a slightly different interpretation. Instead of the Frequentist interpretation where a parameter has one (unknown) true value, the Bayesian approach considers the data fixed, but allow the parameter to vary. In Bayesian approaches, probability distributions represent our degree of belief. When calculating a credible interval, one is saying ‘I believe it is 95% probable (given my prior and the data) that the true parameter falls within this credible interval’. A 95% credible interval is simply the area of the posterior distribution between the 0.025 and 0.975 quantiles.

A credible interval and a confidence interval are the same, when a uniform prior (e.g., Beta(1,1)) is used. In this case, credible interval is numerically identical to the confidence interval. Only the interpretation differs. Whenever an informed prior is used, the credible interval and confidence interval differ. If the chosen prior is not representative of the truth, the credible interval will not be representative of the truth, but it is always a correct formalization of your beliefs. For a single confidence interval, the probability that it contains the true population parameter is either 0 or 1. Only in the long run will 95% of confidence intervals contain the true population parameter. These are important differences between Bayesian credible intervals and Frequentist confidence intervals to keep in mind.

We can plot the mean for the posterior when 10 heads out of 20 coin flips are observed, given a uniform prior. 



(ref:bayes8lab) Plot for the mean of the posterior when 10 out of 20 heads are observed given a uniform prior.

<div class="figure" style="text-align: center">
<img src="04-bayes_files/figure-html/bayes8-1.png" alt="(ref:bayes8lab)" width="100%" />
<p class="caption">(\#fig:bayes8)(ref:bayes8lab)</p>
</div>

We can also use the ‘binom’ package to calculate the posterior mean, credible interval, and **highest density interval (HDI)**. The highest density interval is an alternative to the credible interval that works better when the posterior beta distribution is skewed (and is identical when the posterior distribution is symmetrical. We won’t go into the calculations of the HDI here.


```r
library(binom)

n <- 20 # set total trials
x <- 10 # set successes
aprior <- 1 # Set the alpha for the Beta distribution for the prior
bprior <- 1 # Set the beta for the Beta distribution for the prior

binom.bayes(x, n, type = "central", prior.shape1 = aprior, prior.shape2 = bprior)
```

<div class="kable-table">

|method |  x|  n| shape1| shape2| mean|     lower|     upper|  sig|
|:------|--:|--:|------:|------:|----:|---------:|---------:|----:|
|bayes  | 10| 20|     11|     11|  0.5| 0.2978068| 0.7021932| 0.05|

</div>

```r
binom.bayes(x, n, type = "highest", prior.shape1 = aprior, prior.shape2 = bprior)
```

<div class="kable-table">

|method |  x|  n| shape1| shape2| mean|     lower|     upper|  sig|
|:------|--:|--:|------:|------:|----:|---------:|---------:|----:|
|bayes  | 10| 20|     11|     11|  0.5| 0.2978068| 0.7021932| 0.05|

</div>


The posterior mean is identical to the Frequentist mean, but this is only the case when the mean of the prior equals the mean of the likelihood [@albers_credible_2018]. This chapter shows the essence of Bayesian inference, where we decide upon a prior distribution, collect data and calculate a marginal likelihood, and use these to calculate a posterior distribution. From this posterior distribution, we can estimate the mean and the 95% credible interval. For any specific hypothesis, we can calculate the relative evidence for a posterior model, compared to a prior model, through the Bayes Factor. There are many different flavors of Bayesian statistics, and the disagreements between Bayesians about what the best approach to statistical inferences is, is at least as great as the disagreements between frequentists and Bayesians, and many Bayesians dislike Bayes factors [@mcelreath_statistical_2016]. For example, some Bayesians dislike subjective priors as used in **subjective Bayesian analysis**, and instead prefer what is known as **objective Bayesian analysis** [@berger_interplay_2004]. In your research, you will most likely need other calculations than the binomial example we have used here, and a lot of Bayesian tests are now available in the free open source software package [JASP](https://jasp-stats.org/). The math and the priors become more complex, but the basic idea remains the same. You can use Bayesian statistics to quantify relative evidence, which can inform you how much we should believe, or update our beliefs, in theories.

## Test Yourself

**Q1**: The true believer had a prior of Beta(1,0.5). After observing 10 heads out of 20 coin flips, what is the posterior distribution, given that α\* = α + x and β\* = β + n – x?

A) Beta(10, 10)
B) Beta(11, 10.5)
C) Beta(10, 20)
D) Beta(11, 20.5)

**Q2**: The strong skeptic had a prior of Beta(100,100). After observing 50 heads out of 100 coin flips, what is the posterior distribution, given that α\* = α + x and β\* = β + n – x?

A) Beta(50, 50)
B) Beta(51, 51)
C) Beta(150, 150)
D) Beta(151, 151)

Copy the R script below into R. This script requires 5 input parameters (identical to the Bayes Factor calculator website used above). These are the hypothesis you want to examine (e.g., when evaluating whether a coin is fair, *p* = 0.5), the total number of trials (e.g., 20 flips), the number of successes (e.g., 10 heads), and the $\alpha$ and $\beta$ values for the Beta distribution for the prior (e.g., $\alpha$ = 1 and $\beta$ = 1 for a uniform prior). Run the script. It will calculate the Bayes Factor, and plot the prior (grey), likelihood (dashed blue) and posterior (black). 


```r
H0 <- 0.5 # Set the point null hypothesis you want to calculate the Bayes Factor for
n <- 20 # set total trials
x <- 10 # set successes
aprior <- 1 # Set the alpha for the Beta distribution for the prior
bprior <- 1 # Set the beta for the Beta distribution for the prior

alikelihood <- x + 1 # Calculate the alpha for the Beta distribution for the likelihood
blikelihood <- n - x + 1 # Calculate the beta for the Beta distribution for the likelihood
aposterior <- aprior + alikelihood - 1 # Calculate the alpha for the Beta distribution for the posterior
bposterior <- bprior + blikelihood - 1 # Calculate the beta for the Beta distribution for the posterior

theta <- seq(0, 1, 0.001) #create probability range p from 0 to 1
prior <- dbeta(theta, aprior, bprior)
likelihood <- dbeta(theta, alikelihood, blikelihood)
posterior <- dbeta(theta, aposterior, bposterior)

# Create plot
plot(theta, posterior, ylim = c(0, 15), type = "l", lwd = 3, xlab = "p", ylab = "Density", las = 1)
lines(theta, prior, col = "grey", lwd = 3)
lines(theta, likelihood, lty = 2, lwd = 3, col = "dodgerblue")
BF10 <- dbeta(H0, aposterior, bposterior) / dbeta(H0, aprior, bprior)
points(H0, dbeta(H0, aposterior, bposterior), pch = 19)
points(H0, dbeta(H0, aprior, bprior), pch = 19, col = "grey")
segments(H0, dbeta(H0, aposterior, bposterior), H0, dbeta(H0, aprior, bprior), lty = 2)
title(paste("Bayes Factor:", round(BF10, digits = 2)))
```

<img src="04-bayes_files/figure-html/unnamed-chunk-3-1.png" width="100%" style="display: block; margin: auto;" />

We see that for the newborn, *p* = 0.5 has become more probable, but so has *p* = 0.4.

**Q3**: Change the hypothesis in the first line from 0.5 to 0.675, and run the script. If you were testing the idea that this coin returns 67.5% heads, which statement is true?

A) Your belief in this hypothesis, given the data, would have decreased.
B) Your belief in this hypothesis, given the data, would have stayed the same.
C) Your belief in this hypothesis, given the data, would have increased.

**Q4**: Change the hypothesis in the first line back to 0.5. Let’s look at the increase in the belief of the hypothesis *p* = 0.5 for the strong skeptic after 10 heads out of 20 coin flips. Change the $\alpha$ for the prior in line 4 to 100 and the $\beta$ for the prior in line 5 to 100. Run the script. Compare the Figure from R to the increase in belief for the newborn (in the plot on the previous page). Which statement is true?

A) The belief in the hypothesis that *p* = 0.5, given the data, has **increased** for the strong skeptic, but **not** as much as it has for the newborn.
B) The belief in the hypothesis that *p* = 0.5, given the data, has **increased** for the strong skeptic, **exactly as much** as it has for the newborn.
C) The belief in the hypothesis that *p* = 0.5, given the data, has **increased** for the strong skeptic, and **much more** than it has for the newborn.
D) The belief in the hypothesis that *p* = 0.5, given the data, has **decreased** for the strong skeptic.


Copy the R script below and run it. The script will plot the mean for the posterior when 10 heads out of 20 coin flips are observed, given a uniform prior (as in \@ref(fig:bayes8)) . The script will also use the ‘binom’ package to calculate the posterior mean, credible interval, and **highest density interval (HDI)**. The highest density interval is an alternative to the credible interval that works better when the posterior beta distribution is skewed (and is identical when the posterior distribution is symmetrical. We won’t go into the calculations of the HDI here.


```r
n <- 20 # set total trials
x <- 10 # set successes
aprior <- 1 # Set the alpha for the Beta distribution for the prior
bprior <- 1 # Set the beta for the Beta distribution for the prior

ymax <- 10 # set max y-axis

alikelihood <- x + 1 # Calculate the alpha for the Beta distribution for the likelihood
blikelihood <- n - x + 1 # Calculate the beta for the Beta distribution for the likelihood
aposterior <- aprior + alikelihood - 1 # Calculate the alpha for the Beta distribution for the posterior
bposterior <- bprior + blikelihood - 1 # Calculate the beta for the Beta distribution for the posterior

theta <- seq(0, 1, 0.001) # create probability range p from 0 to 1
prior <- dbeta(theta, aprior, bprior) # deterine prior distribution
likelihood <- dbeta(theta, alikelihood, blikelihood) # determine likelihood distribution
posterior <- dbeta(theta, aposterior, bposterior) # determine posterior distribution
plot(theta, posterior, ylim = c(0, ymax), type = "l", lwd = 3, xlab = bquote(theta), ylab = "Density", las = 1) # draw posterior distribution
lines(theta, prior, col = "grey", lwd = 3) # draw prior distribution
lines(theta, likelihood, lty = 2, lwd = 3, col = "dodgerblue") # draw likelihood distribution
LL <- qbeta(.025, aposterior, bposterior) # calculate lower limit credible interval
UL <- qbeta(.975, aposterior, bposterior) # calculate upper limit credible interval
abline(v = aposterior / (aposterior + bposterior)) # draw line mean
abline(v = LL, col = "grey", lty = 3) # draw line lower limit
abline(v = UL, col = "grey", lty = 3) # draw line upper limit
polygon(c(theta[theta < LL], rev(theta[theta < LL])), c(posterior[theta < LL], rep(0, sum(theta < LL))), col = "lightgrey", border = NA)
polygon(c(theta[theta > UL], rev(theta[theta > UL])), c(posterior[theta > UL], rep(0, sum(theta > UL))), col = "lightgrey", border = NA)
title(paste("Mean posterior:", round((aposterior / (aposterior + bposterior)), digits = 5), ", 95% Credible Interval:", round(LL, digits = 2), ";", round(UL, digits = 2)))
```

<img src="04-bayes_files/figure-html/unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

```r
if (!require(binom)) {
  install.packages("binom")
}
library(binom)
binom.bayes(x, n, type = "central", prior.shape1 = aprior, prior.shape2 = bprior)
```

<div class="kable-table">

|method |  x|  n| shape1| shape2| mean|     lower|     upper|  sig|
|:------|--:|--:|------:|------:|----:|---------:|---------:|----:|
|bayes  | 10| 20|     11|     11|  0.5| 0.2978068| 0.7021932| 0.05|

</div>

```r
binom.bayes(x, n, type = "highest", prior.shape1 = aprior, prior.shape2 = bprior)
```

<div class="kable-table">

|method |  x|  n| shape1| shape2| mean|     lower|     upper|  sig|
|:------|--:|--:|------:|------:|----:|---------:|---------:|----:|
|bayes  | 10| 20|     11|     11|  0.5| 0.2978068| 0.7021932| 0.05|

</div>


The posterior mean is identical to the Frequentist mean, but this is only the case when the mean of the prior equals the mean of the likelihood.

**Q5**: Assume the outcome of 20 coin flips had been 18 heads. Change x to 18 in line 2 and run the script. Remember that the mean of the prior Beta(1,1) distribution is α/(α+β), or 1/(1+1) = 0.5. The Frequentist mean is simply x/n, or 18/20=0.9. Which statement is true?

A) The frequentist mean is **higher** than the mean of the posterior, because by combining the prior with the data, the mean of the posterior is **closer** to the mean of the prior distribution.
B) The frequentist mean is **lower** than the mean of the posterior, because by combining the prior with the data, the mean of the posterior is **closer** to the mean of the prior distribution.
C) The frequentist mean is **higher** than the mean of the posterior, because by combining the prior with the data, the mean of the posterior is **further from** to the mean of the prior distribution.
D) The frequentist mean is **lower** than the mean of the posterior, because by combining the prior with the data, the mean of the posterior is **further from** to the mean of the prior distribution.

**Q6**: What is, today, your best estimate of the probability that the sun rises every day? Assume you were born with an uniform Beta(1,1) prior. The sun can either rise, or it does not. Assume you have seen the sun every day since you were born, which means there has been a continuous string of successes for every day you have been alive. It is ok to estimate the days you have been alive by just multiplying your age by 365 days. What is your best estimate of the probability that the sun will rise?

**Q7**: What would have been the best estimate from a Frequentist perspective?

**Q8**: What do you think the goal of science is? Rozeboom [-@rozeboom_fallacy_1960] has criticized Neyman-Pearson hypothesis testing by stating: 

> But the primary aim of a scientific experiment is not to precipitate decisions, but to make an appropriate adjustment in the degree to which one accepts, or believes, the hypothesis or hypotheses being tested". 

Frick [-@frick_appropriate_1996] has argued against Rozeboom, by stating: 

>Rozeboom (1960) suggested that scientists should not be making decisions about claims, they should be calculating and updating the probability of these claims. However, this does not seem practical. If there were only a handful of potential claims in any given area of psychology, it would be feasible to assign them probabilities, to be constantly updating the probabilities, and to expect experimenters to keep track of these ever-changing probabilities. In fact, just the number of claims in psychology is overwhelming. It would probably be impossible for human beings to keep track of the probability for each claim, especially if these probabilities were constantly changing. In any case, scientists do not assign probabilities to claims. Instead, scientists act like the goal of science is to collect a corpus of claims that are considered to be established (Giere, 1972).

When it comes to philosophy of science, there are no right or wrong answers. Reflect in 250 words on your thoughts about the two goals of science outlines by Rozeboom and Frick, and how these relate to your philosophy of science. 

### Open Questions

1. What is a Bayes factor?

2. What is the difference between a Bayes factor and a likelihood ratio?

3. What does a Bayes factor of 1 mean?

4. What is the prior in Bayesian inference, and is it possible that different people have different priors? 

5. What is the difference between a Frequentist confidence interval and a Bayesian credible interval? 

6. What is the difference between a uniform and informed prior when we compute the posterior distribution?

7. Give a definition of a credible interval.

