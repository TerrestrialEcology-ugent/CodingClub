simu_pres
========================================================
author: Lionel Hertzog
date: 23.05.2018
autosize: true

Simulation: what is it?
========================================================

What is simulation for you?


Simulation: what is it?
========================================================

What Wikipedia says: 

"Simulation is the **imitation** of the operation of a real-world process or system. The act of simulating something first requires that a **model** be developed; this model represents the key characteristics, behaviors and functions of the selected physical or abstract system or process. The model **represents** the system itself, whereas the simulation represents the **operation** of the system over time."

Generating stochasticity - the r* functions
========================================================

Generate **r**andom **unif**orm values:


```r
runif(n = 10, min = 0, max = 10)
```

```
 [1] 5.0595058 0.6402099 8.1797133 7.8459542 4.1261361 2.4902452 3.8187912
 [8] 9.0134857 1.5458878 4.2628845
```

Generate **r**andom **norm**al values:


```r
rnorm(n = 10, mean = 0, sd = 5)
```

```
 [1]   4.416878   5.277048   5.411496  -2.168815  -2.494758   1.609222
 [7] -10.115260   4.157660   2.826946  -1.672523
```

Generating stochasticity - the r* functions
========================================================

Generate **r**andom **binom**ial values:


```r
rbinom(n = 10, size = 10, prob = 0.5)
```

```
 [1] 7 8 3 5 5 5 4 4 5 6
```

Generate **r**andom **pois**son values:


```r
rpois(n = 10, lambda = 5)
```

```
 [1]  5  4  4  2  9  7  5 10  5  8
```


Simple simulation example
========================================================

The probability that a baby is a girl is 48.8%, suppose we go to an hospital which recently had 100 births, how many of them can we expect to be girls?


```r
rbinom(n = 1, size = 100, prob = 0.488)
```

```
[1] 52
```

Or:


```r
sum(rbinom(n = 100, size = 1, prob = 0.488))
```

```
[1] 62
```

Exercice
========================================================

As this is a stochastic (random) draw, the best would be to repeat this, say 50 times, to get an idea of the **distribution** of expected number of girls.

Your task:

* Generate 50 simulated values
* Plot an histogram for these values

Solution I
========================================================


```r
nb_sims <- 50
nb_girls <- vector(length=nb_sims)
for(i in 1:nb_sims){
  nb_girls[i] <- rbinom(1,100,0.488)
}
hist(nb_girls)
```

![plot of chunk unnamed-chunk-7](simu_pres-figure/unnamed-chunk-7-1.png)

Solution II
=======================================================


```r
nb_sims <- 50
nb_girls <- sapply(1:nb_sims, function(x) rbinom(1,100,0.488))
hist(nb_girls)
```

![plot of chunk unnamed-chunk-8](simu_pres-figure/unnamed-chunk-8-1.png)

Solution III
======================================================


```r
nb_girls <- replicate(n = 50,expr = rbinom(1,100,0.488))
hist(nb_girls)
```

![plot of chunk unnamed-chunk-9](simu_pres-figure/unnamed-chunk-9-1.png)

Using simulations to test model fitness
====================================================

* Every statistical models make some assumptions about the process that generated the data

* We could use this idea for:
   * A priori exploration of models via fake data simulations
   * A posteriori checks that the model is OK
   
Fake-data simulation - Exercice
===================================================

Assuming a simple linear regression:

$$y \sim N( \alpha + \beta * x, \sigma) $$

Simulate some fake data given:


```r
alpha <- 1
beta <- 2
sigma <- 1
x <- 1:10
```

Then fit a **lm** to this data and check if the model worked good.

Power analysis
===================================================

This could be easily extended to do power analysis

* Generate fake data **N** time with varying sample size
* Fit the model to each fake data set
* Grab the p-value(s) of the parameter(s) of interest
* Compute the proportion of times the parameter(s) was/were significant (this is power)

Power analysis - Exercice
================================================

Conduct a power analysis of the **regression slope** with the following model:

$$ y \sim Poisson(exp(0.5 + 0.25 * x)) $$

With x:

```r
x <- runif(10, -2, 2)
```

And **n** being the sample size varying from 10 to 100 in steps of 10

Power analysis - Results
=================================================

![plot of chunk unnamed-chunk-12](simu_pres-figure/unnamed-chunk-12-1.png)



