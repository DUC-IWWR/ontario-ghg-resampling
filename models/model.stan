data {
  int <lower = 0> N;
  array [N] real y;
  
  int <lower = 0> n_factor1;
  array [N] int factor1;
  
  int <lower = 0> n_factor2;
  array [N] int factor2;
  
  int <lower = 0> n_interaction;
  array [N] int interaction;
}

parameters {
  real mu;
  
  real alpha_hyper;
 // real beta_hyper;
  real gamma_hyper;
  
  row_vector [n_factor1] alpha_raw;
  row_vector [n_factor2] beta;
  row_vector [n_interaction] gamma_raw;
  
  real<lower=0> sigma;
  //real<lower = 0> sigma_alpha;
  //real<lower = 0> sigma_beta;
  //real<lower = 0> sigma_gamma;
}

transformed parameters {
  row_vector [n_factor1] alpha;
 // row_vector [n_factor2] beta;
  row_vector [n_interaction] gamma;  
  
  alpha = alpha_hyper + alpha_raw;// * sigma_alpha;
  //beta = beta_hyper + beta_raw;// * sigma_beta;
  gamma = gamma_hyper + gamma_raw;// + sigma_gamma;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  y ~ normal(mu + alpha[factor1] + beta[factor2] + gamma[interaction], sigma);
  
  mu ~ normal(0, 3);
  
  // alpha ~ normal(alpha_hyper, sigma_alpha);
  // beta ~ normal(beta_hyper, sigma_beta);
  // gamma ~ normal(gamma_hyper, sigma_gamma);
  
  alpha_raw ~ std_normal();
  beta ~ std_normal();
  gamma_raw ~ std_normal();
  
  alpha_hyper ~ std_normal();
  //sigma_alpha ~ exponential(1);
  
  //beta_hyper ~ std_normal();
  //sigma_beta ~ exponential(1);
  
  gamma_hyper ~ std_normal();
  //sigma_gamma ~ exponential(1);
  
  sigma ~ exponential(1);
}

