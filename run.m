K = 3;
[data, px] = generate_gmm_data();
%px = px/sum(sum(px));
[pz, px_z, R] = plca_train(data, px, K);
figure(2)
imagesc(R(:, :, 1) + R(:, :, 2) + R(:, :, 3));

