#!/usr/bin/python
from pywebio import start_server
from pywebio.output import *
from pywebio.pin import *
import xlrd
import requests
import random
import time
from datetime import datetime
import os
import sys

def Timer(Start,End,Message):
	m, s = divmod(End-Start, 60)
	h, m = divmod(m, 60)
	put_text(Message,"used time: %02d:%02d:%02d" % (h, m, s))

def Getwd():
    for line in open('./install_dir'):
        chr_dir = line
    dir_list = chr_dir[1:].split("\\")[:-1]
    Path = "/cygdrive/" + dir_list[0][:-1] + "/"
    for i in range(len(dir_list)-1):
        Path = Path+'"'+dir_list[i+1]+'"'+"/"
    return Path

def Select_Ref():
    with open('./Reference_Genome/GenomeAnalysis.config.txt', 'r') as f:
        Gen_Config = f.read()
    Gen_Config_info = Gen_Config.split(">>")[1:]
    Gen_list = {}
    Gen_info = {}
    Gen_url = {}
    for S in Gen_Config_info:
        info = S.split(">")
        speciesnamelist = info[0].strip()
        line_list = []
        for datesetinfo in info[1:]:
            line_list += [datesetinfo.split("**")[0].split(" ")[1]]
            Gen_list[speciesnamelist]=line_list
            Species_Dataset = speciesnamelist+str("_")+datesetinfo.split("**")[0].split(" ")[1]
            Dataset_url = datesetinfo.split("**")[0].split(" ")[2].split("[")[1].split("]")[0]
            Gen_url[Species_Dataset]=Dataset_url
            Dataset_info = datesetinfo.split("**")[1:]
            Gen_info[Species_Dataset]=Dataset_info
    return Gen_list,Gen_url,Gen_info

def readExcel():
    workbook = xlrd.open_workbook('Input_Fastq/Sample.table.xls')
    worksheet = workbook.sheet_by_name('Sheet1')
    nrows = worksheet.nrows
    ncols = worksheet.ncols
    data = []
    for i in range(nrows):
        row = []
        for j in range(ncols):
            cell_value = worksheet.cell_value(i, j)
            row.append(cell_value)
        data.append(row)

    data = [row[:-2] for row in data]
    data = [row for row in data if any(col != '' for col in row)]

    Samples_list = []
    for i in data[3:]:
        Sample_dict = {'Sample': i[1], 'Read1': i[2], 'Read2': i[3]}
        Samples_list.append(Sample_dict)
        project = data[1][2]
    return Samples_list,project

def Manual_select_Sample():
    os.system('mv %sInput_Fastq/* ./Input_Fastq/  '%(Getwd()))
    os.system('mv ./Input_Fastq/Sample.table.xls %sInput_Fastq/ '%(Getwd()))
    gz_files = os.listdir(r'./Input_Fastq/')
    if len(gz_files) == 0:
        popup('ERROR: Reads file does not exist!',[put_html("<font color=red>Please ensure that you have moved the reads file *.fastq.gz to the path: Input_Fastq.</font>")])		
    else:
        with use_scope('Project_4',clear=True):
            put_input('ProjectName', label='Please enter your project name which will be the prefix of output files.')
        
        Samples_list = []
        project = None
        read_files = os.listdir(r'Input_Fastq/')
        with use_scope('Project_5'):
            put_html("<br>")
            put_text("Please enter your sample names and select the the corresponding reads files.")
            put_grid([[put_text('Sample'), put_text('Read1'),put_text('Read2')]])
            put_row([put_input('Sample'),
                     put_select('Read1', options=read_files),
                     put_select('Read2', options=read_files)])
            put_actions('Add_Button',buttons=['Add','Submit','Reset'])

        while True:
            pin_wait_change("Add_Button")
            if pin.Add_Button == "Add":
                project = pin.ProjectName
                Sample_dict = {'Sample': pin.Sample, 'Read1': pin.Read1, 'Read2': pin.Read2}
                Samples_list.append(Sample_dict)
                with use_scope('Project_3',clear=True):
                    put_table(Samples_list,header=["Sample", "Read1", "Read2"]) 
            elif pin.Add_Button == "Reset":
                with use_scope('Project_3',clear=True):
                    put_text("")
                with use_scope('Project_4',clear=True):
                    put_text("")
                with use_scope('Project_5',clear=True):
                    put_text("")
                break
            elif pin.Add_Button == "Submit":
                with use_scope('Project_5',clear=True):
                    put_text("")
                break
        return(project,Samples_list)

