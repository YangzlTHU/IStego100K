# Introduction
  SRNet is a steanalyisis method using deep learning, main function is in SRNet_Example, it train a model and then do the test. What you need to do is to enter the path of the image (Cover and Stego directories for training and validation. For the spatial domain put cover and stego images in their corresponding direcotries. For the JPEG domain, decompress images to the spatial domain without rounding to integers and save them as '.mat' files with variable name "im". Put the '.mat' files in thier corresponding directoroies. Make sure all mat files in the directories can be loaded in Python without any errors.)and change the parameter.After a classifier has been trained,enter the path of the testing set and get the corresponding results.

# Enviroment 
Python 

## Get start
1.Run SRNet_Example.py

2.Input the path of the training set, you will get the trained model.

3.You can also change the parameter as you want, which is described clearly in the code. 


# Paper and Code

M. Boroumand,M. Chen,and J. Fridrich. _Deep Residual Network for Steganalysis of Digital Images,_ IEEE Transactions on Information Forensics and Security. PP. 1-1. 10.1109/TIFS.2018.2871749, 2018. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](https://ieeexplore.ieee.org/document/8470101/)
