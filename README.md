# Bayesian_Unified_Measurement
A Bayesian approach to unifying results from MTA and MMM models

## RUN INSTRUCTIONS:
- After cloning the repo, open the file MMM_Sim_geom.rmd in RStudio. 
- Exectute the first code block that contains required packages. 
- Click "yes" when prompted to install the necessary packages.
- Execute the second and then third code blocks in that order. 
- If you wish to collect the performances for multiple simulation runs in the file mflow_basic2.csv, then after the initial run you must change the line #500 to "ml_flow_basic2 = rbind(ml_flow_basic2, c(MAPE_hyb_bumm_agg, MAPE_hyb_nomta_agg))"

The code will print out the final MAPE for both the BUMM and the regular MMM model at the end.

## SUMMARY
This repo contains the code for demonstrating POC for a unified media measurement (UMM) model via a simulation. The UMM reconciles results from an MTA model (or any model that estimates the revenue attributable to a digital media channel that is hypothesized to have cannabalized revenue from traditional media channels) and an MMM model.
The approach uses the revenue estimate(s) from the MTA to extract priors for the digital channel(s) to then feed into an MMM that contains spend time series for all channels of interest.
It is assumed that the estimate(s) from the MTA will be biased upwards since it likely assigned revenue that should be attributed to traditional media to some or all of the digital channels in the MTA's touchpoint vector inputs (individuals may be exposed to non-digital impressions but those don't show up in digitally tracked touchpoint vectors so no credit is given to them). 