def download(SpeciesData,URL):
    start = time.time()
    response = requests.get(URL, stream=True)
    size = 0
    chunk_size = 1024
    content_size = int(response.headers['content-length'])
    with use_scope('Run_process'):
        put_html('<font color=#0066CC size=4.5>Start download species reference genome dataset <b>[File size]: {size:.2f} MB</b></font>'.format(size = content_size / chunk_size /1024))
        barname = ''.join(random.sample('abcdefghijklmnopqrstuvwxyz',5))
        put_processbar(barname,0, label= "Downloading...")
        try:
            if response.status_code == 200:
                filepath = "./Reference_Genome/" + '%s.tar.gz'%(SpeciesData)
                with open(filepath,'wb') as file:
                    for data in response.iter_content(chunk_size = chunk_size):
                        file.write(data)
                        size +=len(data)
                        set_processbar(barname,(size / content_size), label= "Downloading...")
            end = time.time()
            put_html('<font color=#0066CC size=4>Download completed!,times: %.2fs</font>'% (end - start))
        except:
            put_html('<font color=#red size=4>Network connection Error! </font>')
 
def Check_Ref(SpeciesData,URL):
    if os.path.exists(r'Reference_Genome/%s'%(SpeciesData)) == False and os.path.exists(r'Reference_Genome/%s.tar.gz'%(SpeciesData)) == False:
        download(SpeciesData,URL)
    CheckResult = "No"
    while CheckResult != "OK":
        with put_loading():	
            os.system('tar -zxvf ./Reference_Genome/%s.tar.gz '%(SpeciesData))
            os.system('rm ./Reference_Genome/%s.tar.gz '%(SpeciesData))
            os.system('mv %s ./Reference_Genome/ '%(SpeciesData))
            element = SpeciesData.split("_")
            species = element[0]
            reference = element[1] + '_' + element[2]
            files = os.listdir(r'Reference_Genome/%s'%(SpeciesData))
            Check_file = {species+'.fasta',species+'.fasta.fai',
                        species+'.1.bt2',species+'.2.bt2',species+'.3.bt2',species+'.4.bt2',
                        species+'.rev.1.bt2',species+'.rev.2.bt2',species+'.dict',
                        reference+'.intervals',
                        'SNP_intervals.fasta',
                        'SNP_intervals.1.bt2','SNP_intervals.2.bt2','SNP_intervals.3.bt2','SNP_intervals.4.bt2',
                        'SNP_intervals.rev.1.bt2','SNP_intervals.rev.2.bt2'}
        if  set(files) == Check_file:
            with use_scope('Run_process',clear=True):
                style(put_html("<h3>Indexing of the dataset has been completed!</h3>"), 'color:green')
            CheckResult = "OK"
        else:
            os.system('rm -rf ./Reference_Genome/%s '%(SpeciesData))
            CheckResult = "No"
            download(SpeciesData,URL)

