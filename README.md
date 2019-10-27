# IStego100K

IStego100K: Large-scale Image Steganalysis Dataset, mixed with various steganographic algorithms, embedding rates, and quality factors.
 
This dataset is proposed in:

[our paper reference here](url here) 

## Download

###[Train Set](google drive url here) 
100,000 pairs of cover and stego images (200K in total), origin images were downloaded from [Unsplash](https://unsplash.com/) 

###[Same-Source Test Set](google drive url here) 
8104 images with cover/stego labels (not in pair), origin images were downloaded from [Unsplash](https://unsplash.com/)

###[Differenct-Source Test Set](google drive url here)
11809 images with cover/stego labels (not in pair), origin images were shot on different mobile devices

## Steganographic Algorithms
We use the following steganographic algorithms for our dataset:
* __nsF5__: J. Fridrich, T. Pevný, and J. Kodovský, _Statistically undetectable JPEG steganography: Dead ends, challenges, and opportunities._ In J. Dittmann and J. Fridrich, editors, Proceedings of the 9th ACM Multimedia & Security Workshop, pages 3–14, Dallas, TX, September 20–21, 2007. [[code]](http://dde.binghamton.edu/download/nsf5simulator/) [[pdf]](http://dde.binghamton.edu/kodovsky/pdf/Fri07-ACM.pdf)
- __J-UNIWARD__: V. Holub, J. Fridrich, T. Denemark, _Universal Distortion Function for Steganography in an Arbitrary Domain,_ EURASIP Journal on Information Security, (Section:SI: Revised Selected Papers of ACM IH and MMS 2013), 2014(1). [[code]](http://de.binghamton.edu/download/stego_algorithms/) [[pdf]](http://dde.binghamton.edu/vholub/pdf/EURASIP14_Universal_Distortion_Function_for_Steganography_in_an_Arbitrary_Domain.pdf)
* __UERD__:  L. Guo, J. Ni, W. Su, C. Tang, and Y.Q. Shi. _Using statistical image model for jpeg steganography: uniform embedding revisited._ IEEE Transactions on Information Forensics & Security, 10(12), 2669-2680, 2015. [[code]](https://github.com/mach-ms/UERD) [[pdf]](https://ieeexplore.ieee.org/document/7225122)

## Steganalysis Algorithms
We apply the following steganalysis algorithms for dataset evaluation:
* __DCTR__: V. Holub and J. Fridrich, _Low Complexity Features for JPEG Steganalysis Using Undecimated DCT,_ IEEE Transactions on Information Forensics and Security, to appear. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](http://www.ws.binghamton.edu/fridrich/Research/DCTR.pdf)
- __GFR__: X. Song, F. Liu, C. Yang, X. Luo and Y. Zhang, _Steganalysis of Adaptive JPEG Steganography Using 2D Gabor Filters,_ Proceedings of the 3rd ACM Workshop on Information Hiding and Multimedia Security. ACM, 2015. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](https://dl.acm.org/citation.cfm?id=2756608)
* __SRNet__: M. Boroumand,M. Chen,and J. Fridrich. _Deep Residual Network for Steganalysis of Digital Images,_ IEEE Transactions on Information Forensics and Security. PP. 1-1. 10.1109/TIFS.2018.2871749, 2018. [[code]](http://dde.binghamton.edu/download/feature_extractors/) [[pdf]](https://ieeexplore.ieee.org/document/8470101/)

## More Details
For more details such as pre-processing, data distribution, and steganalysis baselines, please take a look at the [paper](#IStego100K).