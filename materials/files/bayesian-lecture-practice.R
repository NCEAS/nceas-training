### Lecture practice: Moth coloration
### Simple Bayesian regression model

library(rjags)
library(mcmcplots)
library(broom.mixed)
library(tidyverse)

### Program statistical model in JAGS
mstring <- "
model{
  for(i in 1:N){
    y[i] ~ dbin(p[i], n[i])
    y.rep[i] ~ dbin(p[i], n[i])
    logit(p[i]) <- beta[1, m[i]] + beta[2, m[i]] * x[i]
  }
  for(p in 1:2){
    for(j in 1:Nm){
        beta[p, j] ~ dnorm(0, 0.00001)
    }
  }
}
"

### Read in moth data
moths <- data.frame(site = rep(1:7, each = 2),
                    morph = rep(1:2, times = 7),
                    distance = rep(c(0, 7.2, 24.1, 30.2, 36.4, 41.5, 51.2), each = 2),
                    placed = rep(c(56, 80, 52, 60, 60, 84, 92), each = 2),
                    removed = c(13, 14, 28, 20, 18, 22, 9, 16, 16, 23, 20, 40, 24, 39))

### Create list of data inputs to model; list names must correspond to variable names in model
datlist <- list(y = moths$removed, 
                n = moths$placed,
                x = moths$distance,
                m = moths$morph,
                N = nrow(moths),
                Nm = length(unique(moths$morph)))


### Fit data to model using MCMC
# Compile model object
jm <- jags.model(file = textConnection(mstring),
                 data = datlist,
                 n.chains = 3)

# Sample the posterior
jm_coda <- coda.samples(model = jm,
                        variable.names = c("beta", "y.rep"),
                        n.iter = 3000)

# Visualize trace plots for beta
traplot(jm_coda,
        parms = c("beta"))

# Visualize all diagnostic plots for beta
mcmcplot(jm_coda,
         parms = c("beta"))


# Re-compile model
jm <- jags.model(file = textConnection(mstring),
                 data = datlist,
                 n.chains = 3)

# Re-run model for 10 times as long, thinning by 10
jm_coda <- coda.samples(model = jm,
                        variable.names = c("beta", "y.rep"),
                        n.iter = 3000*10,
                        thin = 10)

# Visualize all diagnostic plots for beta
mcmcplot(jm_coda,
         parms = c("beta"))

# Confirm model convergence with Rhat criteria
gelman.diag(jm_coda, multivariate = FALSE)

### Interpretation
# Plot posterior beta parameters
caterplot(jm_coda, 
          parms = "beta",
          reorder = FALSE)

# Report posterior summary statistics
sum_out <- broom.mixed::tidyMCMC(jm_coda, 
                                 conf.int = TRUE, 
                                 conf.level = 0.95)

# Determine if beta parameters are significant
beta_sum <- sum_out %>%
    filter(grepl("beta", term)) %>%
    mutate(sig = ifelse(conf.low*conf.high > 0, TRUE, FALSE))

# Plot model fit
fit <- cbind.data.frame(moths, 
                        sum_out %>% filter(grepl("y.rep", term)))

ggplot(fit, aes(x = removed, y = estimate)) +
    geom_abline(slope = 1, 
                intercept = 0, 
                color = "red") +
    geom_pointrange(aes(ymin = conf.low, 
                        ymax = conf.high, 
                        color = as.factor(morph))) +
    scale_color_manual(values = c("lightgray", "black")) +
    theme_bw(base_size = 12)

summary(lm(estimate ~ removed, data = fit))
