% quarterly simulations

%% first quarter definitions
if cP == 1
    dividend_rate = div_rate;
    burn_capital_dividends = 0;
    burn_capital_principal = burn_cap;
    seed_capital = seed_cap;
    starting_aum(cP) = seed_cap;
    new_money(cP) = new_money_q1;
    rand_mult(cP) = rand(1)-rand(1);
    pay_bonus=false;
else
    rand_mult(cP) = 0.3*(rand(1)-rand(1)) + 0.7*(rand_mult(cP-1));
end

%% vami growth
if cP==1
    vami(cP) = start;
    vami(cP+1) = (returns(cP)+1)*vami(cP);
    vami(cP+1) = vami(cP+1)*(1-management_fees_rate);
else
    vami(cP+1) = (returns(cP)+1)*vami(cP) - performance_fees_rate*(vami(cP)-vami(cP-1));   
    vami(cP+1) = vami(cP+1)*(1-management_fees_rate);
end

% management_fees(cP) = management_fees_rate * starting_aum(cP);
profits(cP) = (starting_aum(cP) - management_fees(cP)) * returns(cP);


%% account for high water mark
% if starting aum for this year, is the greatest you have had yet, you can
% compute performance fees. Else, you have to raise your starting AUMs to
% above the previous maximum value in order to compute pFees once again.
performance_fees(cP) = 0;

[max_prev_vami,index_of_prev_max] = max(vami(1:cP-1));
if vami(cP) > max_prev_vami
    % account for hurdle rate. If returns exceed a predefined mininmum
    % rate, you can collect pFees.
%     if starting_aum(cP)- max(starting_aum(1:cP-1)) > hurdleRate*starting_aum(cP)
    
    if index_of_prev_max == cP-1
        performance_fees(cP) = performance_fees_rate*max(profits(cP),0);
    else
        watermark_rate = (vami(cP)-max_prev_vami)/(max_prev_vami);
        performance_fees(cP) =  watermark_rate*(starting_aum(cP) - management_fees(cP))*performance_fees_rate;
    end
end

% performance_fees(cP) = performance_fees_rate*max(profits(cP),0);
%% compute bonuses. Give out bonuses comparable to performance.
management_fees_net_t(cP) =  management_fees(cP) - payroll_costQ(cP) - nonpayroll_costQ(cP);

dividends = dividend_rate * burn_capital_principal;

burn_capital_dividends = burn_capital_dividends + dividends;

%if we haven't paid all our cumulated dividends start by paying the off
if burn_capital_dividends >= 0  
    pay_bonus = false;
    
    if performance_fees(cP) > 0
        if burn_capital_dividends > performance_fees(cP)
            burn_capital_dividends = burn_capital_dividends - performance_fees(cP);
            burn_capital_payback(cP) = burn_capital_payback(cP)+performance_fees(cP);
            performance_fees(cP)=0;
        else
            performance_fees(cP)=performance_fees(cP) - burn_capital_dividends;
            burn_capital_payback(cP) = burn_capital_payback(cP) + burn_capital_dividends;
            burn_capital_dividends=0;
        end
    end
    %if we have paid off dividends start paying off the principal
    if burn_capital_dividends <= 0 
        pay_bonus=true;
    end
    if burn_capital_principal > 0 && performance_fees(cP) > 0
        if performance_fees(cP) > burn_capital_principal
            performance_fees(cP) = performance_fees(cP) - burn_capital_principal;
            burn_capital_payback(cP) = burn_capital_payback(cP)+burn_capital_principal;
            burn_capital_principal = 0;
        else
            burn_capital_principal = burn_capital_principal - performance_fees(cP);
            burn_capital_payback(cP) = burn_capital_payback(cP)+performance_fees(cP);
            performance_fees(cP) = 0; 
        end
   
    end
