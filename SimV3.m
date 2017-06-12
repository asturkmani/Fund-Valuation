%% Simulation V2.0
tic
close all; clearvars;
format long g
profile on
%% Constants
create_constants

for allocation=1:3
    counter_eq = 1;
    %% Create the variables needed
    cagrQ = cagrQL(allocation);
    cagrA = cagrAL(allocation);
    stdQ = stdQL(allocation);
    stdA = stdAL(allocation);
    discount_rate = rate(allocation);
    load('vars.mat')
    %% Simulations
    for i=1:num_iterations
        returns = normrnd(cagrQ,stdQ,num_periods,1);
        broken=false;
        burn_capital_payback = zeros(num_periods,1);
        for cP=1:num_periods
            % run quarterly simulation
            quarterlySimulationV3;
        end
        % compound numbers across iterations
        compound_nums
    end
    %% Create final values to be stored in excel
    fin_values
end
profile viewer
toc
