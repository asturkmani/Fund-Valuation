%% Get final Values
bonus_mean = bonus_mean./num_iterations;
expenses_mean = expenses_mean./num_iterations;
% outflows_mean = outflows_mean./num_iterations;
management_fees_net = management_fees_net./num_iterations;
management_fees_mean=management_fees_mean./num_iterations;
performance_fees_mean = performance_fees_mean./num_iterations;
s_aum_finalp = sum(aum_terminal,2)./num_iterations;
s_aum_finalp = s_aum_finalp(1:40);
ending_aum_mean = ending_aum_mean./num_iterations;
new_money_mean = new_money_mean./num_iterations;
vami_mean=vami_mean./num_iterations;
%     fees_discounted_final = fees_discounted_final./num_iterations;
total_fees_mean = total_fees_mean./num_iterations;
returns_mean = returns_mean./num_iterations;
profits_mean = profits_mean./num_iterations;
% mult_f = mult_f./num_iterations;

values(2,:) = mean(irr_seed,1);
values(3,:) = std(irr_seed,1); 
values(4,:) = mean(irr_burn,1); 
values(5,:) = std(irr_burn,1); 
values(6,:) = mean(irr_seedburn,1); 
values(7,:) = std(irr_seedburn,1);

soFar = 1;

for i=1:40
    soFar = soFar*(1+returns_mean(i));
    if mod(i,4)==0
        annual_total_expenses(i) = sum(expenses_mean(i-3:i-1)) + bonus_mean(i);
        annual_total_fees(i) = sum(total_fees_mean(i-3:i-1));
        annual_returns(i) = soFar;
        soFar = 1;
    end
end

ending_aum_mean([1:4:40])=0;
ending_aum_mean([2:4:40])=0;
ending_aum_mean([3:4:40])=0;
total_fees_q = total_fees_mean + bonus_mean;

%% Values to Copy into excel
excel_toPaste = [nonpayroll_costQ payroll_costQ bonus_mean returns_mean annual_returns profits_mean new_money_mean s_aum_finalp ending_aum_mean expenses_mean annual_total_expenses management_fees_net performance_fees_mean total_fees_mean annual_total_fees management_fees_mean];
excel_mean_pv_equity = mean(fees_discounted_mean);
excel_std_pv_equity = std(fees_discounted_mean);
excel_mean_fv_equity = mean(fees_compounded_mean);
excel_std_fv_equity = std(fees_compounded_mean);
excel_mean_aum = mean(aum_terminal(40,:));
excel_std_aum = std(aum_terminal(40,:));
excel_mean_Qs_to_breakeven = mean(survival_years);
excel_std_Qs_to_breakeven = std(survival_years);
excel_toPaste2 = [excel_mean_pv_equity excel_std_pv_equity;excel_mean_fv_equity excel_std_fv_equity; excel_mean_aum excel_std_aum; excel_mean_Qs_to_breakeven excel_std_Qs_to_breakeven];

save(['allocation: ',int2str(allocation)]);