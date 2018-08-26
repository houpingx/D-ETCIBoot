function truth_median = calculate_median( dataset)
% reorganize data so that entity IDs are ordered
if (~issorted(dataset(:,1)))
	dataset=sortrows(dataset,1);
end

% get basic structures of the dataset
[~,entry_ia,~]=unique(dataset(:,1),'rows','first'); % for s
nof=size(dataset,1); % number of fact
noe=length(entry_ia);% number of entities
entry_ia(noe+1)=nof+1;%modify entry_ia s.t. we know the beginning and ending rows of each entity

% truth_median = zeros( N,2 );
% truth_median(:,1) = (1:N)';
% calculate the inital truth
for i=1:noe % for each entity, do:
    tempvalue=dataset(entry_ia(i):(entry_ia(i+1)-1),1:2); % get the chunk of the claims from all sources
    truth_median(i,:)=median(tempvalue,1); % get median
end
% update truth
%truth=truth_median;

end