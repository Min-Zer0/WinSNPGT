# ___WinSNPGT: Genotyping of specified SNP sites on windows system___

## 👉 Latest [release package](https://github.com/Min-Zer0/WinSNPGT/raw/install.package/WinSNPGT.exe?download=)


## 💡 General Introduction
The rapid development of sequencing technology and dramatic drop in the cost have led to the generation of massive amounts of data. However, most of the raw data are analyzed on linux systems, and the process of generating variant loci information from sequencing data is a challenge for researchers unfamiliar with linux systems. We have developed a toolkit to call variant loci on the windows system, WinSNPGT. It can obtain the genotypes of the raw sequencing data for the snp loci specified in our datasets. The installation and use of this toolkit is described below.

## 📘 Table of Contents

- Background
- Change Log
- Data
- Installation
- Usage
- Frequently Asked Questions
- Contacts

## 🧾 Background
We have developed a phenotype prediction platform, **[CropGS-Hub](http://iagr.genomics.cn/CropGS/#/)**, which contains multiple high-quality datasets from important crops such as rice, maize and so on. These datasets were used as training sets to build models for phenotype prediction. Users can upload genotypes of their own samples to the platform for online phenotype prediction.

The WinSNPGT toolkit was developed to ensure that the genotypes uploaded by users match those in the training set for modeling so that bias in the prediction results can be avoided. Users can run this program on the windows system to realize the whole process from sequencing files to getting genotypes by simple operation, which is very friendly for people who have little experience in linux operation.

## 🔍 Change Log
- [Version 1.0](https://github.com/JessieChen7/WinSNPGT) - First version released on June, 1st, 2023
- [Version 2.0](https://github.com/Min-Zer0/WinSNPGT) - Second version released on August, 24th, 2023

## 🔍 Data
- The example-data files are not included in the release package, you can download [example-data.tar.gz](https://figshare.com/articles/dataset/WinSNPGT_example_data/23365061).

	The species of the example-data files is *Oryza sativa*, you can select the rice-related dataset in the toolkit to complete the genotyping.

- Java8 are not included in the release package, You can install it yourself by referring to the method in Installation.

## 🌟 Installation
- Download the [release package](https://github.com/JessieChen7/WinSNPGT/raw/installation_package/WinSNPGT.exe) and unzip to your working directory.
- Download and install [jdk-8u381-windows-x64.exe](https://www.oracle.com/java/technologies/downloads/#java8-windows).
  
## 🌟 Usage
There are three subfolders and one file after the package is unziped.

- **Input_Fastq**
- **Result**
- **sys**
	- It will not be seen if your system is set to not show hidden items
- `WinSNPGT`

To run WinSNPGT locally, you need to run the main program via `WinSNPGT` and then visualize your operation on the default browser.

Here are the running steps:

1. Double-click to run the program `WinSNPGT`
2. Move your raw sequencing data `(*.fastq.gz)` or `(*.fastq)` to the path: **./Input_Fastq**
	- if you select the way of reading excel table, you need to fill the `Sample.table.xls` in  **./Input_Fastq**
3. Select the species of your samples to be genotyped
4. Select the dataset corresponding to the model to be fitted
5. Select the way to read raw reads files 
	- if you select the way of reading excel table, you can skip to step 10
6. Enter your project name which will be output file prefix
7. Select the corresponding reads files and enter the sample name
8. If there are another samples to be genotyped, you can choose *Add*
9. After adding all samples to be genotyped and confirm the form is correct, you can choose *Submit*
10. Select the number of threads available to run the program
11. Click the *Run* button

The output format is like:

\#CHROM|POS|Line1
---|---|---
Chr1|128960|A
Chr1|133137|C
...|...|...
Chr12|321216|A
Chr12|364257|A
Chr12|364755|.
...|...|...

---
The following step-by-step notes may help you more clearly understand the use of the program:

\### **step 1**: Install WinSNPGT  
![step0_Install](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step0_Install.png)

After the installation a **WinSNPGT** folder will be created and a welcome interface will pop up.

![step1_cd](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step1_cd.png)

\### **step 2**：Double-click to run the program `WinSNPGT`  
![step2_runWinSNPGT](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step2_runWinSNPGT.png)  

When the program starts running, a web pop-up will appear in the default browser and there will also be a window running as a background program, **do not close it**.

![step3_program](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step3_program.png)

\### **step 3**: Move your raw sequencing data `(*.fastq.gz)` or `(*.fastq)` to the path: **./Input_Fastq**
![step4_move_fastq](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step4_move_fastq.png)

The subsequent procedures are only executable provided that your raw sequencing data has been moved to the path **./Input_Fastq**.

\### **step 4**: Select the species of your samples to be genotyped  
![step5_select_species](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step5_select_species.png)

\### **step 5**: Select the dataset corresponding to the model to be fitted  
![step6_select_the_dataset](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step6_select_the_dataset.png)


\### **step 6**: Select the way to read raw reads files  
Users can choose the way to manually select raw reads files in the interface.

![step7_manually_select](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step7_manually_select.png)

Or choose to automatically read raw reads files after filling table, **which is recommended when there are many samples**.

![step7_auto_excel](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step7_auto_excel.png)


If the way of reading excel table has been chosen, the `Sample.table.xls` in the subfold **./Input_Fastq** need to be filled and you can directly skip to step10.

![step7_fill_excel](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step7_fill_excel.png)

\### **step 7**: Manually fill in the parameters  
Enter your project name which will be output file prefix.  
Select the corresponding reads files and enter the sample name.

![step8_project_read_name](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step8_project_read_name.png)


\### **step 8**: If there are another samples to be genotyped, you can choose *Add* and repeat the step 7
![step9_adding](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step9_adding.png)

\### **step 9**: After adding all samples to be genotyped and confirm the form is correct, you can choose *Submit*
![step9_finish_adding](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step9_finish_adding.png)

\### **step 10**: Select the number of threads and run the program
![step10_threads_run](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/step10_threads_run.png)

\### **step 11**: Get the results
![Condition3_Done](https://github.com/JessieChen7/Image/blob/main/0824SNPGT/Condition3_Done.png)



## 💡 Frequently Asked Questions
If there are some errors reported during the running of the program, please refer to the following scenarios to solve the problem:

1. Only **English** is allowed in the **path where winSNPGT is installed**.
2. The **background program is not allowed to be closed** until you get your results.
3. Before filling in the information on the interface, the raw sequencing data must be moved to the path **./Input_fastq**.
4. If you chose the way to read excel table, you must **save and close the table after filling it**, which means it cannot be kept open.
5. If you fill in the wrong information on the web page, you can use the button **Reset** or **refresh and refill the interface** before running, and there is no need to repeat moving files steps.

The above are some possible causes of errors, if there are any other problems, welcome to contact us.

## 👥 Contacts
Jie Qiu (qiujie@shnu.edu.cn)  
Min Zhu (1185643615@qq.com)  
Jiaxin (jxchen1217@gmail.com)