def Alignment(Reference_dir,Species,Sample,Read1,Read2,Thread):
	start = time.time()
	os.system('/tools/bowtie2-2.4.5-mingw-x86_64/bowtie2 -p %s \
		-x ./Reference_Genome/%s/SNP_intervals \
		-U ./Input_Fastq/%s ./Input_Fastq/%s \
		-S temp.sam'%(Thread,Reference_dir,Read1,Read2))
	os.system('/tools/samtools-1.16.1/samtools.exe fastq -0 \
		read.fastq temp.sam && rm -rf temp.sam')
	os.system('/tools/bowtie2-2.4.5-mingw-x86_64/bowtie2 -p %s \
		-x ./Reference_Genome/%s/%s \
		-U read.fastq\
		--rg-id %s \
		--rg "PL:ILLUMINA" \
		--rg "SM:%s" \
		-S ./%s.sam'%(Thread,Reference_dir,Species,Sample,Sample,Sample))
	os.system('rm -rf read.fastq')
	os.system('/tools/samtools-1.16.1/samtools.exe view -bS \
		./%s.sam -t ./Reference_Genome/%s/%s.fai > ./%s.bam && \
		rm -rf ./%s.sam'%(Sample,Reference_dir,Species,Sample,Sample))
	os.system('/tools/samtools-1.16.1/samtools.exe sort -@ %s\
		-o ./%s.sorted.bam ./%s.bam && rm -rf ./%s.bam'%(Thread,Sample,Sample,Sample))
	end = time.time()
	Timer(start,end,Sample+" Alignment")

def Merge_rmPCRdup(Project,Thread):
	start = time.time()
	os.system('mkdir -p samplebamfile && mv *.sorted.bam samplebamfile')
	os.system('/tools/samtools-1.16.1/samtools.exe merge ./%s.sorted.bam \
		./samplebamfile/*.sorted.bam && rm -rf ./samplebamfile'%(Project))
	os.system('/tools/samtools-1.16.1/samtools.exe rmdup -sS ./%s.sorted.bam \
		./%s.rmdup.bam && rm -rf ./%s.sorted.bam'%(Project,Project,Project))
	os.system('/tools/samtools-1.16.1/samtools.exe sort -@ %s -o ./%s.rmdup.sorted.bam \
		./%s.rmdup.bam && rm -rf ./%s.rmdup.bam'%(Thread,Project,Project,Project))
	os.system('/tools/samtools-1.16.1/samtools.exe index \
		./%s.rmdup.sorted.bam'%(Project))
	end = time.time()
	Timer(start,end,"Merge_rmPCRdup")

def Calling_SNP(Reference,ref,Project,Intervals,Thread):
	start = time.time()
	os.system('java -Xmx%sg -jar GenomeAnalysisTK.jar \
		-T RealignerTargetCreator \
		-R ./Reference_Genome/%s \
		-I %s.rmdup.sorted.bam \
		-o %s.realn.intervals'%(Thread,Reference,Project,Project))
	os.system('java -Xmx%sg -jar GenomeAnalysisTK.jar \
		-T IndelRealigner \
		-R ./Reference_Genome/%s \
		-targetIntervals %s.realn.intervals \
		-I %s.rmdup.sorted.bam \
		-o %s.realn.bam'%(Thread,Reference,Project,Project,Project))
	os.system('mv ./Reference_Genome/%s ./'%(Intervals))
	os.system('java -Xmx%sg -jar GenomeAnalysisTK.jar \
		-T UnifiedGenotyper \
		--genotype_likelihoods_model SNP\
		-R ./Reference_Genome/%s \
    	-I %s.realn.bam \
    	-L %s.intervals\
    	-o %s.raw.vcf \
    	--output_mode EMIT_ALL_SITES'%(Thread,Reference,Project,ref,Project))
	os.system('mv %s.intervals ./Reference_Genome/%s'%(ref,Intervals)) 	
	os.system('rm -rf %s.rmdup.sorted.bam %s.rmdup.sorted.bam.bai \
		%s.realn.bam %s.realn.bai %s.realn.intervals \
		%s.raw.vcf.idx'%(Project,Project,Project,Project,Project,Project))
	end = time.time()
	Timer(start,end,"Calling_SNP")

