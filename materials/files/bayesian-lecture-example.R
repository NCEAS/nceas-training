### Lecture example: Snow fences
### Simple hierarchical Bayesian model

library(rjags)
library(mcmcplots)

### Program statistical model in JAGS
mstring <- "
model{
  for(i in 1:N){
    y[i] ~ dpois(theta[i]*x[i])
    theta[i] ~ dgamma(alpha, beta)
  }
  alpha ~ dgamma(2, 1)
  beta ~ dexp(1)
  pmean_theta <- alpha/beta
  pstd_theta <- sqrt(alpha/beta^2)
}
"

### Read in snow fence data
sf <- data.frame(y = c(138, 91, 132, 123, 173, 124, 109, 154, 138, 134),
                 x = c(72, 50, 55, 60, 78, 63, 54, 70, 80, 68))

### Create list of data inputs to model; list names must correspond to variable names in model
datlist <- list(y = sf$y, 
                x = sf$x,
                N = nrow(sf))

### Specifying initials
# Use sample mean to get a rough starting point
mean(sf$y/sf$x)
# Create list of lists of initial values, # of lists should correspond to # of chains
# Specify values for root nodes, names must correspond to variable names in model
# Allow the value to vary widely around the sample mean
initslist <- list(list(alpha = 0.5, beta = 1),
                  list(alpha = 4, beta = 2),
                  list(alpha = 30, beta = 1.5))

### Fit data to model using MCMC
# Compile model object
jm <- jags.model(file = textConnection(mstring),
                 data = datlist,
                 inits = initslist,
                 n.chains = 3)

# Sample the posterior
jm_coda <- coda.samples(model = jm,
                        variable.names = c("theta", "alpha", "beta",
                                           "pmean_theta", "pstd_theta"),
                        n.iter = 3000)

# Visualize trace plots
traplot(jm_coda,
        parms = c("theta", "alpha", "beta"))

# Visualize all diagnostic plots for alpha and beta
mcmcplot(jm_coda,
         parms = c("alpha", "beta"))


# Re-compile model
jm <- jags.model(file = textConnection(mstring),
                 data = datlist,
                 inits = initslist,
                 n.chains = 3)

# Re-run model for 20 times as long, thinning by 20
jm_coda <- coda.samples(model = jm,
                        variable.names = c("theta", "alpha", "beta",
                                           "pmean_theta", "pstd_theta"),
                        n.iter = 3000*20,
                        thin = 20)
# Visualize all diagnostic plots for alpha and beta
mcmcplot(jm_coda,
         parms = c("alpha", "beta"))

# Confirm model convergence with Rhat criteria
gelman.diag(jm_coda, multivariate = FALSE)

### Interpretation
# Plot posterior theta parameters
caterplot(jm_coda, 
          parms = "theta",
          reorder = FALSE)

# Report posterior summary statistics for population level mean and std
summary(jm_coda)[[1]]
