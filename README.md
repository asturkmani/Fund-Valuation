# Fund-Valuation
Statistical model simulating future cash flows of a hedge fund to compute valuation of fund.
This model simulates future growth paths using based on continous sampling from parameter distrbutions.

The end result is a distribution of future cash flows which are discounted to obtain a distribution over possible present values
for the fund, from which an expected value can be computed and used as a guide for valuation.

-----
Sim.m selects the specific allocation of capital across different investment strategies. 
Fin_values.m creates the parameters of each investment strategy 
quarterlySimV3.m simulates the probabilistic growth over each quarter. 
