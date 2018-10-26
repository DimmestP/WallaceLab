data {
  // Number of RNAs
  int<lower=1> NRNA;     
  
  // Note: These are all integers
  // columns t, s, p
  int<lower=0> tot_obs[NRNA];
  int<lower=0> sup_obs[NRNA];
  int<lower=0> p100_obs[NRNA];
}
parameters {
  // Unnormalized mixing proportions
  // real<lower=0> mixing_t;
  real<lower=0> mixing_sup;
  real<lower=0> mixing_p100;
  
  // dispersion parameter for counts
  real phi;
}
model{
  // mixing ratios
  mixing_sup ~ gamma(1,1);
  mixing_p100 ~ gamma(1,1);
  // Cauchy prior for negbin dispersion parameter
  phi ~ cauchy(0,3);
  
  for(idx in 1:NRNA){ 
    // count distn negative binomial with specified means
    // Total
    tot_obs[idx] ~ neg_binomial_2(mixing_sup * sup_obs[idx] + mixing_p100 * p100_obs[idx], phi);
  }

}


