clear
clc

seed = 1;
rng(seed);
permuted = randperm(10000);
permuted = permuted';

dlmwrite('test_halfhalf.txt',permuted(1:5000));
dlmwrite('train_halfhalf.txt',permuted(5001:10000));
