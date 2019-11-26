# Steganography Algorithms

We provide codes for 3 steganography algorithms here: J-uniward, nsF5 and UERD.

## Environment Setup

You need [MATLAB](https://www.mathworks.com/products/get-matlab.html?s_tid=gn_getml) to run the scripts. 
    
    Note: R2016b and R2017a are recommended as we have tested on these two versions and everything works fine.

## Get Start

1. In MATLAB, set your working directory to this folder

        cd '/path/to/this/folder';
2. Run the following command (It may take 1-3 minutes):

        run example.m
3. If your code runs correctly, three steganographic images are generated in this folder, and you can hardly tell the difference between them and the cover image [test.jpg](test.jpg):
    * [test_Juniward.jpg](test_Juniward.jpg)
    - [test_nsF5.jpg](test_nsF5.jpg)
    * [test_UERD.jpg](test_UERD.jpg)

4. Have a look at the [example code](example.m) you just run, it's very easy to understand, now you can play it with yourself!

## Trouble Shooting
* If you end up with an error when reading/writing jpeg
    * you may need to __compile JPEG toolbox by yourself__ instead of [the one we provided](jpeg_toolbox), see [here](https://www.mathworks.com/matlabcentral/answers/313501-what-are-the-steps-to-use-phil-sallee-s-jpeg-toolbox-for-matlab) for more details.
- Otherwise
    1. Check your working directory and ensure that you have read/write permission on this folder.
    2. Try to search the error information with google.
    3. If you still have the problem, please open an issue in this repository. We'll try our best for help. 

    