def VCF2Genotyping(Project,SamplesNum,Reference):
	sample_col=''
	for i in range(SamplesNum):
		sample_col = sample_col+',$'+str(10+i)
		col_num = "$1,$2,$4,$5"+sample_col
	os.system("grep -v '##' %s.raw.vcf | awk '{print %s}' > %s.vcf2Genotyping.txt"%(Project,col_num,Project))
	VCF_df = open(Project+'.vcf2Genotyping.txt', 'r')
	formatted_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
	with open('Genotype.txt', 'w') as fw:
		fw.write('##Date=%s\n'%formatted_datetime)
		fw.write('##Reference=%s\n'%Reference)
		fw.write('##Project=%s\n'%Project)
		for line in VCF_df:
			if line[0] == "#":
				outputline=line[:-1].split(' ')[0:2] + line[:-1].split(' ')[4:SamplesNum+4]
				fw.write('\t'.join(map(str, outputline)))
				fw.write('\n')
			else:
				info = line[:-1].split(" ")
				ChrNum = info[0]
				Pos = info[1]
				bas = [info[2]] + info[3].split(',')
				outputline=[ChrNum,Pos]
				for i in range(SamplesNum):
					SNP = info[4+i].split(':')[0].split('/')
					if SNP[0] != SNP[1]:
						outputline = outputline + ['H']
					else:
						if SNP[0] == '.':
							outputline = outputline + ['.']
						else:
							outputline = outputline + [bas[int(SNP[0])]]
				fw.write('\t'.join(map(str, outputline)))
				fw.write('\n')
	os.system('rm -rf %s.vcf2Genotyping.txt'%Project)
	outputdir = str(datetime.now().strftime("%Y-%m-%d_%Hh%Mm%Ss."))+str(Project)+".SNPGT"
	os.system('mkdir %s/Result/%s'%(Getwd(),outputdir))
	os.system("mv Genotype.txt %s.raw.vcf %s/Result/%s"%(Project,Getwd(),outputdir))

def Genotyping(SpeciesData,URL,project,Samples_list,thread):
    Check_Ref(SpeciesData,URL)
    element = SpeciesData.split("_")
    species = element[0]
    reference = element[1] + '_' + element[2]
    alignment_reference_dir = SpeciesData
    gatk_reference = species+'_'+reference+'/'+species+'.fasta'
    intervals = SpeciesData+'/'+reference+'.intervals'
    put_processbar('bar2',0.2, label= "Alignment...")
    os.system('gunzip ./Input_Fastq/* ')
    for i in Samples_list:
        for key, value in i.items():
            if key != "Sample":
                if value.endswith('.gz'):
                    i[key] = value[:-3]
        Alignment(alignment_reference_dir,species,i['Sample'],i['Read1'],i['Read2'],thread)
        set_processbar('bar2', 0.45, label="Merging & Removing PCR duplication ...")
    Merge_rmPCRdup(project,thread)
    set_processbar('bar2', 0.7,label="Calling SNP ...")
    Calling_SNP(gatk_reference,reference,project,intervals,thread)
    os.system('mv -f ./Input_Fastq/* %s/Input_Fastq/ '%(Getwd()))
    VCF2Genotyping(project,len(Samples_list),species+'_'+reference)
    set_processbar('bar2', 1,"Done ! ")

