function [data, px] = generate_gmm_data()
%%step 1: generate the gmm simulate data
miu = [1 -1; 0 2; -2 1];
sigma =[0.4 0.4; 0.7 0.1; 0.1 0.4];
weight = [0.5 0.25 0.25];
num = 15000;
data = zeros(2, num);
data = single(data);
for i = 1:num
    r = randi(4);
    if r<3
        data(:, i) = mvnrnd(miu(1, :)', diag(sigma(1, :)), 1);
    elseif r==3
        data(:, i) = mvnrnd(miu(2, :)', diag(sigma(2, :)), 1);
    else
        data(:, i) = mvnrnd(miu(3, :)', diag(sigma(3, :)), 1);
    end
end
subplot(211);
plot(data(1, :), data(2, :), '*');
x1 = -4:0.1:4;
px = zeros(size(x1, 2)+1, size(x1, 2)+1, 'single');
for i = 1:num
    d = data(:, i);
    d = floor(d*10) / 10;
    m = ceil((d(1) + 4)/0.1);
    n = ceil((d(2) + 4) / 0.1);
    px(m, n) = px(m, n) + 1;
        
end
%px(:, :) = px(:, [end:-1:1]);

subplot(212)
imagesc(px);