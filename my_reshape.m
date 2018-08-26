function A = my_reshape( B,k,i )
if i == 1
    a = length( B );
    A = cell( 1,k );
    id = randperm( a );
    in = floor( a/k );
    for b = 1 : k-1
       A{b} = id(((b-1)*in+1):(b*in));
    end
    A{k} = id((k-1)*in+1:end);
end