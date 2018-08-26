%%
clear;
clc;
%%
MADa=[];RMSEa=[];Ta=[];
for ii = 1 : 1
    fprintf('Iteration is %g\n',ii);
B = 10:10:50;
MAD_all = [];RMSE_all = [];T_all = [];
for b = 1 : length(B)
    BB = B(b);
%% load data
 load('step_dataset.txt') % name of variable is step_dataset
 load('step_ground_truth.txt') % name of variable: step_ground_truth
% 
 dataset = step_dataset;
 gd_truth = step_ground_truth;
 if (~issorted(gd_truth(:,1)))
     gd_truth = sortrows(gd_truth,1);
 end
 [list_enty,entry_ia,entry_ic] = unique(gd_truth(:,1));
 gd_truth = gd_truth(entry_ia,:);

% set parameters
iteration=2; % number of iterations
alpha=0.025; % significant level

%%
fprintf(1,strcat('Runing D-ETCIBooT on  ', num2str(BB),' machines\n'))
[ini_truth,T5] = dist_etciboot( dataset,BB,20,.025,20 );
label_truth2 = ini_truth(find( ismember(ini_truth(:,1),gd_truth(:,1)) ),:);
mad_dist_5 = MAD( gd_truth(:,2),label_truth2(:,2) );
rmse_dist_5 = RMSE( gd_truth(:,2),label_truth2(:,2) );
MAD_all = [MAD_all; mad_dist_5];
RMSE_all = [RMSE_all; rmse_dist_5];
T_all = [T_all; mean(sum(T5))];
end
MADa = [MADa MAD_all];
RMSEa = [RMSEa RMSE_all];
Ta = [Ta T_all];
end