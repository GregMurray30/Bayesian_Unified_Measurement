# Bayesian_Unified_Measurement
A Bayesian approach to unifying results from MTA and MMM models

## Run Instructions:
-After cloning the repo, open the file MMM_Sim_geom.rmd in RStudio. 
-Then, exectute the first code block that contains required packages. 
-Click "yes" when prompted as install the necessary packages.
-Execute the second and then third code blocks in that order. 
The code stores a lot of information but will print out the final MAPE for both the BUMM and a regular MMM model at the end.

This repo contains the code for a prototype for unifying an MTA model (or any model that estimates the revenue attributable to a digital media channel that is hypothesized to have cannabalized revenue from traditional media channels) and an MMM model.
The approach is straightforward in that it uses the revenue estimate(s) from the MTA to extract priors for the digital channel(s) to then feed into an MMM that contains spend time series for all channels of interest.
It is assumed that the estimate(s) from the MTA will be biased upwards since it likely has taken credit for some revenue that should be attributed to traditional media. The first steps