end
% we pay bonuses at the end of the year as a factor of performance
if mod(cP,4) == 0
    if pay_bonus
        % generate a bonus pool
        bonus_pool = max(sum(management_fees_net_t(cP-3:cP)),0);

        cagr = (vami(cP)-vami(cP-3))/vami(cP-3);
        
%         if cagr > cagrA + 3*stdA
%             bonus(cP) = 15*bonus_m(cP/4)*payroll_costA(cP/4);
%         elseif cagr > cagrA + 2*stdA
%             bonus(cP) = 10*bonus_m(cP/4)*payroll_costA(cP/4);
%             
%         elseif cagr > cagrA + 0.5*stdA
%             bonus(cP) = 5*bonus_m(cP/4)*payroll_costA(cP/4);
%             
%         elseif  cagr > cagrA - 0.5*stdA
%             bonus(cP) = 1*bonus_m(cP/4)*payroll_costA(cP/4);
%         
%         else
%             bonus(cP) = 0.5*bonus_m(cP/4)*payroll_costA(cP/4);
%         end
        bonus(cP) = 15*exp(-7.5*exp(-1.5*cagr/cagrA)) * bonus_m(cP/4)*payroll_costA(cP/4);
        bonus(cP) = min(bonus(cP),bonus_pool);

    else % if we haven't paid off dividends
        bonus(cP)=0.09*payroll_costA(cP/4);

    end
end
%% new money
time_mult(cP) = 1*exp(-100*exp(-0.3*cP));
aum_mult(cP) = 1*exp(-100*exp(-0.02*starting_aum(cP)/1000000));

if cP < 5
    ret_mult(cP) = -2*exp(-0.401*2.5) + 1;
else
    if mod(cP-1,4) == 0
        s_cp = floor(cP/4);
        e_cp = s_cp+3;
        r_cp = (vami(e_cp)-vami(s_cp))/vami(s_cp);
        ret_mult(cP) = -2*exp(-r_cp*2.5) + 1;
    else
        ret_mult(cP) = ret_mult(cP-1);
    end
end


if cP > 1
    new_money_mult(cP) = 2.5*(0.2*time_mult(cP) + 0.15*aum_mult(cP) + 0.35*ret_mult(cP) + 0.05*rand_mult(cP))/1.5;
        new_money_mult(new_money_mult<0) =0;
    if new_money_mult(cP) == 0
        new_money(cP) = 0.8*new_money(cP-1);
    else
        new_money(cP) =new_money_mult(cP)*starting_aum(cP);
    end
    
    if starting_aum(cP) > 2e9
        new_money(cP) = new_money(cP)*1/(2*starting_aum(cP)-2e9);
    end
end

if new_money(cP) < 0 && cP > 1
    new_money(cP) = 0.6*new_money(cP-1);
end
%% computing ending aums.
outflows(cP) = 0;
if cP>8
    if starting_aum(cP)<4e9
        outflows(cP) = 0.04*starting_aum(cP);
    else
        outflows(cP) = 0.15*starting_aum(cP);
    end
end
ending_aum(cP) = starting_aum(cP) + profits(cP);

%computing fees, and discounting them to the present value. discount rate
total_fees_net(cP) = max(management_fees(cP) + performance_fees(cP) - payroll_costQ(cP) - nonpayroll_costQ(cP) - bonus(cP),0);


% set next periods starting aum to be this periods ending aum
if cP==1
    management_fees(cP) = starting_aum(cP)*management_fees_rate;
end

if cP~=num_periods
    management_fees(cP+1) = (ending_aum(cP)  + new_money(cP))*management_fees_rate;
    starting_aum(cP+1) = ending_aum(cP)  + new_money(cP) - management_fees(cP+1) - performance_fees(cP) - outflows(cP);
end

if management_fees(cP)-(payroll_costQ(cP)+nonpayroll_costQ(cP)+bonus(cP)) > 0
    if ~broken
        survival_years(i) = cP;
        broken=true;
    end
end