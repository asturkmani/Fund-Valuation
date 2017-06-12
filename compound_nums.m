%% Compound Numbers
gp_equity = 0.1:0.05:0.6;
for ll=1:11
    temp = irr([-50e6; total_fees_net.*gp_equity(ll); seed_capital*vami(num_periods+1)/1000]);
    irr_seed(i,ll) = (1+temp)^4 - 1;
    temp = irr([-5e6; burn_capital_payback]);
    irr_burn(i,ll) = (1+temp)^4 - 1;
    temp = irr([-55e6; total_fees_net.*gp_equity(ll) + burn_capital_payback; seed_capital*vami(num_periods+1)/1000]);
    irr_seedburn(i,ll) = (1+temp)^4 - 1;
end

bonus_mean = bonus_mean + bonus;
outflows_mean = outflows_mean+outflows';
expenses_mean = expenses_mean + nonpayroll_costQ + payroll_costQ;
management_fees_mean = management_fees_mean + management_fees;
management_fees_net = management_fees_mean - expenses_mean;
ending_aum_mean = ending_aum_mean + ending_aum;
performance_fees_mean = performance_fees + performance_fees_mean;
vami_mean=vami_mean+vami;
aum_terminal = [aum_terminal, starting_aum];
new_money_mean = new_money_mean + new_money;
total_fees_mean = total_fees_mean+total_fees_net;
fees_discounted_mean(i) = pvvar(total_fees_net,rate(allocation));
fees_compounded_mean(i) = fvvar(total_fees_net,rate(allocation));
returns_mean = returns_mean + returns;
profits_mean = profits + profits_mean;
mult_f = mult_f + new_money_mult;