function [ pz, px_z, rPx] = plca_train( data, px, K )
%PLCA_TRAIN Summary of this function goes here
%   Detailed explanation goes here

 %just for this example, we use k =3;
maxiter = 140;
[M, N] = size(px);
Dim = 2; 
pz = rand(K, 1);
pz = pz / sum(pz); %prior paorbility of component
for k = 1:K
    px_z{k} = rand([2, N]);
    px_z{k} = px_z{k} ./ repmat(sum(px_z{k}, 2), [1, N]);
end

R = rand([M, N, K]);
R  = R./repmat(sum(R, 3), [1 1 K]);
for i = 1:maxiter
    %updata R
    for k = 1:K
        tmpPx_z = px_z{k};
        prod = tmpPx_z(2, :)' * tmpPx_z(1, :);
        R(:, :, k) = pz(k) * prod;
    end

    rPx = R;
    R = R ./repmat(sum(R, 3), [1 1 K]);
    
    R(isnan(R)) = 0.001;
        %update pz    
    for k = 1:K
        pz(k) = sum(sum(px.*R(:, :, k)));
    end
    pz = pz/sum(pz);
    
    %update px_z;
    for k = 1:K
        for j = 1:Dim
            px_z{k}(j, :) = sum(px.*R(:, :, k), j);
            px_z{k}(j, :) = px_z{k}(j, :)/pz(k);
            px_z{k}(j, :) = px_z{k}(j, :) / sum(px_z{k}(j, :));
        end
    end
end
end



