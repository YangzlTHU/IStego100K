# Environment and tools

Matlab

Matlab jpeg_toolbox

# Feature extraction
At the beginning of image steganalysis, first you need to extract the feature of images.In the fuction F=DCTR(I_STRUCT, QF), there are two inputs.I_STRUCT means path to the JPEG image,QF means JPEG quality factor(can be either 75 or 95) . The corresponding output F is extracted feature of the image.

## TRAINING
The next step is training a classifier using function ensemble_training. In this function [trained_ensemble,results] =ensemble_training(Xc,Xs,settings), 

INPUT: 

Xc - cover features in a row-by-row manner

Xs - corresponding stego features (needs to be synchronized!)

settings - default

OUTPUT:

trained_ensemble - cell array of individual FLD base learners, each containing the following three fields:

subspace - random subspace indices

w - vector of weights (normal vector to the decision boundary)

b - bias

results - data structure with additional results of the training procedure(training time, progress of the OOB error estimate,
summary of the search for d_sub, etc.)

You will then get a MAT-file(an array) which composed by cells, that is the classifier.


# TESTING
The final procedure is to do testing.In order to do this, you need to use the function ensemble_testing.In this fuction:results=ensemble_testing(X,trained_ensemble).

INPUT:

X - testing features (in a row-by-row manner)

trained_ensemble - trained ensemble - cell array of individual base learners (output of the 'ensemble_training' routine)

OUTPUT:

results.predictions - individual cover (-1) and stego (+1) predictions based on the majority voting scheme

results.votes - sum of all votes (gives some information about confidenc prediction e)

# Paper and Code
V. Holub and J. Fridrich, _Low Complexity Features for JPEG Steganalysis Using Undecimated DCT,_ IEEE Transactions on Information Forensics and Security, to appear. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](http://www.ws.binghamton.edu/fridrich/Research/DCTR.pdf)
