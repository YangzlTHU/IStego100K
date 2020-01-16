# Environment and tools

Matlab

Matlab jpeg_toolbox

# Feature extraction
At the beginning of image steganalysis, first you need to extract the feature of images. Take feature extraction function GFR as an example. In the fuction F=GFR(IMAGE,NR,QF), there are three inputs.IMAGE means path to the JPEG image,QF means JPEG quality factor(can be either 75 or 95) and NR means unmber of rotations for Gabor kernel. The corresponding output F is extracted Gabor feature.

## TRAINING
The next step is training a classifier using function ensemble_training. In this function results=ensemble_training(Xc,Xs,settings), 

INPUT: 

Xc - cover features in a row-by-row manner

Xs - corresponding stego features (needs to be synchronized!)

settings - default

OUTPUT:

trained_ensemble - cell array of individual FLD base learners, each containing the following three fields:

subspace - random subspace indices

w - vector of weights (normal vector to the decision boundary)

b - bias

You will then get a MAT-file(an array) which composed by cells, that is the classifier.


# TESTING
The final procedure is to do testing.In order to do this, you need to use the function ensemble_testing.In this fuction:results=ensemble_testing(X,trained_ensemble).

INPUT:

X - testing features (in a row-by-row manner)

trained_ensemble - trained ensemble - cell array of individual base learners (output of the 'ensemble_training' routine)

OUTPUT:

results.predictions - individual cover (-1) and stego (+1) predictions based on the majority voting scheme

results.votes - sum of all votes (gives some information about confidenc prediction e)

## Get start
1.In MATLAB, you need to add the jpeg_toolbox to your working diectory.

2.Then, run the GFR function.Type "F=GFR(IMAGE,NR,QF)" in the working space. For IMAGE, you need to enter the path of the picture, for NR you need to enter number of rotations for Gabor kernel, for QF you need to enter the JPEG quality factor(75 or 95). The output F is the extracted feature. 

3.Next, you may run the ensemble_training.m. Input the extracted feature of orign picture and stego picture. Then You will get the classifier.

4.Finally, run the ensemble_testing.m. Input the test picture feature and your classifier. You can get the prediction.
   

# Paper and Code

X. Song, F. Liu, C. Yang, X. Luo and Y. Zhang, _Steganalysis of Adaptive JPEG Steganography Using 2D Gabor Filters,_ Proceedings of the 3rd ACM Workshop on Information Hiding and Multimedia Security. ACM, 2015. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](https://dl.acm.org/citation.cfm?id=2756608)
