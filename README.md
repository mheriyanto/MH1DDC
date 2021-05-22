![GitHub language count](https://img.shields.io/github/languages/count/mheriyanto/MH1DDC)
![GitHub top language](https://img.shields.io/github/languages/top/mheriyanto/MH1DDC)
![GitHub repo size](https://img.shields.io/github/repo-size/mheriyanto/MH1DDC)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/mheriyanto/MH1DDC)
![GitHub last commit](https://img.shields.io/github/last-commit/mheriyanto/MH1DDC.svg)
[![HitCount](http://hits.dwyl.com/mheriyanto/MH1DDC.svg)](http://hits.dwyl.com/mheriyanto/MH1DDC)
[![LinkedIn](https://img.shields.io/badge/-LinkedIn-black.svg?style=flat&logo=linkedin&colorB=555)](https://id.linkedin.com/in/mheriyanto)

# MH1DDC
MH1DDC is inversion software using Levenberg-Marquardt (LM) and Singular Value Decomposition (SVD) of one-dimension DC resistivity using in MATLAB.

These were scripts that were used to implement our proceeding paper:
**M. Heriyanto and W. Srigutomo. 1-D DC resistivity inversion using singular value decomposition and Levenberg-Marquardt inversion schemes. Journal of Physics: Conference Series 877 (2017) 012066**. doi:10.1088/1742-6596/877/1/012066 ([**PDF**](https://iopscience.iop.org/article/10.1088/1742-6596/877/1/012066/pdf)). I presented this paper on International Conference on Energy Sciences 2016. July 27, 2016 ([**SLIDE**](https://figshare.com/articles/1-D_DC_Resistivity_Inversion_Using_Singular_Value_Decomposition_and_Levenberg-Marquardt_s_Inversion_Schemes/4644637)). These scripts contain three main scripts: [**forward**](https://github.com/mheriyanto/MH1DDC/tree/master/forward), [**LM**](https://github.com/mheriyanto/MH1DDC/tree/master/lm_inversion), and [**SVD**](https://github.com/mheriyanto/MH1DDC/tree/master/svd_inversion) inversion. 

I hope these scripts can help students to enter research on geophysical inversion. 
Any updates about these scripts can be seen in [my blog](https://mheriyanto.wordpress.com/mh1ddc/): https://mheriyanto.wordpress.com/mh1ddc.

<ins>**Forward result**</ins>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/forward/Model%201/Model%201.png" width="30%">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/forward/Model%202/Model%202.png" width="30%">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/forward/Model%203/Model%203.png" width="30%">
</p>

<ins>**LM Inversion result: Model 0**</ins>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/lm_inversion/Model%200/LM%20Final%20Inversion.png" width="70%">
</p>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/lm_inversion/Model%200/Plotting%20Inversion%20Parameter.png" width="40%">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/lm_inversion/Model%200/Plotting%20Lamda.png" width="40%">
</p>

<ins>**LM Inversion result: Model 1**</ins>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/lm_inversion/Model%201/LM%20Final%20Inversion.png" width="70%">
</p>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/lm_inversion/Model%201/Plotting%20Inversion%20Parameter.png" width="40%">
</p>

<ins>**SVD Inversion result: Model 1**</ins>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/svd_inversion/Model%201/SVD%20Final%20Inversion.png" width="70%">
</p>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/svd_inversion/Model%201/Plotting%20Inversion%20Parameter.png" width="40%">
</p>

<ins>**SVD Inversion result: Model 3**</ins>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/svd_inversion/Model%203/Inversi%20SVD%20Final.png" width="70%">
</p>

<p align="center">
<img src="https://github.com/mheriyanto/MH1DDC/blob/master/svd_inversion/Model%203/Plotting%20Inversion%20Parameter.png" width="40%">
</p>

## Usage

<ins>**LM Inversion**</ins>

```console
$ git clone https://github.com/mheriyanto/MH1DDC.git
$ cd MH1DDC
$ cd lm_inversion
$ octave VES1DINV_LM.m
```

<ins>**SVD Inversion**</ins>

```console
$ git clone https://github.com/mheriyanto/MH1DDC.git
$ cd MH1DDC
$ cd svd_inversion
$ octave VES1DINV_SVD.m
```

## License
MH1DDC is released under the MIT License (refer to the [LICENSE](https://github.com/mheriyanto/MH1DDC/blob/master/LICENSE) file for details).

## Citation
If you find this project useful for your research, please use the following BibTeX entry.
    
    @inproceedings{heriyanto20171,
    title={1-D DC Resistivity Inversion Using Singular Value Decomposition and Levenberg-Marquardt’s Inversion Schemes},
    author={Heriyanto, M and Srigutomo, W},
    booktitle={Journal of Physics: Conference Series},
    volume={877},
    number={1},
    pages={066},
    year={2017},
    organization={IOP Publishing}
    }
    
