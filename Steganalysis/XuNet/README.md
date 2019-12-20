# Introduction

Source code to reproduce the results in

G. Xu, “Deep Convolutional Neural Network to Detect J-UNIWARD,” in Proc. 5th ACM Workshop Inf. Hiding Multimedia Secur. (IH&MMSec), 2017, accepted.

https://arxiv.org/abs/1704.08378

# Building Instructions

The DCT kernels are saved in /kernels. The directory to access them are hard-coded in /include/caffe/filler.hpp
. So before building, please change the directories to make sure the DCT kernels can be found.

The code will compile with cudnnv6. If you are using cudnnv5, see the instruction in /cudnn_hpp_version

# Features
This code has following features compared with the official Caffe.

1) Memory-efficient BN-ReLU combo (bn_conv and relu_recover). Please see bn_conv_layer and relu_recover_layer.
2) More stable testing performance (important for running average based BN) by parameter-wise averaging across N training iterations before testing. Please see the Step(int iters) function in solver.cpp. Usage: set use_polyak to true and  num_iter_polyak in solver.prototxt.
3) image_data_steganalysis_jpeg_dct_layer: a new input layer for jpeg_steganalysis that read jpeg images from hard drive and output BDCT coefficients. This layer is able to do per-epoch random shuffling and syncronized random mirroring and rotation for each cover-stego pair. This layer requires cover and its corresponding stego to have the save file name. Please refer to image_data_steganalysis_jpeg_dct_layer.cpp for more details.
4) bdct_to_spatial_layer to tranform BDCT coeffients to spatial domain.
5) quant_trunc_abs_layer to perform element-wise quantization, trunction and absolute operations.

# Examples
Two examples are provided in examples/jpeg_steganalysis for QF75 and QF95 respectively. Minumum required GPU memory is 12GB. Recommend Titan X and Titan XP.

1) Change the Caffe dir in cmd.sh and cmd_test.sh. The cmd_test.sh is used to output probabilities only.
2) Set the source, cover_dir, and stego_dir in the input layer (in CNN.prototxt).
3) The source is a txt file, each line contain a number (from 1 ~ 10000 for BOSSBase). See the txt files in /rand_num_generators. cover_dir and stego_dir simply contain images in '.jpg' format.


# Citation

Please cite the following paper if the code helps your research.

G. Xu, “Deep Convolutional Neural Network to Detect J-UNIWARD,” in Proc. 5th ACM Workshop Inf. Hiding Multimedia Secur. (IH&MMSec), 2017, accepted.



Please cite two additional papers if you are using the BN-RELU combo (bn_conv and relu_recover).

G. Xu, H. Wu, and Y. Q. Shi, “Ensemble of CNNs for steganalysis: An empirical study,” in Proc. 4th ACM Workshop Inf. Hiding Multimedia Secur. (IH&MMSec), 2016, pp. 103–107.

G. Xu, H. Wu, and Y. Q. Shi, “Structural design of convolutional neural networks for steganalysis,” IEEE Signal Process. Lett., vol. 23, no. 5, pp. 708–712, Mar. 2016.
