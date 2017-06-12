%% Create Variables
% iteration variables
tic
clearvars;
delete('vars.mat')

create_constants

values=zeros(7,11);
values(1,:) = 0.1:0.05:0.6;

profits = zeros(num_periods,1);
new_money = zeros(num_periods,1);
bonus = zeros(num_periods,1);
ending_aum = zeros(num_periods,1);
starting_aum = zeros(num_periods,1);
total_fees_net = zeros(num_periods,1);
annual_returns = zeros(num_periods,1);
annual_total_expenses = zeros(num_periods,1);
annual_total_fees = zeros(num_periods,1);
irr_seed = zeros(num_iterations,11);
irr_burn = zeros(num_iterations,11);
irr_seedburn = zeros(num_iterations,11);

% new money multipliers
time_mult = zeros(num_periods,1);
ret_mult = zeros(num_periods,1);
aum_mult = zeros(num_periods,1);
rand_mult = zeros(num_periods,1);
new_money_mult = zeros(num_periods,1);
mult_f = zeros(num_periods,1);

% fees
total_fees_discounted = zeros(num_periods,1);
total_fees_compounded = zeros(num_periods,1);
management_fees = zeros(num_periods,1);
performance_fees = zeros(num_periods,1);
management_fees_net = zeros(num_periods,1);

% Averaging variables
aum_terminal = zeros(size(starting_aum,1),size(starting_aum,2));
new_money_mean = zeros(size(new_money));
fees_discounted_mean = zeros(num_iterations,1);
fees_compounded_mean = zeros(num_iterations,1);
returns_mean = zeros(num_periods,1);
profits_mean = zeros(num_periods,1);

expenses_mean = zeros(num_periods,1);

performance_fees_mean = zeros(num_periods,1);
bonus_mean = zeros(num_periods,1);
management_fees_mean = zeros(num_periods,1);
total_fees_mean = zeros(num_periods,1);
ending_aum_mean = zeros(num_periods,1);
outflows_mean = zeros(num_periods,1);
survival_years = zeros(num_iterations,1);
vami = zeros(num_periods,1);
vami_mean = zeros(num_periods+1,1);
burn_capital_payback = zeros(num_periods,1);
survive=0;
start=1000;

annual_total_expenses = zeros(40,1);
annual_total_fees = zeros(40,1);
annual_returns = zeros(40,1);

save('vars.mat');
toc