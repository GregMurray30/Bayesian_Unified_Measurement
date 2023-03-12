# Bayesian_Unified_Measurement
A Bayesian approach to unifying results from MTA and MMM models

## RUN INSTRUCTIONS:
- Open the file MMM_Sim_geom.rmd in RStudio
- Execute the first code block that contains required packages
- Click "yes" when prompted to install the necessary packages
- Execute the second and then third code blocks in that order
- To generate more than one simulation result, uncomment lines 83 and 503 (you can change the number of simulation results generated by changing the number of iterations in the for loop in line 83). Each run takes approximately 12-20 minutes depending on your machine.

The code will print out the final MAPE for both the BUMM and the regular MMM model at the end as well as store both MAPEs in a local csv file.

## SUMMARY
This repo contains the code for demonstrating POC for a unified media measurement (UMM) model via a simulation. The UMM reconciles results from an MTA model (or any model that estimates the revenue attributable to a digital media channel that is hypothesized to have cannabalized revenue from traditional media channels) and an MMM model.
The approach uses the revenue estimate(s) from the MTA to extract priors for the digital channel(s) to then feed into an MMM that contains spend time series for all channels of interest.
It is assumed that the estimate(s) from the MTA will be biased upwards since it likely assigned revenue that should be attributed to traditional media to some or all of the digital channels in the MTA's touchpoint vector inputs (individuals may be exposed to non-digital impressions but those don't show up in digitally tracked touchpoint vectors so no credit is given to them). 

## RESULTS

As configured, a sample of 30 simulations yielded a statistically significant BUMM improvement in MAPE over a regular MMM with an expected improvement of 13.8 percentage points. 
- Average BUMM MAPE: 26.8%
- Average MMM MAPE: 40.6%