def Input_parameter():
    img = open('../BgPic/head.png', 'rb').read() 
    put_image(img, width='1000px')
					
    Species2Dataset,Species2Dataset_url,Species2Dataset_info = Select_Ref()
    Dataset = list(Species2Dataset.keys())
    put_html("<h2>Species and Dataset</h2>")        
    with use_scope('SpeciesDataset1'):
        put_html('<h3 style="color:#0066CC">Please select the species and dataset to genotype your samples.</h3>')
        put_select('Species', options=Dataset)
    with use_scope('SpeciesDataset2'):    
        put_select('Dataset', options=Species2Dataset[Dataset[0]])

    put_html("<h2>Project</h2>")
    with use_scope('Project_1'):
        put_html('<h3 style="color:#0066CC">Please select your samples raw data.</h3>')
        put_html('''1. Move your reads files 
                        <strong><font color=#009432> *.fastq.gz </font></strong>
                        or 
                        <strong><font color=#009432> *.fastq </font></strong> 
                        to the path: 
                        <strong><font color=#009432> Input_Fastq</font></strong>.
                        <br>
                    2. If you selected 
                        <strong>Reading Excel table</strong>, 
                        please fill in the Ecxel file
                        <strong><font color=#009432> Input_Fastq/Sample.table.xls </font></strong>.
                        <br><br>''')
        img = open('../BgPic/Excel.exp.png', 'rb').read()
        put_image(img, width='400px')
        put_text("")
            
    with use_scope('Project_2'):
        put_radio('ReadMode',options=["Manual selection","Reading Excel table"])
    with use_scope('Project_4'):
                    put_text("")    
    with use_scope('Project_3'):
                    put_text("")
    with use_scope('Project_5'):
        put_text("")
    
    put_html("<hr>")
    style(put_html("<h3>Please enter the number of threads available to run the program.</h3>"),'color:#0066CC')
    put_slider('thread',value = 4, min_value = 1, max_value = 64,
               help_text='The more threads, the faster it will run. However, the actual configuration of the computer needs to be considered.')
    put_actions('RunProgram',buttons=['Run'],help_text='There will be a 1-2 hour waiting time.')
    

    while pin.RunProgram != "Run":
        pin_wait_change("Species","ReadMode","RunProgram")
        
        if pin.RunProgram == "Run":
            if pin.ReadMode == None:
                put_html('''<h3 ><font color=red >ERROR: Sample undefined!</font></h3>
                            <font color=#0066CC size=3>Please refresh this page and make sure you have selected the raw data for your samples.</font>''')
                break

            SpeciesData = pin.Species + str("_") + pin.Dataset
            with use_scope('SpeciesDataset1', clear=True):
                display_table = []
                for line in Species2Dataset_info[SpeciesData]:
                    if "Paper" not in line:
                        if "ID" in line:
                            display_table.append([line[1:].split("=")[0],put_markdown("["+line[1:].split("=")[1].split("(")[0]+"]("+line[1:].split("=")[1].split("(")[1]+")")])
                        else:
                            display_table.append(line[1:].split("="))
                    else:
                        papertitle = line[1:].split("=")
                        display_table.append([papertitle[0],put_markdown(papertitle[1].split("|")[0]+'\n'+ papertitle[1].split("|")[1])])
                display_table += [["Downlod Links",put_markdown("["+Species2Dataset_url[SpeciesData]+"]("+Species2Dataset_url[SpeciesData]+")")]]
                put_table(display_table)
            with use_scope('SpeciesDataset2', clear=True):
                put_text("")
            with use_scope('Project_1', clear=True):
                put_text("")
            
            Genotyping(SpeciesData,Species2Dataset_url[SpeciesData],project,Samples_list,pin.thread)

            img = open('../BgPic/Done.png', 'rb').read()
            put_image(img, width='1000px')
            sys.exit() 
        
        if pin.ReadMode == "Manual selection":
            with use_scope('Project_1',clear=True):
                put_text("")
            with use_scope('Project_4',clear=True):
                put_text("")
            with use_scope('Project_5',clear=True):
                put_text("")
                project,Samples_list = Manual_select_Sample()
                if project != None:
                    with use_scope('Project_4',clear=True):
                        put_html("<br><font size=4.5><strong><em>%s</em></strong></font>"%project)

        elif pin.ReadMode == "Reading Excel table":
            with use_scope('Project_1',clear=True):
                put_text("")
            with use_scope('Project_3',clear=True):
                put_text("")
            with use_scope('Project_4',clear=True):
                put_text("")
            with use_scope('Project_5',clear=True):
                os.system('mv %sInput_Fastq/* ./Input_Fastq/  '%(Getwd()))
                Samples_list,project = readExcel()
                put_html("<br><font size=4.5><strong><em>%s</em></strong></font>"%project)
                put_table(Samples_list,header=["Sample", "Read1", "Read2"])

        with use_scope('SpeciesDataset2', clear=True):
            put_select('Dataset', options=Species2Dataset[pin.Species])
        
if __name__ == '__main__':
    start_server( Input_parameter,port = 80,debug=True,auto_open_webbrowser=True)