

# Effect Sizes {#effectsize}

Effect sizes are an important statistical outcome in most empirical studies. Researchers want to know whether an intervention or experimental manipulation has an effect greater than zero, or (when it is obvious an effect exists) how big the effect is. Researchers are often reminded to report effect sizes, because they are useful for three reasons. First, they allow researchers to present the magnitude of the reported effects, which allow researchers to reflect on the **practical significance** of the  effects they report, in addition to the *statistical* significance. Second, effect sizes allow researchers to draw meta-analytic conclusions by comparing standardized effect sizes across studies. Third, effect sizes from previous studies can be used when planning a new study in an a-priori power analysis.

A measure of effect size is a quantitative description of the strength of a phenomenon. It is expressed as a number on a scale. For **unstandardized effect sizes**, the effect size is expressed on the scale the measure was collected on. This is useful whenever people are able to intuitively interpret differences on a measurement scale. For example, children grow on average 6 centimeters a year between the age of 2 and puberty. We can interpret 6 centimeters a year as an effect size, and many people in the world have an intuitive understanding of how large 6 cm is. Where a *p*-value is used to make a claim about whether there is an efect, or whether we might just be looking at random variation in the data, an effect size is used to answer the question how large the effect is. This makes an effect size estimate an important complement to *p*-values in most studies. A *p*-value tells use we can claim children grow as they age; effect sizes tell us what size clothes we can expect children to wear when they are a certain age, and how long it will take before their new clothes are too small. 

For people in parts of the world that do not use the metric system, if might be difficult to understand what a difference of 6 cm is. To facilitate a comparison of effect sizes across situations where different measurement scales are used, researchers can report **standardized effect sizes**. A standardized effect size, such as **Cohen's d**, is computed by dividing the difference on the raw scale by the standard deviation, and is thus scaled in terms of the variability of the sample from which is was taken. An effect of d = 0.5 means that the difference is the size of half a standard deviation of the measure. This means that effect sizes are determined both by the size of an effect, and the size of the standard deviation, and difference in a standardized effect size can be caused by a difference in the size of the unstanderdized effect, or by a difference in the standard deviation. 

Standardized effect sizes are common when variables are not measured on a scale people are familiar with, or are measured on different scales within the same research area. If you ask people how happy they are, an answer of ‘5’ will mean something very different if you asked people to answer on a scale from 1 to 5 than if you asked them to answer on a scale from 1 to 9. Standardized effect sizes can be understood and compared regardless of the scale that was used to measure the dependent variable. Despite the ease of use of standardized effect size measures, there are good arguments to report and interpret unstandardized effect sizes wherever possible [@baguley_standardized_2009].

Standardized effect sizes can be grouped in two families (Rosenthal, 1994): The d family (consisting of standardized mean differences) and the r family (measures of strength of association). Conceptually, the d family effect sizes are based on the difference between observations, divided by the standard deviation of these observations. The r family effect sizes describe the proportion of variance that is explained by group membership [e.g., a correlation (r) of 0.5 indicates 25% (r2) of the variance is explained by the difference between groups]. These effect sizes are calculated from the sum of squares (the difference between individual observations and the mean for the group, squared, and summed) for the effect divided by the sums of squares for other factors in the design.

## Effect sizes

What is the most important outcome of an empirical study? You might be tempted to say it’s the *p*-value of the statistical test, given that it is practically always reported in articles, and determines whether we call something ‘significant’ or not. However, as Cohen @cohen_things_1990 writes in his 'Things I’ve learned (so far)':

>I have learned and taught that the primary product of a research inquiry is one or more measures of effect size, not *p*-values.

Although what you want to learn from your data is different in every study, and there rarely is any single thing you always want to know, effect sizes are a very important part of the information we gain from data collection. 

A measure of effect size is a quantitative description of the strength of a phenomenon. It is expressed as a number on a scale, and which scale is used depends on the effect size measure that is used. For **unstandardized effect sizes**, we can use a scale that people are very familiar with. For example, children grow on average 6 centimeters a year between the age of 2 and puberty. We can interpret 6 centimeters a year as an effect size. It is obvious an effect size has many benefits over a *p*-value. A *p*-value gives an indication that it is very unlikely children stay the same size as they become older – effect sizes tell us what size clothes we can expect children to wear when they are a certain age, and how long it will take before their new clothes are too small. 

One reason to report effect sizes is to facilitate future research. It is possible to perform a meta-analysis or a power analysis based on unstandardized effect sizes and their standard deviation, but it is easier to work with standardized effect sizes, especially when there is variation in the measures researchers use. But the main goal of reporting effect sizes to reflect on the question whether the observed effect size is meaningful. For example, we might be able to reliably measure that on average 19 years olds will grow 1 centimeter in the next year. This difference might would be statistically significant in a large enough sample, but if you go shopping for clothes when you are 19 years old, it is not something you need care about. Let's look at two examples of studies where looking at the effect size, in addition the its statistical significance, would have improved the statistical inferences. 

## The Facebook experiment

