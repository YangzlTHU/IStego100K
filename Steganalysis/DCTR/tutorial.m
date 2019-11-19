function tutorial()
% -------------------------------------------------------------------------
% Ensemble Classification | June 2013 | version 2.0 | TUTORIAL
% -------------------------------------------------------------------------
% Copyright (c) 2013 DDE Lab, Binghamton University, NY.
% All Rights Reserved.
% -------------------------------------------------------------------------
% Contact: jan@kodovsky.com | fridrich@binghamton.edu | June 2013
%          http://dde.binghamton.edu/download/ensemble
% -------------------------------------------------------------------------

% Short tutorial for the ensemble classifier (ver 2.0) developed for
% steganalysis in digital images.

% Load prepared cover/stego features. These features correspond to CC-PEV
% features extracted from nsF5 steganography at payload 0.2 bpac. Used JPEG
% quality factor = 75.
cover = load('example/cover.mat');
stego = load('example/stego.mat');

% Both loaded structures contain fields 'F' and 'names'. F is a feature
% matrix with individual samples in rows and individual features in
% columns, i.e., the number of columns corresponds to the feautre-space
% dimensionality. Field 'names' contains image filenames of the
% corresponding cover (or stego) images. Note that this format is
% consistent with the previous version of our ensemble implementation.

% As you can notice, filenames in cover.names and stego.names are
% de-synchronized. Furthermore, there is 2000 cover features but only 1994
% stego features. This simulates the real-life scenario where (for many
% steganographic methods) embedding may fail for some images and/or the
% features were extracted from images in a different order. Synchronization
% of cover/stego feature pairs (more details about this in the next
% paragraph) is an important pre-processing step in steganalysis and thus
% is part of this tutorial as well.  

% In steganalysis, it is important to train on the *pairs* of
% cover-features and the corresponding stego-features. When dividing the
% features into training/testing parts, for example, these pairs need to be
% preserved. But it is equally important to keep track of these pairs even
% within the training set itself! This is because when splitting the
% training data for the purposes of cross-validation (or bootstrapping),
% these pairs, again, need to be preserved. Therefore, our implementation
% of the ensemble training accepts only two *synchronized* matrices of
% features (cover & stego). While the implementation checks for the sizes
% of both matrices, the actual synchronization is the responsibility of a
% user. See the code below as an example of how to do this correctly.

% Restriction only to images that have both cover and stego features (only
% those will be considered)
names = intersect(cover.names,stego.names);
names = sort(names);

% Prepare cover features C
cover_names = cover.names(ismember(cover.names,names));
[cover_names,ix] = sort(cover_names);
C = cover.F(ismember(cover.names,names),:);
C = C(ix,:);

% Prepare stego features S
stego_names = stego.names(ismember(stego.names,names));
[stego_names,ix] = sort(stego_names);
S = stego.F(ismember(stego.names,names),:);
S = S(ix,:);

% At this point, we have the cover features C and the corresponding
% stego features S. They are correctly synchronized, i.e., the i-th row of
% the  stego matrix S comes from the stego image that was created from the
% cover image with features in the i-th row of the cover matrix C.

% Now we can prepare a training set and a testing set. 

% PRNG initialization with seed 1
RandStream.setGlobalStream(RandStream('mt19937ar','Seed',1));

% Division into training/testing set (half/half & preserving pairs)
random_permutation = randperm(size(C,1));
training_set = random_permutation(1:round(size(C,1)/2));
testing_set = random_permutation(round(size(C,1)/2)+1:end);
training_names = names(training_set);
testing_names = names(testing_set);

% Prepare training features
TRN_cover = C(training_set,:);
TRN_stego = S(training_set,:);

% Prepare testing features
TST_cover = C(testing_set,:);
TST_stego = S(testing_set,:);

% Train ensemble with all settings default - automatic search for the
% optimal subspace dimensionality (d_sub), automatic stopping criterion for
% the number of base learners (L), both PRNG seeds (for subspaces and
% bootstrap samples) are initialized randomly.
[trained_ensemble,results] = ensemble_training(TRN_cover,TRN_stego);

% Resulting trained classifier is a cell array containing individual base
% learners. Variable 'results' contains some additional information like
% optimal found parameters or the progress of the OOB error during the
% search.

% plot the results of the search for optimal subspace dimensionality
figure(1);
clf;plot(results.search.d_sub,results.search.OOB,'.b');hold on;
plot(results.optimal_d_sub,results.optimal_OOB,'or','MarkerSize',8);
xlabel('Subspace dimensionality');ylabel('OOB error');
legend({'all attempted dimensions',sprintf('optimal dimension %i',results.optimal_d_sub)});
title('Search for the optimal subspace dimensionality');

% plot the OOB progress with the increasing number of base learners (at the
% optimal value of subspace dimensionality).
figure(2);
clf;plot(results.OOB_progress,'.-b');
xlabel('Number of base learners');ylabel('OOB error')
title('Progress of the OOB error estimate');

% Time to test the performance of the classifier on the testing set that
% contains unseen samples. Even though OOB is an unbiased error estimate,
% we used it as a feedback for determining d_sub and L. Therefore, its
% value is an optimistic estimate of the real testing error.

