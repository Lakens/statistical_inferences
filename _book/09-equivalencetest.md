



# Equivalence Testing {#equivalencetest}

Most scientific studies are designed to test the prediction that an effect or a difference exists. Does a new intervention work? Is there a relationsip between two variables? These studies are analyzed with a commonly analyzed with a null-hypothesis significance test. When a statistically significant *p*-value is observed, the null-hypothesis can be rejected, and researchers claim that the intervention works, or that there is a relationship between two variables. But if the *p*-value is not statistically significant, researcher very often draw a logically incorrect conclusion: They conclude there is no effect based on *p* > 0.05. 

Open a result section of an article you are writing, or the result section of articles you have recently read. Search for *p* > 0.05, and look carefully what you or the scientists concluded. If you see the conclusion that there was 'no effect' or there was 'no association between variables', someone forgot that *absence of evidence is not evidence of absence* [@altman_statistics_1995]. A non-significant result in itself only tells us that we can not reject the null hypothesis. It is tempting to ask after *p* > 0.05 'so, is the true effect zero'? But the *p*-value from a null-hypothesis significance test can not answer that question. It might be useful to think of the answer to the question whether an effect is absent after observing *p* > 0.05 as 無 ([mu](https://en.wikipedia.org/wiki/Mu_(negative)#Non-dualistic_meaning)), used as a non-dualistic answer, neither yes nor no, or 'unasking the question', because it is not possible to answer the question whether an effect is absent based on *p* > 0.05. 

And still there are many situations where researchers are interested in examining whether an effect is absent. For example, one might want to show two groups do not differ on factors that might be a confound in the experimental design (e.g., examining whether a manipulation intended to increase fatigue did not affect the mood of the participants, by showing that positive and negative affect did not differ between the groups). Researchers might be interested in whether two interventions work equally well, especially when the newer intervention costs less or requires less effort (e.g., is online therapy just as efficient as in person therapy?). And other times we might be interested to demonstrate the absence of an effect because a theoretical model predicts there is no effect, or because we believe a previously published study was a false positive, and we expect to show the absence of an effect in a replication study.

Statistical approaches have been developed to allow researchers to make claims about the absence of effects. However, it is never possible to show an effect is *exactly* 0. Even if you would collect data from every person in the world, the effect in any single study will randomly vary around the true effect size of 0, and there will be a tiny observed difference. Hodges and Lehman [@hodges_testing_1954] were the first to discuss the statistical problem of testing whether two populations have the same mean. They suggest (p. 264) to: “test that their means do not differ by more than an amount specified to represent the smallest difference of practical interest.” Nunnaly [@nunnally_place_1960] similarly proposed a ‘fixed-increment’ hypothesis where researcher compare an observed effect against a range of values that is deemed too small to be meaningful. Defining a range of values considered practically equivalent to the absence of an effect is known as an **equivalence range** [@bauer_unifying_1996] or a **region of practical equivalence** [@kruschke_bayesian_2013]. The equivalence range should be specified in advance, and requires careful consideration of which effects are too small to be meaningful. 

Although researchers have repeatedly attempted to introduce test against an equivalence range in the social sciences [@cribbie_recommendations_2004; levine_communication_2008; hoenig_abuse_2001; @rogers_using_1993; @quertemont_how_2011], this statistical approach became popular during the replication crisis as researchers searched for tools to interpret null-results when performing replication studies. Researchers wanted to be able to publish informative null results when replication findings that were possibly false positives, such as the study by Daryl Bem ostensible showing that participants were able to predict the future [@bem_feeling_2011]. Equivalence tests were proposed as a statistical approach to answer the question whether an observed effect is small enough to conclude that a previous study could not be replicated [@anderson_theres_2016; @lakens_equivalence_2017; @simonsohn_small_2015]. 

## Equivalence tests

Equivalence tests were first developed in pharmaceutical sciences [@hauck_new_1984; @westlake_use_1972] and later formalized as the **two one-sided tests (TOST)** approach to equivalence testing [@schuirmann_comparison_1987; @seaman_equivalence_1998; @wellek_testing_2010]. In the TOST procedure one performs two one-sided tests, one examining if we can reject effects smaller than the lower bound of the equivalence range, and one examining if we can reject effect larger than the upper bound of the equivalence range. If both one-sided tests are significant, we can reject the presence of effects large enough to be meaningful. Let's look at an example of an equivalence test using the TOST procedure. 

In a study where researchers are manipulating fatigue by asking participants to carry heavy boxes around, the researchers want to ensure the manipulation does not inadvertently alter participants’ moods. The researchers assess positive and negative emotions in both ocnditions, and want to claim there are no differences in positive mood. Let’s assume that positive mood in the experimental fatigue condition (m1 = 4.55, sd1 = 1.05, n1 = 15) did not differ from the mood in the the control condition (m2 = 4.87, sd2 = 1.11, n2 = 15). The researchers conclude: “Mood did not differ between conditions, *t* = -0.81, *p* = .42”. Of course, mood did differ between conditions, as 4.55 - 4.87 = -0.32. The claim is that there was no *meaningful* difference in mood, but to make such a claim in a correct manner, we first need to specify which difference in mood is large enough to be meaningful. For now, let's assume the researcher consider any effect less extreme half a scale point too small to be meaningful. We test now test if the observed mean difference of -0.32 is small enough such that we can reject the presence of effects that are large enough to matter.  

The TOSTER package (using functions created by Aaron Caldwell) can be used to plot two *t*-distributions and their critical regions indicating when we can reject the presence of effects smaller than -0.5 and larger than 0.5. It can take some tine to get used to the idea that we are rejecting not a value of 0 (as in a null-hypothesis significance test), but values more extreme than the equivalence bounds. In Figure \@ref(fig:tdistequivalence) we see a *t*-distribution centered on the bounds of the specified equivalence range (-0.5 and 0.5). 

<div class="figure" style="text-align: center">
<img src="09-equivalencetest_files/figure-html/tdistequivalence-1.png" alt="The mean difference and its confidence interval plotted below the *t*-distributions used to perform the two-one-sided tests against -0.5 and 0.5." width="100%" />
<p class="caption">(\#fig:tdistequivalence)The mean difference and its confidence interval plotted below the *t*-distributions used to perform the two-one-sided tests against -0.5 and 0.5.</p>
</div>

Let's first look at the left curve. We see the highlighted area in the tails that highlights which observed mean differences would be extreme enough to statistically reject an effect of -0.5. Our observed mean difference of -0.32 lies very close to 0.5, and if we look at the left distribution, the mean is not far enough away from 0.5 to fall in the green area that indicates when observed differences would be statistically significant. We can also perform the equivalence test using the TOSTER package, and look at the statistical test. 


```r
TOSTER::tsum_TOST(m1 = 4.55, m2 = 4.87, sd1 = 1.05, sd2 = 1.11,
                  n1 = 15, n2 = 15, low_eqbound = -0.5, high_eqbound = 0.5)
```

```
## 
## Welch Modified Two-Sample t-Test
## Hypothesis Tested: Equivalence
## Equivalence Bounds (raw):-0.500 & 0.500
## Alpha Level:0.05
## The equivalence test was non-significant, t(27.91) = 0.456, p = 3.26e-01
## The null hypothesis test was non-significant, t(27.91) = -0.811, p = 4.24e-01
## NHST: don't reject null significance hypothesis that the effect is equal to zero 
## TOST: don't reject null equivalence hypothesis
## 
## TOST Results 
##                     t        SE       df    p.value
## t-test     -0.8111280 0.3945124 27.91398 0.42415467
## TOST Lower  0.4562595 0.3945124 27.91398 0.32586680
## TOST Upper -2.0785154 0.3945124 27.91398 0.02348582
## 
## Effect Sizes 
##                 estimate        SE   lower.ci  upper.ci conf.level
## Raw           -0.3200000 0.3945124 -0.9911879 0.3511879        0.9
## Hedges' g(av) -0.2881401 0.3812249 -0.9301965 0.3193638        0.9
## 
## Note: SMD confidence intervals are an approximation. See vignette("SMD_calcs").
```

The output shows the null-hypothesis significance test (which we already knew was not statistically significant: *t* = -0.81, *p* = 0.42). We also see a test indicated by TOST Lower. This is the first one-sided test examining if the observed mean difference is statistically larger than -0.5. From the test result, we see this is not the case: *t* = 0.46, *p* = 0.36. This is an ordinary *t*-test, just against a different value than 0. To perform an equivalence test, you don't need to learn any new information, and it is somewhat surprising that the use of *t*tests to perform equivalence tests is not taught alongside their use in null-hypothesis significance tests, as there is some indication this can help prevent misunderstanding of *p*-values [@parkhurst_statistical_2001]. Because we can not reject differences more extreme than -0.5, it is possible that a different we consider meaningful (e.g., a difference of -0.60) is present. When we look at the one-sided test against the upper bound of the equivalence range (0.5) we see that we can statistically reject the presence of mood effects larger than 0.5, as in the line TOST Upper we see *t* = -2.08, *p* = 0.02. Our final conclusion is therefore that, even thought we can reject effects more extreme than 0.5 based on the observed mean difference of -0.32, we can not reject effects more extreme than -0.5. Therefore, we can not completely reject the presence of meanginful mood effects. As the data does not allow us to say the effect is different from 0, nor that the effect is, if anything, too small to matter (based on an equivalence range from -0.5 to 0.5), the data are **inconclusive*. We can not distinguish between a Type 2 error (there is an effect, but in this study we just did not detect it) or if there is a true negative (there really is no effect large enough to matter). 

One way to reduce the probability of an inconclusive effect is to collect sufficient data. Let's imagine the researchers had not collected 15 participants in each condition, but 150 participants. They otherwise observe exactly the same data. As explained in the chapter on [confidence intervals](#confint) as the sample size increases, the confidence interval becomes more narrow. For a TOST equivalence test to be able to reject both the upper and lower bound of the equivalence range, the confidence interval needs to fall completely within the equivalence range. Note that because the TOST procedure is based on two one-sided tests, a 90% confidence interval is used when the one-sided tests are performed at an alpha level of 5%. Because both the test against the upper bound and the test against the lower bound needs to be statistically significant to declare equivalence (which as explained in the chapter on [error control](#multiplecomparisons) is an intersection-union approach to multiple testing) it is not necessary to correct for the fact that two tests are performed. 

In Figure \@ref(fig:ciequivalence) we see the results for a sample size of 150 per group, plotted underneath a confidence density plot [@schweder_confidence_2016], which is a graphical summary of the distribution of confidence.

<div class="figure" style="text-align: center">
<img src="09-equivalencetest_files/figure-html/ciequivalence-1.png" alt="The mean difference and its confidence interval plotted below the the consonance density plot for tests against -0.5 and 0.5." width="100%" />
<p class="caption">(\#fig:ciequivalence)The mean difference and its confidence interval plotted below the the consonance density plot for tests against -0.5 and 0.5.</p>
</div>



If we wanted to have sufficient power to detect an effect of 0, which sample size would we need to collect? 


```r
TOSTER::power_t_TOST(power = 0.9, delta = 0,
                     alpha = 0.05, type = "two.sample",
                     low_eqbound = -0.5, high_eqbound = 0.5)
```

```
## 
##      Two-sample TOST power calculation 
## 
##           power = 0.9
##            beta = 0.1
##           alpha = 0.05
##               n = 87.26261
##           delta = 0
##              sd = 1
##          bounds = -0.5, 0.5
## 
## NOTE: n is number in *each* group
```

```r
TOSTER::tsum_TOST(m1 = 4.55, m2 = 4.87, sd1 = 1.05, sd2 = 1.11,
                  n1 = 88, n2 = 88, low_eqbound = -0.5, high_eqbound = 0.5)
```

```
## 
## Welch Modified Two-Sample t-Test
## Hypothesis Tested: Equivalence
## Equivalence Bounds (raw):-0.500 & 0.500
## Alpha Level:0.05
## The equivalence test was non-significant, t(173.47) = 1.105, p = 1.35e-01
## The null hypothesis test was non-significant, t(173.47) = -1.965, p = 5.11e-02
## NHST: don't reject null significance hypothesis that the effect is equal to zero 
## TOST: don't reject null equivalence hypothesis
## 
## TOST Results 
##                    t        SE       df      p.value
## t-test     -1.964649 0.1628789 173.4654 5.105211e-02
## TOST Lower  1.105115 0.1628789 173.4654 1.353200e-01
## TOST Upper -5.034414 0.1628789 173.4654 5.963225e-07
## 
## Effect Sizes 
##                 estimate        SE   lower.ci    upper.ci conf.level
## Raw           -0.3200000 0.1628789 -0.5893505 -0.05064951        0.9
## Hedges' g(av) -0.2948993 0.1524747 -0.5483202 -0.04696129        0.9
## 
## Note: SMD confidence intervals are an approximation. See vignette("SMD_calcs").
```



You might not expect a true difference of exactly zero of the mood manipulation. For example, you might deem it reasonable to expect a true effect of d = 0.2. You are still interested in showing this effect is too small too matter, which you defined as a difference of 0.5. If the true effect size is indeed d = 0.2, we should expect to observe effects much closer to the equivalence bound 0.5. To be able to reliable exclude effects larger than 0.5, we will need a larger sample size, similar to how we need a larger sample size for a null-hypothesis test powered to detect a d = 0.3, than a null-hypothesis test powered to detect a d = 0.5. 


```r
# New TOSTER power functions allows power for expected non-zero effect.
TOSTER::power_t_TOST(power = 0.9, delta = 0.2,
                     alpha = 0.05, type = "two.sample",
                     low_eqbound = -0.5, high_eqbound = 0.5)
```

```
## 
##      Two-sample TOST power calculation 
## 
##           power = 0.9
##            beta = 0.1
##           alpha = 0.05
##               n = 190.988
##           delta = 0.2
##              sd = 1
##          bounds = -0.5, 0.5
## 
## NOTE: n is number in *each* group
```

It is better to specify the equivalence bounds in terms of raw effect sizes. Setting them in terms of Cohen's d leads to bias in the statistical test (as we have to use the observed standard deviation to translate Cohen's d into a raw effect size). This is in practice not too problematic in any single equivalence test, but as equivalence testing becomes more popular, and fields establish smallest effect sizes of interest, they should do so in raw effect size differences, not in terms of standardized effect size differences. 

There is no need to set an upper and lower bound for an equivalence test. Your question might be directional: Can I reject an effect larger than 0.5? In such a question, any effect smaller than 0.5, even an effect of -0.8, would reject effects you deem meaningful. An example of a situation where such a test is approrpiate is a replication study. If a previous study observed an effect of d = 0.48, and you perform a replication study, you might decide to consider any effect smaller than d = 0.2 a failure to replicate - including any effect in the opposite direction. Although most software for equivalence tests requires you to specify an upper and lower bound, you can mimick a one-sided test by setting the other equivalence bound to an extreme value for the research question you are asking. In the analysis below, the lower bound is set to d = -5. We see the data is very far removed from this bound, and of course the one-sided test against d = -5 will always be statistically significant, so it does not influence the final decision based on the TOST procedure. 

```r
# New TOSTER function
res <- TOSTER::tsum_TOST(m1 = 4.55, m2 = 4.87, sd1 = 1.05, sd2 = 1.11,
                  n1 = 15, n2 = 15, low_eqbound = -5, high_eqbound = 0.5,
                  eqbound_type = "SMD", bias_correction = TRUE)
res
```

```
## 
## Welch Modified Two-Sample t-Test
## Hypothesis Tested: Equivalence
## Equivalence Bounds (raw):-5.402 & 0.540
## Alpha Level:0.05
## The equivalence test was significant, t(27.91) = -2.180, p = 1.89e-02
## The null hypothesis test was non-significant, t(27.91) = -0.811, p = 4.24e-01
## NHST: don't reject null significance hypothesis that the effect is equal to zero 
## TOST: reject null equivalence hypothesis
## 
## TOST Results 
##                    t        SE       df      p.value
## t-test     -0.811128 0.3945124 27.91398 4.241547e-01
## TOST Lower 12.881936 0.3945124 27.91398 1.439959e-13
## TOST Upper -2.180434 0.3945124 27.91398 1.890746e-02
## 
## Effect Sizes 
##                 estimate        SE   lower.ci  upper.ci conf.level
## Raw           -0.3200000 0.3945124 -0.9911879 0.3511879        0.9
## Hedges' g(av) -0.2881401 0.3812249 -0.9301965 0.3193638        0.9
## 
## Note: SMD confidence intervals are an approximation. See vignette("SMD_calcs").
```

```r
plot(res)
```

<img src="09-equivalencetest_files/figure-html/unnamed-chunk-7-1.png" width="100%" style="display: block; margin: auto;" />


```r
# Old TOSTER power function do not take one-sided tests into account
TOSTER::powerTOSTtwo(alpha = 0.05, low_eqbound = -5, high_eqbound = 0.5, statistical_power = 0.9)
```

```
## The required sample size to achieve 90 % power with equivalence bounds of -5 and 0.5 is 87 per group, or 174 in total.
```

```
## [1] 86.57739
```

```r
# New TOSTER power functions takes one-sided bounds into account
TOSTER::power_t_TOST(power = 0.9, delta = 0.0,
                     alpha = 0.05, type = "two.sample",
                     low_eqbound = -5, high_eqbound = 0.5)
```

```
## 
##      Two-sample TOST power calculation 
## 
##           power = 0.9
##            beta = 0.1
##           alpha = 0.05
##               n = 69.19784
##           delta = 0
##              sd = 1
##          bounds = -5.0, 0.5
## 
## NOTE: n is number in *each* group
```


## Equivalence tests for ANOVA


```r
# Get Data
data("InsectSprays")
# Build ANOVA
aovtest = aov(count ~ spray,
              data = InsectSprays)
summary(aovtest)
```

```
##             Df Sum Sq Mean Sq F value Pr(>F)    
## spray        5   2669   533.8    34.7 <2e-16 ***
## Residuals   66   1015    15.4                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

We can use this summary to perform an equivalence test for an *F*-test: 


```r
TOSTER::equ_ftest(Fstat = 34.70228,
          df1 = 5,
          df2 = 66,
          eqbound = 0.35)
```

```
## 
## 	Equivalence Test from F-test
## 
## data:  Summary Statistics
## F = 34.702, df1 = 5, df2 = 66, p-value = 1
## 95 percent confidence interval:
##  0.5806263 0.7804439
## sample estimates:
## [1] 0.724439
```

```r
TOSTER::equ_anova(aovtest,
          eqbound = 0.35)
```

```
##        effect df1 df2  F.value       p.null      pes eqbound     p.equ
## 1 spray         5  66 34.70228 3.182584e-17 0.724439    0.35 0.9999965
```

```r
TOSTER::plot_pes(Fstat = 34.70228,
         df1 = 5,
         df2 = 66)
```

<img src="09-equivalencetest_files/figure-html/unnamed-chunk-10-1.png" width="100%" style="display: block; margin: auto;" />

```r
TOSTER::power_eq_f(df1 = 2, 
            df2 = 60,
            eqbound = .15)
```

```
## 
##      Power for Non-Inferiority F-test 
## 
##             df1 = 2
##             df2 = 60
##         eqbound = 0.15
##       sig.level = 0.05
##           power = 0.8188512
```


```

## Absence of evidence is not evidence of absence.

Take a look at the last paper you have written. Search for a *p*-value larger than 0.05. How did you interpret this result?
It is common that researchers interpret a *p*-value larger than 0.05 as the absence of an effect. However, this is a misinterpretation of *p*-values.

When you find *p* > 0.05, you did not observe surprising data, assuming there is no true effect. You can often read in the literature how *p* > 0.05 is interpreted as ‘no effect’ but due to a lack of power the data might not be surprising if there was an effect. In this blog I’ll explain how to test for equivalence, or the lack of a meaningful effect, using equivalence hypothesis testing. I’ve created easy to use R functions that allow you to perform equivalence hypothesis tests. Warning: If you read beyond this paragraph, you will never again be able to write “as predicted, the interaction revealed there was an effect for participants in the experimental condition (p < 0.05) but there was no effect in the control condition (F < 1).” If you prefer the veil of ignorance, here’s a nice site with cute baby animals to spend the next 9 minutes on instead.

Any science that wants to be taken seriously needs to be able to provide support for the null-hypothesis. I often see people switching over from Frequentist statistics when effects are significant, to the use of Bayes Factors to be able to provide support for the null hypothesis. But it is possible to test if there is a lack of an effect using p-values (why no one ever told me this in the 11 years I worked in science is beyond me). It’s as easy as doing a t-test, or more precisely, as doing two t-tests.

The practice of Equivalence Hypothesis Testing (EHT) is used in medicine, for example to test whether a new cheaper drug isn’t worse (or better) than the existing more expensive option. A very simple EHT approach is the ‘two-one-sided t-tests’ (TOST) procedure (Schuirmann, 1987). Its simplicity makes it wonderfully easy to use.

The basic idea of the test is to flip things around: In Equivalence Hypothesis Testing the null hypothesis is that there is a true effect larger than a Smallest Effect Size of Interest (SESOI; Lakens, 2014). That’s right – the null-hypothesis is now that there IS an effect, and we are going to try to reject it (with a p < 0.05). The alternative hypothesis is that the effect is smaller than a SESOI, anywhere in the equivalence range - any effect you think is too small to matter, or too small to feasibly examine. For example, a Cohen’s d of 0.5 is a medium effect, so you might set d = 0.5 as your SESOI, and the equivalence range goes from d = -0.5 to d = 0.5 In the TOST procedure, you first decide upon your SESOI: anything smaller than your smallest effect size of interest is considered smaller than small, and will allow you to reject the null-hypothesis that there is a true effect. You perform two t-tests, one testing if the effect is smaller than the upper bound of the equivalence range, and one testing whether the effect is larger than the lower bound of the equivalence range. Yes, it’s that simple.

Let’s visualize this. Below on the left axis is a scale for the effect size measure Cohen’s d. On the left is a single 90% confidence interval (the crossed circles indicate the endpoints of the 95% confidence interval) with an effect size of d = 0.13. On the right is the equivalence range. It is centered on 0, and ranges from d = -0.5 to d = 0.5.

We see from the 95% confidence interval around d = 0.13 (again, the endpoints of which are indicated by the crossed circles) that the lower bound overlaps with 0. This means the effect (d = 0.13, from an independent t-test with two conditions of 90 participants each) is not statistically different from 0 at an alpha of 5%, and the p-value of the normal NHST is 0.384 (the title provides the exact numbers for the 95% CI around the effect size). But is this effect statistically smaller than my smallest effect size of interest?

## JUstifying a smallest effect size of interest {#justifysesoi}

### Rejecting the presence of a meaningful effect

There are two ways to test the lack of a meaningful effect that yield the same result. The first is to perform two one sided t-tests, testing the observed effect size against the ‘null’ of your SESOI (0.5 and -0.5). These t-tests show the d = 0.13 is significantly larger than d = -0.5, and significantly smaller than d = 0.5. The highest of these two p-values is p = 0.007. We can conclude that there is support for the lack of a meaningful effect (where meaningful is defined by your choice of the SESOI). The second approach (which is easier to visualize) is to calculate a 90% CI around the effect (indicated by the vertical line in the figure), and check whether this 90% CI falls completely within the equivalence range. You can see a line from the upper and lower limit of the 90% CI around d = 0.13 on the left to the equivalence range on the right, and the 90% CI is completely contained within the equivalence range. This means we can reject the null of an effect that is larger than d = 0.5 or smaller than d = -0.5 and conclude this effect is smaller than what we find meaningful (and you’ll be right 95% of the time, in the long run).

[Technical note: The reason we are using a 90% confidence interval, and not a 95% confidence interval, is because the two one-sided tests are completely dependent. You could actually just perform one test, if the effect size is positive against the upper bound of the equivalence range, and if the effect size is negative against the lower bound of the equivalence range. If this one test is significant, so is the other. Therefore, we can use a 90% confidence interval, even though we perform two one-sided tests. This is also why the crossed circles are used to mark the 95% CI.].

So why were we not using these tests in the psychological literature? It’s the same old, same old. Your statistics teacher didn’t tell you about them. SPSS doesn’t allow you to do an equivalence test. Your editors and reviewers were always OK with your statements such as “as predicted, the interaction revealed there was an effect for participants in the experimental condition (p < 0.05) but there was no effect in the control condition (F < 1).” Well, I just ruined that for you. Absence of evidence is not evidence of absence!

We can’t use p > 0.05 as evidence of a lack of an effect. You can switch to Bayesian statistics if you want to support the null, but the default priors are only useful of in research areas where very large effects are examined (e.g., some areas of cognitive psychology), and are not appropriate for most other areas in psychology, so you will have to be able to quantify your prior belief yourself. You can teach yourself how, but there might be researchers who prefer to provide support for the lack of an effect within a Frequentist framework. Given that most people think about the effect size they expect when designing their study, defining the SESOI at this moment is straightforward. After choosing the SESOI, you can even design your study to have sufficient power to reject the presence of a meaningful effect. Controlling your error rates is thus straightforward in equivalence hypothesis tests, while it is not that easy in Bayesian statistics (although it can be done through simulations).

One thing I noticed while reading this literature is that TOST procedures, and power analyses for TOST, are not created to match the way psychologists design studies and think about meaningful effects. In medicine, equivalence is based on the raw data (a decrease of 10% compared to the default medicine), while we are more used to think in terms of standardized effect sizes (correlations or Cohen’s d). Biostatisticians are fine with estimating the pooled standard deviation for a future study when performing power analysis for TOST, but psychologists use standardized effect sizes to perform power analyses. Finally, the packages that exist in R (e.g., equivalence) or the software that does equivalence hypothesis tests (e.g., Minitab, which has TOST for t-tests, but not correlations) requires that you use the raw data. In my experience (Lakens, 2013) researchers find it easier to use their own preferred software to handle their data, and then calculate additional statistics not provided by the software they use by typing in summary statistics in a spreadsheet (means, standard deviations, and sample sizes per condition). So my functions don’t require access to the raw data (which is good for reviewers as well). Finally, the functions make a nice picture such as the one above so you can see what you are doing.

## Bayesian estimation using ROPE and equivalence tests. {-}

When we perform a study, we would like to conclude there is an effect, when there is an effect. But it is just as important to be able to conclude there is no effect, when there is no effect. I’ve recently published a paper that makes Frequentist equivalence tests (using the two-one-sided tests, or TOST, approach) as easy as possible (Lakens, 2017). Equivalence tests allow you to reject the presence of any effect you care about. In Bayesian estimation, one way to argue for the absence of a meaningful effect is the Region of Practical Equivalence (ROPE) procedure (Kruschke, 2014, chapter 12), which is “somewhat analogous to frequentist equivalence testing” (Kruschke & Liddell, 2017).

In the ROPE procedure, a 95% Highest Density Interval (HDI) is calculated based on a posterior distribution (which is calculated based on a prior and the data). Kruschke suggests that: “if the 95 % HDI falls entirely inside the ROPE then we decide to accept the ROPE’d value for practical purposes”. Note that the same HDI can also be used to reject the null hypothesis, where in Frequentist statistics, even though the confidence interval plays a similar role, you would still perform both a traditional t-test and the TOST procedure.

The only real difference with equivalence testing is that instead of using a confidence interval, a Bayesian Highest Density Interval is used. If the prior used by Kruschke was perfectly uniform, ROPE and equivalence testing would identical, barring philosophical differences in how the numbers should be interpreted. The BEST package by default uses a ‘broad’ prior, and therefore the 95% CI and 95% HDI are not exactly the same, but they are very close, for single comparisons. When multiple comparisons are made, (for example when using sequential analyses, Lakens, 2014), the CI needs to be adjusted to maintain the desired error rate, but in Bayesian statistics, error rates are not directly controlled (they are limited due to ‘shrinkage’, but can be inflated beyond 5%, and often considerably so).

In the code below, I randomly generate random normally distributed data (with means of 0 and a sd of 1) and perform the ROPE procedure and the TOST. The 95% HDI is from -0.10 to 0.42, and the 95% CI is from -0.11 to 0.41, with mean differences of 0.17 or 0.15. 

 Indeed, if you will forgive me the pun, you might say these two approaches are practically equivalent. But there are some subtle differences between ROPE and TOST

### 95% HDI vs 90% CI

Kruschke (2014, Chapter 5) writes: “How should we define “reasonably credible”? One way is by saying that any points within the 95% HDI are reasonably credible.” There is not a strong justification for the use of a 95% HDI over a 96% of 93% HDI, except that it mirrors the familiar use of a 95% CI in Frequentist statistics. In Frequentist statistics, the 95% confidence interval is directly related to the 5% alpha level that is commonly deemed acceptable for a maximum Type 1 error rate (even though this alpha level is in itself a convention without strong justification).

But here’s the catch: The TOST equivalence testing procedure does not use a 95% CI, but a 90% CI. The reason for this is that two one-sided tests are performed. Each of these tests has a 5% error rate. You might intuitively think that doing two tests with a 5% error rate will increase the overall Type 1 error rate, but in this case, that’s not true. You could easily replace the two tests, with just one test, testing the observed effect against the equivalence bound (upper or lower) closest to it. If this test is statistically significant, so is the other – and thus, there is no alpha inflation in this specific case. That’s why the TOST procedure uses a 90% CI to have a 5% error rate, while the same researcher would use a 95% CI in a traditional two-sided t-test to examine whether the observed effect is statistically different from 0, while maintaining a 5% error rate (see also Senn, 2007, section 22.2.4)

This nicely illustrates the difference between estimation (where you just want to have a certain level of accuracy, such as 95%), and Frequentist hypothesis testing, where you want to distinguish between signal and noise, and not be wrong more than 5% of the time when you declare there is a signal. ROPE keeps the accuracy the same across tests, Frequentist approaches keep the error rate constant. From a Frequentist perspective, ROPE is more conservative than TOST, like the use of alpha = 0.025 is more conservative than the use of alpha = 0.05.

### Power analysis for Equivalence Tests {#powerequiv}

For an equivalence test, power analysis can be performed based on closed functions, and the calculations take just a fraction of a second. I find that useful, for example in my role in our ethics board, where we evaluate proposals that have to justify their sample size, and we often check power calculations. Kruschke has an excellent R package (BEST) that can do power analyses for the ROPE procedure. This is great work – but the simulations take a while (a little bit over an hour for 1000 simulations).

Because the BESTpower function relies on simulations, you need to specify the sample size, and it will calculate the power. That’s actually the reverse of what you typically want in a power analysis (you want to input the desired power, and see which sample size you need). This means you most likely need to run multiple simulations in BESTpower, before you have determined the sample size that will yield good power. Furthermore, the software requires your to specify the expected means and standard deviations, instead of simply an expected effect size. Instead of Frequentist power analysis, where the hypothesized effect size is a point value (e.g., d = 0.4), Bayesian power analysis models the alternative as a distribution, acknowledging there is uncertainty.

In the end, however, the result of a power analysis for ROPE and for TOST is actually remarkably similar. Using the code below to perform the power analysis for ROPE, we see that 100 participants in each group give us approximately 88.4% power (with 2000 simulations, this estimate is still a bit uncertain) to get a 95% HDI that falls within our ROPE of -0.5 to 0.5, assuming standard deviations of 1.

We can use the powerTOSTtwo.raw function in the TOSTER package (using an alpha of 0.025 instead of 0.05, to mirror to 95% HDI) to calculate the sample size we would need to achieve 88.4% power for independent t-test (using equivalence bounds of -0.5 and 0.5, and standard deviations of 1):

powerTOSTtwo.raw(alpha=0.025,statistical_power=0.875,low_eqbound=-0.5,high_eqbound=0.5,sdpooled=1)

The outcome is 100 as well. So if you use a broad prior, it seems you can save yourself some time by using the power analysis for equivalence tests, without severe consequences.

### Use of prior information

The biggest benefit of ROPE over TOST is that is allows you to incorporate prior information in your data analysis. If you have reliable prior information, ROPE can use this information, which is especially useful if you don’t have a lot of data. If you use priors, it is typically advised to check the robustness of the posterior against reasonable changes in the prior (Kruschke, 2013).

### Conclusion

Using the ROPE procedure or the TOST procedure will most likely lead to very similar inferences. For all practical purposes, the differences are small. It’s quite a lot easier to perform a power analysis for TOST, and by default, TOST has greater statistical power because it uses 90% CI. But power analysis is possible for ROPE (which is a rare pleasure to see for Bayesian analyses), and you could choose to use a 90% HDI, or any other value that matches your goals. TOST will be easier and more familiar because it is just a twist on the classic t-test, but ROPE might be a great way to dip your toes in Bayesian waters and explore the many more things you can do with Bayesian posterior distributions.

<!-- ```{r} -->
<!-- # Data is loaded because BEST analysis takes so very long -->
<!-- load("data/BESTout.Rdata") -->
<!-- plot(BESTout) -->

<!-- #TOST test -->
<!-- TOSTtwo.raw(m1=mean(x),m2=mean(y),sd1=sd(x),sd2=sd(y),n1=length(x),n2=length(y),low_eqbound=-0.5,high_eqbound=0.5, alpha=0.025) -->

<!-- powerPro -->

<!-- #TOST power analysis -->
<!-- powerTOSTtwo.raw(alpha=0.025,statistical_power=0.875,low_eqbound=-0.5,high_eqbound=0.5,sdpooled=1) -->

<!-- ``` -->


<!-- ## Using CI for equivalence tests -->


```r
n = 100 #set sample size
x<-rnorm(n = n, mean = 100, sd = 15) #create sample from normal distribution
y<-rnorm(n = n, mean = 100, sd = 15) #create sample from normal distribution

TOSTER::t_TOST(x, y, low_eqbound = 0.4, high_eqbound = 0.4, eqbound_type = "raw")
```

```
## 
## Welch Two Sample t-test
## Hypothesis Tested: Equivalence
## Equivalence Bounds (raw):0.400 & 0.400
## Alpha Level:0.05
## The equivalence test was non-significant, t(197.86) = -0.207, p = 5.82e-01
## The null hypothesis test was non-significant, t(197.86) = -0.00747, p = 9.94e-01
## NHST: don't reject null significance hypothesis that the effect is equal to zero 
##  TOST: don't reject null equivalence hypothesis
## 
## TOST Results 
##                       t       SE       df   p.value
## t-test     -0.007473825 2.002934 197.8611 0.9940443
## TOST Lower -0.207180820 2.002934 197.8611 0.5819591
## TOST Upper -0.207180820 2.002934 197.8611 0.4180409
## 
## Effect Sizes 
##                   estimate        SE   lower.ci  upper.ci conf.level
## Raw           -0.014969581 2.0029343 -3.3250013 3.2950622        0.9
## Hedges' g(av) -0.001052946 0.1421416 -0.2347732 0.2326502        0.9
## 
## Note: SMD confidence intervals are an approximation. See vignette("SMD_calcs").
```

```r
effectsize::hedges_g(x, y)
```

```
## Hedges' g |        95% CI
## -------------------------
## -1.05e-03 | [-0.28, 0.28]
## 
## - Estimated using pooled SD.
```

```r
# Immediate equivalence test
effectsize::equivalence_test(
  effectsize::cohens_d(x, y),
  range = "default",
  rule = c("classic"),
)
```

```
## # Test for Practical Equivalence
##  	ROPE: [-0.10 0.10]
## 
## Cohen's d |        95% CI |        H0
## -------------------------------------
## -1.06e-03 | [-0.28, 0.28] | Undecided
```