In the summer of 2014 there were some concerns about an experiment Facebook had performed on its users to examine ‘emotional mood contagion’, or the idea that people’s moods can be influenced by the mood of people around them. You can read the article [here](http://www.pnas.org/content/111/24/8788.full). For starters, there was substantial concern about the ethical aspects of the study, primarily because the researchers who performed the study had not asked **informed consent** from the participants in the study (you and me), nor did they ask for permission from the **institutional review board** (or ethics committee) of their university.

One of the other criticisms on the study was that it could be dangerous to influence people’s mood. As Nancy J. Smyth, dean of the University of Buffalo’s School of Social Work wrote on her [Social Work blog](https://njsmyth.wordpress.com/2014/06/29/did-facebooks-secret-mood-manipulation-experiment-create-harm/): “There might even have been increased self-harm episodes, out of control anger, or dare I say it, suicide attempts or suicides that resulted from the experimental manipulation. Did this experiment create harm? The problem is, we will never know, because the protections for human subjects were never put into place”.

If this Facebook experiment had such a strong effect on people’s mood that it made some people commit suicide who would otherwise not have committed suicide, this would obviously be problematic. So let us look at the effects the manipulation Facebook used had on people a bit more closely.

From the article, let’s see what the researchers manipulated:

>Two parallel experiments were conducted for positive and negative emotion: One in which exposure to friends’ positive emotional content in their News Feed was reduced, and one in which exposure to negative emotional content in their News Feed was reduced. In these conditions, when a person loaded their News Feed, posts that contained emotional content of the relevant emotional valence, each emotional post had between a 10% and 90% chance (based on their User ID) of being omitted from their News Feed for that specific viewing.

Then what they measured:

>For each experiment, two dependent variables were examined pertaining to emotionality expressed in people’s own status updates: the percentage of all words produced by a given person that was either positive or negative during the experimental period. In total, over 3 million posts were analyzed, containing over 122 million words, 4 million of which were positive (3.6%) and 1.8 million negative (1.6%).

And then what they found:

>When positive posts were reduced in the News Feed, the percentage of positive words in people’s status updates decreased by B = −0.1% compared with control [t(310,044) = −5.63, P \< 0.001, Cohen’s d = 0.02], whereas the percentage of words that were negative increased by B = 0.04% (t = 2.71, P = 0.007, d = 0.001). Conversely, when negative posts were reduced, the percent of words that were negative decreased by B = −0.07% [t(310,541) = −5.51, P \< 0.001, d = 0.02] and the percentage of words that were positive, conversely, increased by B = 0.06% (t = 2.19, P \< 0.003, d = 0.008).

Here, we will focus on the negative effects of the Facebook study (so specifically, the increase in negative words people used) to get an idea of whether there is a risk of an increase in suicide rates. Even though apparently there was a negative effect, it is not easy to get an understanding about the size of the effect from the numbers as mentioned in the text. Moreover, the number of posts that the researchers analyzed was really large. With a large sample, it becomes important to check if the size of the effect is such that the finding is substantially interesting, because with large sample sizes even
minute differences will turn out to be statistically significant (we will look at this in more detail below). For that, we need a better understanding of “effect sizes”.

## The Hungry Judges study

<div class="figure" style="text-align: center">
<img src="images/hungryjudges.png" alt="Proportion of rulings in favor of the prisoners by ordinal position. Circled points indicate the first decision in each of the three decision sessions; tick marks on x axis denote every third case; dotted line denotes food break. From Danziger, S., Levav, J., &amp; Avnaim-Pesso, L. (2011). Extraneous factors in judicial decisions. Proceedings of the National Academy of Sciences, 108(17), 6889–6892. https://doi.org/10.1073/PNAS.1018033108" width="100%" />
<p class="caption">(\#fig:hungryjudges)Proportion of rulings in favor of the prisoners by ordinal position. Circled points indicate the first decision in each of the three decision sessions; tick marks on x axis denote every third case; dotted line denotes food break. From Danziger, S., Levav, J., & Avnaim-Pesso, L. (2011). Extraneous factors in judicial decisions. Proceedings of the National Academy of Sciences, 108(17), 6889–6892. https://doi.org/10.1073/PNAS.1018033108</p>
</div>



Now that we realize why effect sizes are important, let us look more closely at the most commonly used effect sizes, and how these are calculated.

Effect sizes can be grouped into two families [@rosenthal_contrasts_2000]: The **d family** (based on standardized mean differences) and the **r family** (based on measures of strength of association). Conceptually, the *d* family effect sizes are based on a comparison between the difference between the observations, divided by the standard deviation of these observations. This means that a Cohen’s *d* = 1 means the standardized difference between two groups equals one standard deviation. The *r* family effect sizes are based on the proportion of variance that is explained by group membership (e.g., a correlation of *r* = 0.5 indicates 25% (*r*2) of the variance is explained by the difference between groups). Don’t worry if you do not exactly get what this means at this point. The crucial issue is that we need to understand how to interpret the size of an effect, and that there are different ways to express the size of this effect.

## Cohen’s *d* {#cohend}

The size of the effect in the Facebook study is given by the statistic Cohen’s *d* (which we will discuss in more detail below). Cohen’s *d* (the *d* is italicized) is used to describe the standardized mean difference of an effect. This value can be used to compare effects across studies, even when the dependent variables are measured in different ways, for example when one study uses 7-point scales to measure dependent variables, while the other study uses 9-point scales, or even when completely different measures are used, such as when one study uses self-report measures, and another study used physiological measurements.

Cohen’s *d* ranges from 0 to infinity. Before we get into the statistical details, let’s first visualize what a Cohen’s d of 0.001 (as was found in the Facebook study) means.

We will use a vizualization from <http://rpsychologist.com/d3/cohend/>, a website made by Kristoffer Magnusson, that allows you to visualize the differences between two measurements (such as the increase in negative words used by the Facebook user when the number of positive words on the timeline was reduced). 

<div class="figure" style="text-align: center">
<img src="images/rpsychd1.png" alt="A vizualization of 2 groups (although the difference is hardly visible) representing d = 0.001." width="100%" />
<p class="caption">(\#fig:rpsychd1)A vizualization of 2 groups (although the difference is hardly visible) representing d = 0.001.</p>
</div>

Below the vizualization on the website, you can read some ways to interpret Cohen’s d in non-mathematical terms (the summary is provided about a number of people, but in the Facebook study, we are examining numbers of words). It says "Moreover, in order to have one more favorable outcome in the treatment group compared to the control group, we need to treat 3570.4 people on average." This means in the Facebook study a person needs to type 3570 words before 1 word will be more negative instead of positive. I don't know how often you type this amount of words on Facebook, but I think we can agree this effect is not noticeable on an individual level.

This illustrates the difference between a statistical difference and practical significance (or substantial interest). The effect is so small that it is unlikely to be noticeable for a single individual. Hence, in this case, and without further evidence, we would not worry too much about the extra suicides the research could have caused. Nevertheless, even such small effects can matter in other kinds of research. If an intervention makes people spend more money with a *d* = 0.001, and you have millions of transactions a year, a very small effect might very well make you a lot of money.

A large meta-analytic effort by Richard, Bond, and Stookes-Zoota (2003) estimated the median effect size in psychological studies to have a Cohen’s d = 0.43. Let’s use the vizualization to get a feeling for this effect size.

<div class="figure" style="text-align: center">
<img src="images/rpsychd2.png" alt="A vizualization of 2 groups representing d = 0.43." width="100%" />
<p class="caption">(\#fig:rpsychd2)A vizualization of 2 groups representing d = 0.43.</p>
</div>

Assume we know that people are more likely to comply with a large request after an initial smaller request, than when you ask the large request directly (this is known as the foot-in-the-door effect), and that in a specific context this effect size is 0.43. Given this effect size, how likely is it that a random person drawn from the ‘small initial request condition’ will be more likely to agree with your larger request, compared to a person in the ‘no initial small request’ condition? We see in Figure \@ref(fig:rpsychd2) that this *probability of superiority* is 61.9%.

<div class="figure" style="text-align: center">
<img src="images/rpsychd3.png" alt="A vizualization of 2 groups representing d = 2." width="100%" />
<p class="caption">(\#fig:rpsychd3)A vizualization of 2 groups representing d = 2.</p>
</div>

Based on [this data](http://www.nature.com/pr/journal/v73/n3/full/pr2012189a.html), the difference between the height of 21-year old men and women in The Netherlands is approximately 13 centimeters (in an unstandardized effect size), or a standardized effect size of *d* = 2. If I pick a random man and a random woman walking down the street in my hometown of Rotterdam, how likely is it that the man will be taller than the woman? We see this is quite (92.1%) likely. But even with a huge effect size, which is much larger than most effects researchers study, there is still considerable overlap in the two distributions. If we conclude the length of people in one group is larger than the length of people in another group, this does not mean everyone in one group is larger than everyone in the other group! 

To understand Cohen’s *d*, let’s first look at the formula for the
*t*-statistic:

$$
t = \frac{{\overline{M}}_{1}{- \overline{M}}_{2}}{\text{SD}_{\text{pooled}} \times \sqrt{\frac{1}{n_{1}} + \frac{1}{n_{2}}}}
$$

Here $${\overline{M}}_{1}{- \overline{M}}_{2}$$ is the difference between the means, and $$\text{SD}_{\text{pooled}}$$ is the pooled standard deviation (see Lakens, 2013), and n1 and n2 are the sample sizes of the two groups you are comparing. The *t*-value (because it follows a known distribution) is used to determine whether the difference between two groups in a *t*-test is statistically significant. The formula for Cohen’s *d* is very similar:

Cohen’s *d* = $$\frac{{\overline{M}}_{1}{-\overline{M}}_{2}}{\text{SD}_{\text{pooled}}}$$

You can calculate Cohen’s *d* by hand from the independent samples *t*-value (which can often be convenient when the result section of the paper you are reading does not report effect sizes) through:

$$d = t ⨯ \sqrt{\frac{1}{n_{1}} + \frac{1}{n_{2}}}$$

As you can see, the sample size is part of the formula for a *t*-value, but it is not part of the formula for Cohen’s *d*. Let’s assume the difference between two means we observe is 1, and the pooled standard deviation is also 1. What, on average, happens to the *t*-value and Cohen’s *d*, as we would simulate studies, as a function of the sample size in these simulations? Given the mean difference and standard deviation, as the sample size becomes
bigger, the *t*-value become larger, and Cohen’s *d* gets closer to the true
value. That is, whereas the *t*-value (and the corresponding *p*-value) increase as a function of the sample size, Cohen's d only becomes more accurate. This makes *p*-values a function of the sample size, when there is a true effect, and this means *p*-values can not be used to make a statement about whether an effect is *practically significant*. Reporting and interpreting the effect size will inform you about the practical significance of an effect, and therefore it is almost always beneficial to report effect sizes alongside any statistical test.

### Correcting for Bias

Population effect sizes are almost always estimated on the basis of samples, and as a measure of the population effect size estimate based on sample averages, Cohen’s *d* overestimates the true population effect (when Cohen’s *d* refers to the population, the Greek letter δ is often used). Therefore, corrections for bias are used (even though these corrections do not always lead to a completely unbiased effect size estimate). In the *d* family of effect sizes, the correction for bias in the population effect size estimate of Cohen’s δ is known as Hedges’ *g* (although different people use different names – *d_unbiased* is also used). This correction for bias is only really noticeable in small sample sizes, but since we often use software to calculate effect sizes anyway, it makes sense to always report Hedge’s *g* instead of Cohen’s *d*.

A commonly used interpretation of Cohen’s *d* is to refer to effect sizes as small (*d* = 0.2), medium (*d* = 0.5), and large (*d* = 0.8) based on benchmarks suggested by Cohen (1988) – note, in the video I talk about d = 0.3 being a small effect size, but 0.2 is the benchmark for a small effect as specified by Cohen). However, these values are arbitrary and should not be interpreted too rigidly. Furthermore, small effect sizes can have large consequences, such as an intervention that leads to a reliable reduction in suicide rates with an effect size of *d* = 0.1. On the other hand, you have to start somewhere in getting a feeling for effect sizes, and these benchmarks are a good starting point.

An interesting, though not often used, interpretation of differences between groups can be provided by the common language effect size [@mcgraw_common_1992], also known as the probability of superiority. It expresses the probability that a randomly sampled person from one group will have a higher observed measurement than a randomly sampled person from the other group (for between designs) or the other measurement (for within-designs) the probability that an individual has a higher value on one measurement than the other. We used it earlier and it is provided by the website that visualizes Cohen’s d.

## *r* (correlations) 

The second effect size that is widely used is *r*. You might remember that *r* is used to refer to a correlation. The correlation of two continuous variables can range from 0 (completely unrelated) to 1 (perfect positive relationship) or -1 (perfect negative relationship). Obviously, given the flexibility of human behavior (free will has a lot to do with it) correlations between psychological variables are rarely 1. The median effect size *r* in psychology is (for what such an estimate is worth) .21 [@richard_one_2003]. As mentioned earlier, the *r* family effect sizes describe the proportion of variance that is explained by the independent variable, or $r^2$.

Earlier, I mentioned the average effect size in psychology is *d* = 0.43. You might, therefore, think a *d* = 0.43 and an *r* = .21 should be related somehow, and they are:

$r = \frac{d_s}{\sqrt{{d_s^{2}}^{+}\frac{N^{2} - 2N}{n_{1} \times n_{2}}}}$

The subscript s underneath Cohen’s *d* is used to specify this Cohen’s *d* is calculated based on the sample, not based on the population. This is almost always the case (except in simulation studies, where you can set the effect size in the population), and *N* is the total sample size of both groups, whereas n1 and n2 are the sample sizes of the two groups you are comparing. You can go to <http://rpsychologist.com/d3/correlation/> to look at a good visualization of the proportion of variance that is explained by group membership, and the relationship between *r* and *r*2. 

Effect sizes can be implausibly large. Let’s take a look at a study that actually examines the number of suicides – as a function of the amount of country music played on the radio. You can find the paper [here](http://sf.oxfordjournals.org/content/71/1/211.short) (for [a free PDF version, click here](http://www.fourcornersdailypost.com/UserFiles/File/2011/CountryMusicSuicide.pdf)). It won an [Ig Nobel prize for studies that first make you laugh, and then think](http://www.abc.net.au/science/articles/2004/10/01/1211441.htm). I guess in this case the study should make you think about the importance of interpreting effect sizes.

The authors predicted the following:

>We contend that the themes found in country music-foster a suicidal mood among people already at risk of suicide and that it is thereby associated with a high suicide rate.

Then they collected data:

> Our sample is comprised of 49 large metropolitan areas for which data on music were available. Exposure to country music is measured as the proportion of radio airtime devoted to country music. Suicide data were extracted from the annual Mortality Tapes, obtained from the Inter-University Consortium for Political and Social Research (ICPSR) at the University of Michigan. The dependent variable is the number of suicides per 100,000 population.

And they concluded:

>A significant zero-order correlation was found between white suicide rates and country music (r = .54, p \< .05). The greater the airtime given to country music, the greater the white suicide rate.

Cohen (1988) has provided benchmarks to define small (*r* = 0.1), medium (*r* = 0.3), and large (*r* = 0.5) effects. This means the effect of listening to country music on suicide rates is large. Remember that it is preferable to relate the effect size to other effects in the literature instead of to these benchmarks. What do you think of the likelihood that listening to country music is strongly associated with higher suicide rates? Is country music really that bad? Probably not - which demonstrates the importance of not just reporting, but also interpreting, the effect size. 

If you were doubtful about the possibility that this effect was real, you might not be surprised by the fact that [other researchers were not able to reproduce the analysis of the original authors](http://sf.oxfordjournals.org/content/74/1/327.short). It is likely that the results are spurious, or a Type 1 error.

Eta squared η² (part of the *r* family of effect sizes, and an extension of r that can be used for more than two sets of observations) measures the proportion of the variation in Y that is associated with membership of the different groups deﬁned by X, or the sum of squares of the effect divided by the total sum of squares:

$\eta^{2}$ = $\frac{\text{SS}_{\text{effect}}}{\text{SS}_{\text{total}}}$

An η² of .13 means that 13% of the total variance can be accounted for by group membership. Although η² is an efficient way to compare the sizes of effects within a study (given that every effect is interpreted in relation to the total variance, all η² from a single study sum to 100%), eta squared cannot easily be compared between studies, because the total variability in a study (SStotal) depends on the design of a study, and increases when additional variables are manipulated (e.g., when independent variables are added). Keppel (1991) has recommended partial eta squared ($\eta_{p}^{2}$) to improve the comparability
of effect sizes between studies, which expresses the sum of squares of the effect in relation to the sum of squares of the effect and the sum of squares of the error associated with the effect. Partial eta squared is calculated as:

$\eta_{p}^{2}$ = $\frac{\text{SS}_{\text{effect}}}{\text{SS}_{\text{effect}}
+ \text{SS}_{\text{error}}}$

For designs with fixed factors (manipulated factors, or factors that exhaust all levels of the independent variable, such as alive vs. dead), but not for designs with measured factors or covariates, partial eta squared can be computed from the *F*-value and its degrees of freedom [@cohen_statistical_1988]:   

$\eta_{p}^{2}$ =$\frac{F \times \text{df}_{\text{effect}}}{{F \times
\text{df}}_{\text{effect}} + \text{df}_{\text{error}}}$

For example, for an *F*(1, 38) = 7.21, $\eta_{p}^{2}$ = 7.21 ⨯ 1/(7.21 ⨯ 1 +
38) = 0.16.

Eta squared can be transformed into Cohen’s *d*:

*d* = 2$\times f$ where $f^{2} = \eta^{2}/(1 - \eta^{2})$

As with Cohen’s *d*, η² is a biased estimate of the true effect size in the
population. Two less biased effect size estimates have been proposed, epsilon
squared $\varepsilon^{2}$ and omega squared $\omega^{2}$. Because these
effect sizes are less biased, it is always better to use them. Partial epsilon
squared and partial omega squared can be calculated based on the *F*-value and
degrees of freedom.

$$
\omega_{p}^{2} = \frac{F - 1}{F + \ \frac{\text{df}_{\text{error}} + 1}{\text{df}_{\text{effect}}}}
$$

$$
\varepsilon_{p}^{2} = \frac{F - 1}{F + \ \frac{\text{df}_{\text{error}}}{\text{df}_{\text{effect}}}}
$$

For further reading about effect size estimates, see [this practical primer](http://journal.frontiersin.org/article/10.3389/fpsyg.2013.00863/full) I
have written [@lakens_calculating_2013].

## Effect Sizes and Statistical Power


Based on our recent [preprint](https://psyarxiv.com/baxsf/) explaining power analysis for ANOVA designs, in this post I want provide a step-by-step mathematical overview of power analysis for interactions. These details often do not make it into tutorial papers because of word limitations, and few good free resources are available (for a paid resource worth your money, see [Maxwell, Delaney, & Kelley, 2018](https://designingexperiments.com/)). This post is a bit technical, but nothing in this post requires more knowledge than multiplying and dividing numbers, and I believe that for anyone willing to really understand effect sizes and power in ANOVA designs digging in to these details will be quite beneficial. There are three take-home messages in this post. 

1) In power analyses for ANOVA designs, you should always think of the predicted pattern of means. 
2) Understanding how patterns of means relate to the effect you predict is essential to design an informative study.
3) Always perform a power analysis if your want to test a predicted interaction effect, and always calculate the effect size based on means, sd's, and correlations, instead of plugging in a 'medium' partial eta squared. 
4) Crossover interaction effects have large effects and can thus be studies with high power in smaller samples, and if your theory can predict crossover interactions, such experiments might be worthwhile to design.
5) There are some additional benefits of examining interactions (risky predictions, generalizability, efficiently examining multiple main effects) and it would be a shame if the field is turned away from examining interactions because they sometimes require large samples.

### Getting started: Comparing two groups

We are planning a two independent group experiment. We are using a validated measure, and we know the standard deviation of our measure is approximately 2. We are interested in observing a mean difference of 1 or more, because smaller effects would not be practically meaningful. We expect the mean in the conrol condition to be 0, and therefore want the mean in the intervention group to be 1 or higher.

This means the standardized effect size is the mean difference, divided by the standard deviation, or 1/2 = 0.5. This is the Cohen's d we want to be able to detect in our study:

\begin{equation}
d = \frac{m_1-m_2}{\sigma} =  \frac{1-0}{2} = 0.5.
\end{equation}

An independent *t*-test is mathematically identical to an *F*-test with two groups. For an *F*-test, the effect size used for power analyses is Cohen's *f*, which is a generalization
of Cohen’s d to more than two groups (Cohen, 1988). It is calculated based on the standard deviation of the population means divided by the population standard deviation which we know for our measure is 2), or: 

\begin{equation}
f = \frac{\sigma _{ m }}{\sigma}
\end{equation}
where for equal sample sizes,
\begin{equation}
\sigma _{ m } = \sqrt { \frac { \sum_ { i = 1 } ^ { k } ( m _ { i } - m ) ^ { 2 } } { k } }.
\end{equation}

In this formula *m* is the grand mean, k is the number of means, and m_i is the mean in each group. The formula above might look a bit daunting, but calculating Cohen's f is not that difficult for two groups. 

If we take the expected means of 0 and 1, and a standard deviation of 2, the grand mean (the *m* in the formula above) is (0 + 1)/2 = 0.5. The formula says we should subtract this grand mean from the mean of each group, square this value, and sum them. So we have (0-0.5)^2 and (1-0.5)^2, which are both 0.25. We sum these values (0.25 + 0.25 = 0.5), divide them by the number of groups (0.5/2 = 0.25) and take the square root, we find that $\sigma_{ m }$ = 0.5. We can now calculate Cohen's f (remember than we know $\sigma$ = 2 for our measure): 

\begin{equation}
f = \frac{\sigma _{ m }}{\sigma} = \frac{0.5}{2} = 0.25
\end{equation}

We see that for two groups Cohen's f is half as large as Cohen's d, or $f = \frac{1}{2}d$, which always holds for an *F-test with two independent groups. 

Although calculating effect sizes by hand is obviously an incredibly enjoyable thing to do, you might prefer using software that performs these calculations for you. Here, I will use our Superpower power analysis package (developed by Aaron Caldwell and me). The code below uses a function from the package that computes power analytically for a one-way ANOVA where all conditions are manipulated between participants. In addition to the effect size, the function will compute power for any sample size per condition you enter. Let's assume you have a friend who told you that they heard from someone else that you now need to use 50 observations in each condition (n = 50), so you plan to follow this trustworthy advice. We see the code below returns a Cohen's *f* of 0.25, and also tells us we would have 61.78% power if we use a preregistered alpha level of 0.03.


```r
design <- Superpower::ANOVA_design(
  design = "2b", 
  n = 50, 
  mu = c(1, 0), 
  sd = 2)
```

<img src="06-effectsize_files/figure-html/unnamed-chunk-2-1.png" width="100%" style="display: block; margin: auto;" />

```r
Superpower::power_oneway_between(design, alpha_level = 0.03)$Cohen_f
```

```
## [1] 0.25
```

```r
Superpower::power_oneway_between(design, alpha_level = 0.03)$power
```

```
## [1] 61.78474
```

We therefore might want to increase our sample size for our planned study. Using the `plot_power` function, we can see we would pass 90% power with 100 observations per condition.


```r
Superpower::plot_power(design, alpha_level = 0.03, min_n = 45, max_n = 150)$plot_ANOVA
```

<img src="06-effectsize_files/figure-html/unnamed-chunk-3-1.png" width="100%" style="display: block; margin: auto;" />

```
## Achieved Power and Sample Size for ANOVA-level effects
##   variable                  label  n achieved_power desired_power
## 1        a Desired Power Achieved 97          90.16            90
```

<img src="06-effectsize_files/figure-html/unnamed-chunk-3-2.png" width="100%" style="display: block; margin: auto;" />

### Interaction Effects

So far we have explained the basics for effect size calculations (and we have looked at statistical power) for 2 group ANOVA designs. Now we have the basis to look at interaction effects.

One of the main points in this blog post is that it is better to talk about interactions in ANOVAs in terms of the pattern of means, standard deviations, and correlations, than in terms of a standarized effect size. The reason for this is that, while for two groups a difference between means directly relates to a Cohen's d, widely different patterns of means in an ANOVA will have the same Cohen's *f*. In my experience helping colleagues out their with power analyses for ANOVA designs, talking about effects in terms of a Cohen's *f* is rarely a good place to start when thinking about what your hypothesis predicts. Instead, you need to specify the predicted pattern of means, have some knowledge about the standard deviation of your measure, and then calculate your predicted effect size. 

There are two types of interactions, as visualized below. In an ordinal interaction, the mean of one group ("B1") is always higher than the mean for the other group ("B2"). Disordinal interactions are also known as 'cross-over' interactions, and occur when the group with the larger mean switches over. The difference is important, since another main takeaway of this blog post is that, in two studies where the largest simple comparison has the same effect size, a study with a disordinal interaction has much higher power than a study with an ordinal interaction. Thus, if possible, you will want to design experiments where an effect in one condition flips around in the other condition, instead of an experiment where the effect in the other condition just disappears. I personally never realized this before I learned how to compute power for interactions, and never took this simple but important fact into account. Let's see why it is important.

### Calculating effect sizes for interactions

<img src="06-effectsize_files/figure-html/unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

Mathematically the interaction effect is computed as the cell mean minus the sum of the grand mean, the marginal mean in each condition of one factor minus the grand mean, and the marginal mean in each condition for the other factor minus grand mean (see Maxwell et al., 2017).

Let's consider two cases, one where we have a perfect disordinal interaction (the means of 0 and 1 flip around in the other condition, and are 1 and 0) or an ordinal interaction (the effect is present in one condtion, 0 and 1, but disappears in the other condition, with means 0 and 0). We can calcuate the interaction effect as follows. First, let's look at the interaction in a 2x2 matrix:

<img src="06-effectsize_files/figure-html/unnamed-chunk-5-1.png" width="100%" style="display: block; margin: auto;" />

```
##    a1 a2
## b1  1  0
## b2  0  1
```

The grand mean is (1 + 0 + 0 + 1) / 4 = 0.5.

We can compute the marginal means for A1, A2, B1, and B2, which is simply averaging per row and column, which gets us for the A1 row (1+0)/2=0.5. For this perfect disordinal interaction, all marginal means are 0.5. This means there are no mean effects. There is no main effect of factor A (because the marginal means for A1 and A2 are both exactly 0.5), nor is there a main effect of B.

We can also calculate the interaction effect. For each cell we take the value in the cell (e.g., for a1b1 this is 1) and compute the difference between the cell mean and the additive effect of the two factors as:

1 - (the grand mean of 0.5 + (the marginal mean of a1 minus the grand mean, or 0.5 - 0.5 = 0) + (the marginal mean of b1 minus the grand mean, or 0.5 - 0.5 = 0)). Thus, for each cell we get:

a1b1: 1 - (0.5 + (0.5 -0.5) + (0.5 -0.5)) = 0.5

a1b2: 0 - (0.5 + (0.5 -0.5) + (0.5 -0.5)) = -0.5

a2b1: 0 - (0.5 + (0.5 -0.5) + (0.5 -0.5)) = -0.5

a2b2: 1 - (0.5 + (0.5 -0.5) + (0.5 -0.5)) = 0.5

Cohen's $f$ is then $f = \frac { \sqrt { \frac { 0.5^2 +-0.5^2 + -0.5^2 + 0.5^2 } { 4 } }}{ 2 } = 0.25$

or in R code: `sqrt(((0.5)^2 +(-0.5)^2 + (-0.5)^2 + (0.5)^2)/4)/2 = 0.25`.

For the ordinal interaction the grand mean is (1 + 0 + 0 + 0) / 4, or 0.25. The marginal means are a1: 0.5, a2: 0, b1: 0.5, and b2: 0.

Completing the calculation for all four cells for the ordinal interaction gives:

a1b1: 1 - (0.25 + (0.5 -0.25) + (0.5 -0.25)) = 0.25

a1b2: 0 - (0.25 + (0.5 -0.25) + (0.0 -0.25)) = -0.25

a2b1: 0 - (0.25 + (0.0 -0.25) + (0.5 -0.25)) = -0.25

a2b2: 0 - (0.25 + (0.0 -0.25) + (0.0 -0.25)) = 0.25

Cohen's $f$ is then $f = \frac { \sqrt { \frac { 0.25^2 +-0.25^2 + -0.25^2 + 0.25^2 } { 4 } }}{ 2 } = 0.125$.

or in R code: `sqrt(((0.25)^2 +(-0.25)^2 + (-0.25)^2 + (0.25)^2)/4)/2 = 0.125`.


We see the effect size of the cross-over interaction (*f* = 0.25) is twice as large as the effect size of the ordinal interaction (*f* = 0.125). 

If the math so far was a bit too much to follow, there is an easier way to think of why the effect sizes are halved. In the disordinal interaction we are comparing cells a1b1 and a2b2 against a1b2 and a2b1, or (1+1)/2 vs. (0+0)/2. Thus, if we see this as a *t*-test for a contrast, it is clear the mean difference is 1, as it was in the simple effect we started with. For the ordinal interaction, we have (1+0)/2 vs. (0+0)/2, so the mean difference is halved, namely 0.5. 

### Power for interactions

All of the above obviously matters for the statistical power we will have when we examine interaction effects in our experiments. Let's use Superpower to perform power analyses for the disordinal interaction first, if we would collect 50 participants in each condition. 


```r
design <- Superpower::ANOVA_design(
  design = "2b*2b", 
  n = 50, 
  mu = c(1, 0, 0, 1), 
  sd = 2)
```

<img src="06-effectsize_files/figure-html/unnamed-chunk-6-1.png" width="100%" style="display: block; margin: auto;" />

```r
Superpower::ANOVA_exact(design, alpha_level = 0.03)
```

```
## Power and Effect sizes for ANOVA tests
##      power partial_eta_squared cohen_f non_centrality
## a    3.000                0.00  0.0000            0.0
## b    3.000                0.00  0.0000            0.0
## a:b 91.055                0.06  0.2525           12.5
## 
## Power and Effect sizes for pairwise comparisons (t-tests)
##                       power effect_size
## p_a_a1_b_b1_a_a1_b_b2 61.78        -0.5
## p_a_a1_b_b1_a_a2_b_b1 61.78        -0.5
## p_a_a1_b_b1_a_a2_b_b2  3.00         0.0
## p_a_a1_b_b2_a_a2_b_b1  3.00         0.0
## p_a_a1_b_b2_a_a2_b_b2 61.78         0.5
## p_a_a2_b_b1_a_a2_b_b2 61.78         0.5
```

```
## Power and Effect sizes for ANOVA tests
##      power partial_eta_squared cohen_f non_centrality
## a    3.000                0.00  0.0000            0.0
## b    3.000                0.00  0.0000            0.0
## a:b 91.055                0.06  0.2525           12.5
## 
## Power and Effect sizes for pairwise comparisons (t-tests)
##                       power effect_size
## p_a_a1_b_b1_a_a1_b_b2 61.78        -0.5
## p_a_a1_b_b1_a_a2_b_b1 61.78        -0.5
## p_a_a1_b_b1_a_a2_b_b2  3.00         0.0
## p_a_a1_b_b2_a_a2_b_b1  3.00         0.0
## p_a_a1_b_b2_a_a2_b_b2 61.78         0.5
## p_a_a2_b_b1_a_a2_b_b2 61.78         0.5
```

First let's look at the Power and Effect size for the pairwise comparisons. Not surprisingly, these are just the same as our original t-test, given that we have 50 observations per condition, and our mean difference is either 1, or a Cohen's d of 0.5 (in which case we have 61.78% power) or the mean difference is 0, and we have no power (because there is no true effect) but we wil observe significant results 3% of the time because we set our apha level to 0.03.

Then, let's look at the results for the ANOVA. Since there are no main effects in a perfect crossover interaction, we have a 3% Type 1 error rate. We see the power for the crossover interaction between factor a and b is 91.06%. This is much larger than the power for the simple effects. The reason is that the contrast that is equal to the test of the interaction is based on all 200 observations. Unlike the pairwise comparisons with 50 vs 50 observations, the contrast for the interaction has 100 vs 100 observations. Given that the effect size is the same (*f* = 0.25) we end up with much higher power. 

If you have heard that it is impossible to find a statistically significant interaction without huge sample size, you clearly see this is wrong. Power *can* be higher than for the simpe effect - but this depends on the pattern of means underlying the interaction. If possible, design studies where your theory predicts a perfect crossover interaction.


For the ordinal interaction, our statistical power does not look that good based on an a-priori power analysis. SUperpower tells us we have 33.99% power for the main effects and interaction (yes, we have exactly the same power for all three - if you think about the three contrasts that are tested, these have the same effect size). 


```r
design <- Superpower::ANOVA_design(
  design = "2b*2b", 
  n = 50, 
  mu = c(1, 0, 0, 0), 
  sd = 2)
```

<img src="06-effectsize_files/figure-html/unnamed-chunk-7-1.png" width="100%" style="display: block; margin: auto;" />

```r
Superpower::ANOVA_exact(design, alpha_level = 0.03)
```

```
## Power and Effect sizes for ANOVA tests
##       power partial_eta_squared cohen_f non_centrality
## a   33.9869              0.0157  0.1263          3.125
## b   33.9869              0.0157  0.1263          3.125
## a:b 33.9869              0.0157  0.1263          3.125
## 
## Power and Effect sizes for pairwise comparisons (t-tests)
##                       power effect_size
## p_a_a1_b_b1_a_a1_b_b2 61.78        -0.5
## p_a_a1_b_b1_a_a2_b_b1 61.78        -0.5
## p_a_a1_b_b1_a_a2_b_b2 61.78        -0.5
## p_a_a1_b_b2_a_a2_b_b1  3.00         0.0
## p_a_a1_b_b2_a_a2_b_b2  3.00         0.0
## p_a_a2_b_b1_a_a2_b_b2  3.00         0.0
```

```
## Power and Effect sizes for ANOVA tests
##       power partial_eta_squared cohen_f non_centrality
## a   33.9869              0.0157  0.1263          3.125
## b   33.9869              0.0157  0.1263          3.125
## a:b 33.9869              0.0157  0.1263          3.125
## 
## Power and Effect sizes for pairwise comparisons (t-tests)
##                       power effect_size
## p_a_a1_b_b1_a_a1_b_b2 61.78        -0.5
## p_a_a1_b_b1_a_a2_b_b1 61.78        -0.5
## p_a_a1_b_b1_a_a2_b_b2 61.78        -0.5
## p_a_a1_b_b2_a_a2_b_b1  3.00         0.0
## p_a_a1_b_b2_a_a2_b_b2  3.00         0.0
## p_a_a2_b_b1_a_a2_b_b2  3.00         0.0
```

If you have heard people say you should be careful when designing studies predicting interaction patterns because you might have very low power, this is the type of pattern of means they are warning about. Maxwell, Delaney, and Kelley (2018) discuss why power for interactions is often smaller, and note interactions effects are often smaller in the real world, and we often examine ordinal interactions. This might be true. But in experimental psychology it might be possile to think about hypotheses that predict disordinal interactions. In addition to the fact that such predictions are often theoretically riskier and more impressive (after all, many things can make an effect go away, but without your theory it might be difficult to explain why an effect flips around) they also have larger effects and are easier to test with high power.

Some years ago other blog posts by [Uri Simonsohn](http://datacolada.org/17) and [Roger Giner-Sorolla](https://approachingblog.wordpress.com/2018/01/24/powering-your-interaction-2/) did a great job in warning researchers they need large sample sizes for ordinal interactions, and my post repeats this warning. But it would be a shame if researchers would stop examining interaction effects. There are some nice benefits studying interactions, such as 1) making riskier theoretical predictions, 2) greater generalizability (if there is no interaction effect, you might show a main effect operates across different conditions of a second factor) and 3) if you want to study two main effects it is more efficient to do this in a 2x2 design than in two seperate designs (Maxwell, Delaney, & Kelley, 2018). So maybe this blog post has been able to highlight some scenarios where examining interaction effects is still beneficial.



