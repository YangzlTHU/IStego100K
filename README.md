# IStego100K

IStego100K: Large-scale Image Steganalysis Dataset, mixed with various steganographic algorithms, embedding rates, and quality factors.

In order to promote the rapid development of image steganalysis technology, in this work, we construct and release a multivariable large-scale image steganalysis dataset called IStego100K. It contains 208,104 images with the same size of 1024*1024. Among them, 200,000 images (100,000 cover-stego image pairs) are divided as the training set and the remaining 8,104 as testing set. In addition, we hope that IStego100K can help researchers further explore the development of universal image steganalysis algorithms, so we try to reduce limits on the images in IStego100K. For each image in IStego100K, the quality factors is randomly set in the range of 75-95, the steganographic algorithm is randomly selected from three well-known steganographic algorithms, which are J-uniward, nsF5 and UERD, and the embedding rate is also randomly set to be a value of 0.1-0.4. In addition, considering the possible mismatch between training samples and test samples in real environment, we add a test set (DS-Test) whose source of samples are different from the training set. We hope that this test set can help to evaluate the robustness of steganalysis algorithms. We tested the performance of some latest steganalysis algorithms on IStego100K, with specific results and analysis details in the experimental part. We hope that the IStego100K dataset will further promote the development of universal image steganalysis technology


If you used this dataset in your work, please consider to cite it in the following format:

```
@inproceedings{yangzl2019IStego100K,
  title         =   {IStego100K: Large-scale Image Steganalysis Dataset},
  author        =   {Yang, Zhongliang and Wang, Ke and Ma, Sai and Huang, Yongfeng and Kang, Xiangui and Zhao, Xianfeng},
  booktitle     =   {International Workshop on Digital Watermarking},
  year          =   {2019},
  organization  =   {Springer}
}

```

