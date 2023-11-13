# ___WinSNPGT: Genotyping of specified SNP sites on Windows system___
## 👉 Latest release package
- Installation package
	- Installation package on CSDN: **[WinSNPGT.exe](https://download.csdn.net/download/NBRWzm/88504982)**
	- Installation package on Figshare: **[WinSNPGT.exe](https://figshare.com/articles/software/WinSNPGT_exe/24501355)**
	- Installation package on Github: **[WinSNPGT.exe](https://github.com/Min-Zer0/WinSNPGT/raw/install.package/WinSNPGT.exe?download=)**
- repository
	- Github repository: **[Min-Zer0/WinSNPGT](https://github.com/Min-Zer0/WinSNPGT)**
	- Gitee repository: **[Min-Zer0/WinSNPGT](https://gitee.com/Min-Zer0/WinSNPGT)**

## 💡 General Introduction
The rapid development of sequencing technology and dramatic drop in the cost have led to the generation of massive amounts of data. However, most of the raw data are analyzed on linux systems, and the process of generating variant loci information from sequencing data is a challenge for researchers unfamiliar with linux systems.

We have developed a toolkit to call variant loci on the Windows system, WinSNPGT. It can obtain the genotypes of the raw sequencing data for the snp loci specified in our datasets.

The installation and use of this toolkit is described below.

## 🧾 Background
We have developed a phenotype prediction platform, **[CropGS-Hub](https://iagr.genomics.cn/CropGS/#/)**, which contains multiple high-quality datasets from important crops such as rice, maize and so on. These datasets were used as training sets to build models for phenotype prediction. Users can upload genotypes of their own samples to the platform for online phenotype prediction.

The WinSNPGT toolkit was developed to ensure that the genotypes uploaded by users match those in the training set for modeling so that bias in the prediction results can be avoided. Users can run this program on the Windows system to realize the whole process from sequencing files to getting genotypes by simple operation, which is very friendly for people who have little experience in linux operation.

## 🌟 Installation
1. **java8** download link：**[Download Link1](https://www.oracle.com/java/technologies/downloads/#java8-windows)** | **[Download Link2](https://iagr.genomics.cn/static/gstool/media/snpgt/jdk-8u351-windows-x64.exe)** | **[Download Link3](https://figshare.com/articles/software/WinSNPGT_exe/24501355)** | **[Download Link4](https://download.csdn.net/download/NBRWzm/88504993)**
	- Default installation
2. **WinSNPGT** download link：[👉 Latest release package](https://github.com/Min-Zer0/WinSNPGT#-lastest-release-package)
	- Double-click the exe installation package, select the installation path (**`Chinese characters are not allowed`**)
	![在这里插入图片描述](https://img-blog.csdnimg.cn/25406fefbc494ceea01d41bdc2322c4b.png)
	- After decompression is completed, the following prompt appears, indicating that the installation is successful:
	![在这里插入图片描述](https://img-blog.csdnimg.cn/9566956c57834114bb57df58fae70580.png)
	- Double-click to enter the installation path **WinSNPGT/**  
	![在这里插入图片描述](https://img-blog.csdnimg.cn/109154b7077447b4ac89c8cec7d06186.png)

	**WinSNPGT**：Startup icon (a shortcut will also generate on the desktop)  
	***Input_Fastq/***：Paired-end sequencing files should be moved as input into this folder  
	***Result/***：Folder where the results are output after the program is finished running  
	**Reference_Genome**：Folder where the reference genome file are placed (generally not used)

## 🔍 Demo data
The example-data files are not included in the release package, you can download：[example-data.tar.gz](https://figshare.com/articles/dataset/WinSNPGT_example_data/23365061)

The species of the example-data files is *Oryza sativa*, you can select the rice-related dataset (e.g: GSTP007 ~ GSTP009) in the toolkit to complete the genotyping.

## 🌟 Usage
### Step 1：Move raw sequencing data
- Move your raw sequencing data **`(*.fastq.gz)`** or **`(*.fastq)`** to the path: **./Input_Fastq**
![在这里插入图片描述](https://img-blog.csdnimg.cn/ff1b0ca7e07644f19d3e46b559ba996e.png)

### Step 2：Start the WinSNPGT program
- **Double-click to run the program and a web pop-up will appear in the default browser**
- **There will also be a window running as a background program**
	- `Do not close the background program window`
	- `It should be closed after the program is finished running or when restarting the program, you need to close this window`  
![在这里插入图片描述](https://img-blog.csdnimg.cn/dd4af84ebed649e6acf476523a212f47.png)

### Step 3: Creat Project
There are two ways to read raw reads files.

- ***Manual selection***: `When there are few samples, it is recommended to quickly add and generate the form.`
	- Enter project name which will be output file prefix
	- Select the corresponding reads files and enter the sample name
	- Click ***Add*** button to update the form if there are another samples to be genotyped
	- Click ***Submit*** button after adding all samples to be genotyped and confirm the form is correct
![在这里插入图片描述](https://img-blog.csdnimg.cn/9579afa14337467ab231f3e495f86c03.png)
- ***reading excel table*** `It is recommended to avoid errors in manual selection when there are too many samples .`
	- Fill in the file **Sample.table.xls** under the path **./Input_Fastq** in advance
	![在这里插入图片描述](https://img-blog.csdnimg.cn/6e5499b11d124c60b435a21ec468b026.png)

### Step 4: Select species and dataset  
 - Select the species of your samples to be genotyped
 - Select the dataset corresponding to the model to be fitted
 - Datasets available：**[CropGS-Hub Dataset](https://iagr.genomics.cn/CropGS/#/Datasets)** 	
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/0ac6e5435d6c4b3aa0fc5ea5908cf442.png)
### Step 5: Select the number of threads   
-  The default number of threads is 4
	![在这里插入图片描述](https://img-blog.csdnimg.cn/d810006c1367451184f80f9784dad8cb.png)
### Step 6：Run the program
![在这里插入图片描述](https://img-blog.csdnimg.cn/9d6334208b014eeda8749b7d037c36bc.png)

### Others: Offline download of species datasets 
- During normal operation, the program will automatically download the reference genome before entering the genotyping analysis process.
	- Users can download it offline if they do not have an Internet connection.
	- Download link：**[CropGS-Hub Dataset](https://iagr.genomics.cn/CropGS/#/Datasets)** 	
	- After downloading the corresponding species and datasets, double-click Reference_Genome.bat, open the path to the file, and drag the offline downloaded file into it.
- This function can also be used to migrate species and datasets between different users without repeated downloads.

### Output & Analysis
- After the program is completed, the result file will be output in the Result/ directory.
	- ***Standard format VCF (variant call format) file***
	- ****.Genotype.txt***  （Sample genotyping matrix, the format is as follows) 

	CHROM|POS|Line 1|line 2|...|line N|
	---|---|---|---|---|---|
	Chr1|128960|A|.|...|C|
	Chr1|133137|C|C|...|T|
	...|...|...|...|...|...|...|
	Chr12|321216|A|A|...|A|
	Chr12|364257|A|C|...|C|
	Chr12|364755|.|.|...|.|
	...|...|...|...|...|...|...|

- Upload ****.Genotype.txt*** to CropGS-Hub to complete subsequent analysis
	- Phenotype Prediction  **[PhenotypePrediction](https://iagr.genomics.cn/CropGS/#/PhenotypePrediction)** 	
	- Crossing Design  **[CrossingDesign](https://iagr.genomics.cn/CropGS/#/CrossingDesign)** 	

## 💡 Frequently Asked Questions
If there are some errors reported during the running of the program, please refer to the following scenarios to solve the problem:

- The **`background program is not allowed to be closed`** until you get your results.
- If you fill in the wrong information on the web page, you can **`refresh and refill the interface`** before running, and there is no need to restart the program or repeat moving files steps.
-  **`Chinese characters are not allowed`** to appear in **`path where winSNPGT is installed`**. Otherwise, the following error may occur:
![在这里插入图片描述](https://img-blog.csdnimg.cn/28738b6a2b2640738396912d250d10d1.png)
- If you chose the way to read excel table, you must **`save and close the table`** after filling it, which means it cannot be kept open. Otherwise, the following error may occur:
![在这里插入图片描述](https://img-blog.csdnimg.cn/7c4df63e49c34a88b836e953156e25e4.png)

The above are some possible causes of errors, if there are any other problems, welcome to contact us.

## 🔍 Change Log
- [Version 1.0](https://github.com/JessieChen7/WinSNPGT) - First version released on June, 1st, 2023
- [Version 2.0](https://github.com/Min-Zer0/WinSNPGT) - Second version released on August, 24th, 2023

## 👥 Contacts
> - Jie Qiu (qiujie@shnu.edu.cn)  
> - Min Zhu (zer0min@outlook.com)  
> - Jiaxin Chen (jxchen1217@gmail.com)

