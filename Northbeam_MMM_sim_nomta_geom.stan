functions {
// the Hill function
real Hill(real t, real k, real slope) {

  return 1 / (1 + (t / k)^(-slope));
}

//AB Reach function
real Reach(real t, real a, real b) {

  return a - ( b/(t+(b/a)) );
}

// the adstock transformation with a vector of weights
real Adstock(row_vector t, row_vector weights) {
  return dot_product(t, weights);

  }
  


}
data {
  
  // the total number of observations
  int<lower=1> N;
  // the vector of sales
  real<lower=0> Y[N];
  // the maximum duration of lag effect, in weeks
  int<lower=1> max_lag;
  // the number of media channels
  int<lower=1> num_media;
  int<lower=1> num_media_inter;
  int<lower=1> num_media_full;

  int<lower=1> num_params;

  // 3D array of media variables
  row_vector[max_lag] X_media[N, num_media_full]; 
  //int<lower=1> num_ctrl;
  // a matrix of control variables
  //row_vector[num_ctrl] X_ctrl[N];

}

parameters {
// residual variance
real<lower=0> noise_var;
//real<lower=0> chnl_sigma[N];

// the intercept
 real<lower=0> nu;
// the coefficients for media variables
vector<lower=0>[num_media] beta_medias;
vector[num_media_inter] beta_medias_inter;

// coefficients for other control variables
//vector[num_ctrl] gamma_ctrl;

// the retention rate and delay parameter for the adstock transformation of
// each media
vector<lower=0,upper=1>[num_media_full] alpha;

//vector<lower=0,upper=max_lag-1>[num_media] delay;

// ec50 and slope for Hill function of each media
vector<lower=0,upper=1>[num_media_full] k;
vector<lower=0>[num_media_full] slope;

// vector<lower=0>[num_media] a;
// vector<lower=0>[num_media] b;
}

transformed parameters {

  // a vector of the mean response
  real mu[N];
  // the cumulative media effect after adstock
  real cum_effect_t;
  // the cumulative media effect after adstock, and then Hill transformation
  row_vector[num_media_full] cum_effects_hill[N];
 // row_vector[num_media] cum_effects_reach[N];
  vector[num_media_full] beta_medias_full;
  row_vector[max_lag] lag_weights;
  
  
  beta_medias_full = append_row(beta_medias, beta_medias_inter);
  
  for (nn in 1:N) {
    for (media in 1 : num_media_full) {
      for (lag in 1 : max_lag) {
        lag_weights[lag] = pow(alpha[media], (lag - 1));
      }
      cum_effect_t = Adstock(X_media[nn, media], lag_weights);
      cum_effects_hill[nn, media] = Hill(cum_effect_t, k[media], slope[media]);
    //  cum_effects_reach[nn, media] = Reach(cum_effect_t, a[media], b[media]);

    }
  mu[nn] = nu + dot_product(cum_effects_hill[nn], beta_medias_full);
  //mu[nn] = nu + sum(cum_effects_reach[nn]);

  //dot_product(X_ctrl[nn], gamma_ctrl);
  }
}

model {
   for (media_index in 1 : num_media_full) {
    alpha[media_index] ~ beta(1, 1);
   }
  // alpha[1] ~ normal(.36, .25);

  //delay ~ uniform(0, max_lag - 1);
  
  // beta_medias[1] ~ normal(1.03*.1, .25*2);
   beta_medias ~ normal(1, 1);

   for (media_index in 1 : num_media_inter) {
    beta_medias_inter[media_index] ~ uniform(-1, 1);
   }


   //k[1] ~ normal(.7, .25);
   for (media_index in 1 : num_media_full) {
    k[media_index] ~ beta(1, 1);
   }

   //slope[1] ~ normal(.52, .25);
   for (media_index in 1 : num_media_full) {
    slope[media_index] ~ normal(2, 2);
   }
   
   nu ~ normal(2, 1);
 //a ~ gamma(2, 3);
//b ~ gamma(2, 4);

  
 // noise_var ~ inv_gamma(0.05, 0.05 * 0.01);
  //chnl_sigma ~ normal(1, .1);
  noise_var ~ normal(0,0.2);
  for(i in 1:N) {
    Y[i] ~ normal(mu[i], mu[i]*noise_var);
  }
}