Full PDF can be downloaded from [arxiv](https://arxiv.org/abs/1911.05542)

## Download

#### [Train Set](https://drive.google.com/drive/folders/12BMGVvdR5H6pA3JD2JFENF8LS7YCqY1T?usp=sharing) 
100,000 pairs of cover and stego images (200K in total), origin images were downloaded from [Unsplash](https://unsplash.com/) 

#### [Same-Source Test Set](https://drive.google.com/drive/folders/1AJFlnpfp_QudBx3aF6CD2Wf28aYNVmNz?usp=sharing) 
Marked as SS-Test in the paper. 8104 images with cover/stego [labels](https://drive.google.com/file/d/1Td4MJiWSMGGwxiAPx-CFeB96duy1uGxD/view?usp=sharing) (not in pair), origin images were downloaded from [Unsplash](https://unsplash.com/)

#### [Different-Source Test Set](https://drive.google.com/file/d/1Xzo3Q9QqfUUiOzQP7LRRdenhz2CGS2Zz/view?usp=sharing)
Marked as DS-Test in the paper.10000 images with cover/stego [labels](https://drive.google.com/file/d/1DbheoDUct6h2IYZfGKYgZ4oVGjloFu76/view?usp=sharing) (not in pair), origin images were shot on different mobile devices.

    Note: The number of images is 11809 in the paper, but we removed some low quality images before uploading.

#### Alternate links
For those who cannot access Google in Mainland China, try this Baidu Cloud Disk link:
* [Train Set](https://pan.baidu.com/s/14gDpRO6ZoYollNFk_TeiRA)(__extraction code__:t7xf)
- [Same-Source Test Set](https://pan.baidu.com/s/1LNyuzNNE3EouwqmDowJcDw)(__extraction code__:wpox)
* [Different-Source Test Set](https://pan.baidu.com/s/1NDmucuyXzcrFD8ohEX83ZA)(__extraction code__:bqtd)

## Detailed Parameters
We also provide detailed parameters for each image [here](https://drive.google.com/drive/folders/1wGX1PZiIEpVNOX8_45xIQTWDBgP94Hzj?usp=sharing).

The parameter files are organized as follows:

```Python
parameters={
    "000001.jpg":{ # parameters for stego-file    
        "quality": 95,  # quality factor
        "rate": 0.4, # embedding rate (payload)
        "steg_algorithm": "nsf5" # steganographic algorithm
     },
     "000002.jpg":{ # parameters for cover-file
       "quality": 90 # quality factor
     }
}
```

    Note: For the training set, cover files and stego files are in pairs with same quality factors, so we omitted the parameter file for cover files in training set.
    
## Steganographic Algorithms
We use the following steganographic algorithms for our dataset:
* __nsF5__: J. Fridrich, T. Pevný, and J. Kodovský, _Statistically undetectable JPEG steganography: Dead ends, challenges, and opportunities._ In J. Dittmann and J. Fridrich, editors, Proceedings of the 9th ACM Multimedia & Security Workshop, pages 3–14, Dallas, TX, September 20–21, 2007. [[pdf]](http://dde.binghamton.edu/kodovsky/pdf/Fri07-ACM.pdf)
- __J-UNIWARD__: V. Holub, J. Fridrich, T. Denemark, _Universal Distortion Function for Steganography in an Arbitrary Domain._ EURASIP Journal on Information Security, (Section:SI: Revised Selected Papers of ACM IH and MMS 2013), 2014(1).[[pdf]](http://dde.binghamton.edu/vholub/pdf/EURASIP14_Universal_Distortion_Function_for_Steganography_in_an_Arbitrary_Domain.pdf)
* __UERD__:  L. Guo, J. Ni, W. Su, C. Tang, and Y.Q. Shi. _Using statistical image model for jpeg steganography: uniform embedding revisited._ IEEE Transactions on Information Forensics & Security, 10(12), 2669-2680, 2015. [[pdf]](https://ieeexplore.ieee.org/document/7225122)
- __HILL_GINA__: Y. Wang, W. Zhang, W. Li, X. Yu and N. Yu, _Non-Additive Cost Functions for Color Image Steganography Based on Inter-Channel Correlations and Differences._ IEEE Transactions on Information Forensics & Security. PP. 1-1. 10.1109/TIFS.2019.2956590. . [[pdf]](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8917610)

For more details, including codes and tutorial, please refer to our __[Steganography page](Steganography)__.

## Steganalysis Algorithms
We apply the following steganalysis algorithms for dataset evaluation:
* __DCTR__: V. Holub and J. Fridrich, _Low Complexity Features for JPEG Steganalysis Using Undecimated DCT,_ IEEE Transactions on Information Forensics and Security, to appear. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](http://www.ws.binghamton.edu/fridrich/Research/DCTR.pdf)
- __GFR__: X. Song, F. Liu, C. Yang, X. Luo and Y. Zhang, _Steganalysis of Adaptive JPEG Steganography Using 2D Gabor Filters,_ Proceedings of the 3rd ACM Workshop on Information Hiding and Multimedia Security. ACM, 2015. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](https://dl.acm.org/citation.cfm?id=2756608)
* __SRNet__: M. Boroumand,M. Chen,and J. Fridrich. _Deep Residual Network for Steganalysis of Digital Images,_ IEEE Transactions on Information Forensics and Security. PP. 1-1. 10.1109/TIFS.2018.2871749, 2018. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](https://ieeexplore.ieee.org/document/8470101/)
- __XuNet__: G. Xu. _Deep convolutional neural network to detect j-uniward_, Proceedings of the 5th ACM Workshop on Information Hiding and Multimedia Security. ACM, 2017. [[code]](https://github.com/GuanshuoXu/caffe_deep_learning_for_steganalysis) [[pdf]](https://dl.acm.org/citation.cfm?id=3083236)

For more details, including codes and tutorial, please refer to our __[Steganalysis page](Steganalysis)__.

__Overall Results__

|Dataset|Methods|Acc(%)|P(%)|R(%)|F1(%)|
|:---:|:---:|:---:|:---:|:---:|:---:|
|SS-Test|DCTR<br>GFR<br>SRNet<br>XuNet|71.34<br>66.26<br>-<br>-|79.72<br>69.58<br>-<br>-|57.23<br>57.97<br>-<br>-|66.63<br>63.25<br>-<br>-|
|DS-Test|DCTR<br>GFR<br>SRNet<br>XuNet|56.95<br>59.12<br>-<br>-|55.50<br>61.61<br>-<br>-|70.11<br>48.42<br>-<br>-|61.95<br>54.22<br>-<br>-|
    Note: We trained SRNet and XuNet on a single GPU (GTX 1080Ti), and found that they are hardly to converge on IStego100K.
    
__Results for Different Steganography Algorithms__

|Test Set|Steganalysis|Steganography|Acc(%)|P(%)|R(%)|F1(%)|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
SS-Test|DCTR|UERD<br>nsF5<br>J-uniward|71.77<br>84.44<br>57.73|79.75<br>85.10<br>67.58|58.36<br>83.51<br>29.71|67.40<br>84.30<br>41.27|
SS-Test|GFR|UERD<br>nsF5<br>J-uniward|68.47<br>71.61<br>58.81|71.34<br>72.72<br>62.91|61.75<br>69.18<br>42.92|66.20<br>70.91<br>51.02|
DS-Test|DCTR|UERD<br>nsF5<br>J-uniward|53.96<br>62.28<br>51.67|53.35<br>60.56<br>51.43|63.06<br>87.59<br>59.83|57.80<br>71.61<br>55.31|
DS-Test|GFR|UERD<br>nsF5<br>J-uniward|56.05<br>67.24<br>54.59|58.40<br>68.21<br>56.62|42.09<br>64.58<br>39.26|48.92<br>66.35<br>46.37|

__Results for Different Steganography Algorithms__

|Test Set|Steganalysis|Payload|Acc(%)|P(%)|R(%)|F1(%)|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
SS-Test|DCTR|0.1<br>0.2<br>0.3<br>0.4|58.55<br>71.43<br>76.30<br>79.55|67.84<br>80.19<br>82.22<br>83.74|32.51<br>56.90<br>67.11<br>73.35|43.96<br>66.57<br>73.90<br>78.20|
SS-Test|GFR|0.1<br>0.2<br>0.3<br>0.4|55.87<br>63.51<br>70.83<br>75.71|59.40<br>67.98<br>72.04<br>74.89|37.10<br>51.08<br>67.89<br>76.75|45.67<br>58.33<br>69.95<br>72.05|
DS-Test|DCTR|0.1<br>0.2<br>0.3<br>0.4|52.86<br>56.21<br>58.56<br>60.17|52.42<br>54.99<br>56.53<br>57.72|61.90<br>68.40<br>74.11<br>76.05|56.77<br>60.97<br>64.13<br>65.63|
DS-Test|GFR|0.1<br>0.2<br>0.3<br>0.4|52.29<br>56.66<br>62.15<br>65.40|53.42<br>58.87<br>64.65<br>67.18|35.79<br>44.19<br>53.65<br>60.22|42.86<br>50.49<br>58.63<br>63.51|

__Results for Different Quality Factors on SS-Test__

|Steganalysis|QF|Acc(%)|P(%)|R(%)|F1(%)|
|:---:|:---:|:---:|:---:|:---:|:---:|
|DCTR|75<br>80<br>85<br>90<br>95|75.23<br>71.50<br>74.09<br>69.04<br>62.12|85.63<br>86.48<br>84.34<br>76.09<br>66.41|60.64<br>61.56<br>59.18<br>55.54<br>49.05|71.00<br>71.82<br>69.55<br>64.21<br>56.43|
|GFR|75<br>80<br>85<br>90<br>95|70.08<br>69.91<br>68.42<br>64.67<br>58.30|75.06<br>74.98<br>71.54<br>67.02<br>59.76|60.15<br>59.75<br>61.17<br>57.75<br>50.82|66.78<br>66.50<br>65.95<br>62.04<br>64.93|

## More Details
For more details such as pre-processing, data distribution, and steganalysis baselines, please take a look at the [arxiv](https://arxiv.org/abs/1911.05542).
