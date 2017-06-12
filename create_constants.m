% Create Constants
% Simulation constants
num_iterations = 10000;
num_years = 10;
periods_per_year = 4;
num_periods = num_years*periods_per_year;
burn_cap = 5e6;
seed_cap = 50e6;
div_rate = 2/100;
new_money_q1 = 1e6;

% Performance constants
cagrAL = [29.67/100, 35.30/100, 40.90/100, 52.04/100, 62.79/100];
cagrQL = [6.71/100, 7.85/100, 8.95/100, 11.04/100, 12.99/100];
stdQL  = [5.60/100, 7.38/100, 9.25/100, 13.07/100, 16.89/100];
stdAL =  [11.21/100, 14.75/100, 18.50/100, 26.15/100, 33.79/100];
rate   = [3.6/100,	4.4/100, 5.3/100,	7.0/100,   8.5/100];

% Business constants
payroll_costA = [1696200,2125137.143,2862860,3229728.543,3815486.431,6794419.588,7791831.438,8571014.582,10358556.07,11394411.68]';
payroll_costQ = [repmat(payroll_costA(1)./4,4,1); repmat(payroll_costA(2)./4,4,1); repmat(payroll_costA(3)./4,4,1); repmat(payroll_costA(4)./4,4,1); repmat(payroll_costA(5)./4,4,1); repmat(payroll_costA(6)./4,4,1); repmat(payroll_costA(7)./4,4,1); repmat(payroll_costA(8)./4,4,1); repmat(payroll_costA(9)./4,4,1); repmat(payroll_costA(10)./4,4,1)];
bonus_m = [3.5,3.3,3,2.9,2.8,2.8,2.7,2.7,2.6,2.6];
nonpayroll_costQ = [322477,322477,322477,322477,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,129166.75,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25,258333.25]';    
management_fees_rate = 0.5/100;
performance_fees_rate = 20.0/100;
hurdleRate = 0;