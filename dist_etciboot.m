function [ini_truth,T] = dist_etciboot( claim,K,iteration,alpha,B )

if (~issorted(claim(:,1)))
    [~,indexofsort]=sort(claim(:,1));
    dataset_temp=claim(indexofsort,:);
    claim=dataset_temp;
end
num_source = max(claim(:,3));
num_object = max(claim(:,1));
%% distribute claims
% Assume that there are K local machines and all sources are distributed
% into these 5 machines. All claims are partitioned into K cells
%K = 5;
id = randperm( num_source );
R = my_reshape( id,K,1 );
%R = reshape ( id,K,floor(num_source/K));
dist_claim = cell( 1,K );
for k = 1 : K
    temp_index = ismember(claim(:,3),R{k}');
    index =  temp_index == 1;
   dist_claim{k} = claim( index,: );
end
%%
T = [];
%iteration = 20;
local_mean = cell( 1,K );
for k = 1 : K
    local_mean{k} = calculate_mean( dist_claim{k} );
end
all_local_truth = [];
for k = 1 : K
   all_local_truth = [all_local_truth; local_mean{k}]; 
end
ini_truth = calculate_mean( all_local_truth );
list_entry = 1:num_object;
%fprintf(1,'I am here\n')
%ini_truth = [list_entry', ini_truth];
local_truth = cell( 1,K );
estvariance = cell( 1,K );
ini = 1;
while ( ini<=iteration)
    ini = ini + 1;
    new_truth = zeros(size(ini_truth));
    tt = [];
    update_truth = [];
    for k = 1 : K
        %k
        [local_truth{k},estvariance{k},local_t] = local_sampling( dist_claim{k},1,alpha,B,ini_truth);
        update_truth = [update_truth; local_mean{k}]; 
        tt = [tt local_t];
    end
    ini_truth = calculate_mean( update_truth );
    T = [T; tt];
end
%mad_dist = MAD( truth,ini_truth(:,2) );
%rmse_dist = RMSE( truth,ini_truth(:,2) );
%results = [results; mad_dist rmse_dist];
end