% Testing phase - we can conveniently test on cover and stego features
% separately
test_results_cover = ensemble_testing(TST_cover,trained_ensemble);
test_results_stego = ensemble_testing(TST_stego,trained_ensemble);

% Predictions: -1 stands for cover, +1 for stego
false_alarms = sum(test_results_cover.predictions~=-1);
missed_detections = sum(test_results_stego.predictions~=+1);
num_testing_samples = size(TST_cover,1)+size(TST_stego,1);
testing_error = (false_alarms + missed_detections)/num_testing_samples;
fprintf('Testing error: %.4f\n',testing_error);

% We can plot the histogram of cover/stego voting results (from the
% majority voting of individual base learners).
figure(3);clf;
[hc,x] = hist(test_results_cover.votes,50);
bar(x,hc,'b');hold on;
[hs,x] = hist(test_results_stego.votes,50);
bar(x,hs,'r');hold on;
legend({'cover','stego'});
xlabel('majority voting');
ylabel('histogram');

% ROC curve can be obtain using the following code
labels = [-ones(size(TST_cover,1),1);ones(size(TST_stego,1),1)];
votes  = [test_results_cover.votes;test_results_stego.votes];
[X,Y,T,auc] = perfcurve(labels,votes,1);
figure(4);clf;plot(X,Y);hold on;plot([0 1],[0 1],':k');
xlabel('False positive rate'); ylabel('True positive rate');title('ROC');
legend(sprintf('AUC = %.4f',auc));

% Now, let's go back to the ensemble training. In the rest of this
% tutorial, we will show how to modify individual ensemble parameters.

% First, we can fix the random subspace dimensionality (d_sub) in order to
% avoid the expensive search. This can be useful for a fast research
% feedback.
settings = struct('d_sub',300);
[~,results] = ensemble_training(TRN_cover,TRN_stego,settings);

% The number of base learners (L) can be also fixed:
settings = struct('d_sub',300,'L',30);
[~,results] = ensemble_training(TRN_cover,TRN_stego,settings);

% Note: even for the fixed training data, resulting trained ensemble can
% have slightly different performance due to the stochastic components of
% bagging and random subspaces. The following loop executes ensemble
% training 10 times and outputs the average OOB error and its standard
% deviation.
settings = struct('d_sub',300,'L',30);
OOB = zeros(1,10);
for i=1:10
    [~,results] = ensemble_training(TRN_cover,TRN_stego,settings);
    OOB(i) = results.optimal_OOB;
end
fprintf('# -------------------------\n');
fprintf('Average OOB error = %.5f (+/- %.5f)\n',mean(OOB),std(OOB));

% Sometimes it may be useful to manually set the PRNG seeds for generating
% random subspaces and feature subsets for bagging. This will make the
% results fully reproducible. The following code, for example, should give
% the OOB error 0.1138:
settings = struct('d_sub',300,'L',30,'seed_subspaces',5,'seed_bootstrap',73);
[~,results] = ensemble_training(TRN_cover,TRN_stego,settings);

% You can fully suppress the ensemble output by setting 'verbose' to 0:
settings = struct('d_sub',300,'L',30,'verbose',0);
[~,results] = ensemble_training(TRN_cover,TRN_stego,settings);
fprintf('OOB error = %.4f\n',results.optimal_OOB);

% Alternatively, you can suppress everyting BUT the last line of the
% ensemble output (the one with the results) by setting 'verbose' to 2:
settings = struct('d_sub',300,'L',30,'verbose',2);
[~,results] = ensemble_training(TRN_cover,TRN_stego,settings);

% That's pretty much it. For reporting steganalysis results, it is a good
% habit to repeat the experiment several times (for example 10 times) for
% different training/testing splits. To speed-up the following example, we
% fix d_sub to 300:

testing_errors = zeros(1,10);
settings = struct('d_sub',300,'verbose',2);
for seed = 1:10
    RandStream.setGlobalStream(RandStream('mt19937ar','Seed',seed));
    random_permutation = randperm(size(C,1));
    training_set = random_permutation(1:round(size(C,1)/2));
    testing_set = random_permutation(round(size(C,1)/2)+1:end);
    TRN_cover = C(training_set,:);
    TRN_stego = S(training_set,:);
    TST_cover = C(testing_set,:);
    TST_stego = S(testing_set,:);
    [trained_ensemble,results] = ensemble_training(TRN_cover,TRN_stego,settings);
    test_results_cover = ensemble_testing(TST_cover,trained_ensemble);
    test_results_stego = ensemble_testing(TST_stego,trained_ensemble);
    false_alarms = sum(test_results_cover.predictions~=-1);
    missed_detections = sum(test_results_stego.predictions~=+1);
    num_testing_samples = size(TST_cover,1)+size(TST_stego,1);
    testing_errors(seed) = (false_alarms + missed_detections)/num_testing_samples;
    fprintf('Testing error %i: %.4f\n',seed,testing_errors(seed));
end
fprintf('---\nAverage testing error over 10 splits: %.4f (+/- %.4f)\n',mean(testing_errors),std(testing_errors));
