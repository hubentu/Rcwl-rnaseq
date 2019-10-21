FROM ubuntu

RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y g++ libbz2-dev liblzma-dev libncurses5-dev make python python-pip python-dev wget zlib1g-dev unzip default-jre r-base
RUN apt-get clean

WORKDIR /opt

# samtools
RUN  wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
     tar xvf samtools-1.9.tar.bz2 && \
     cd /opt/samtools-1.9 && make -j && make install && \
     rm /opt/samtools-1.9.tar.bz2

# fastqc
RUN cd /opt && wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip && \
    unzip fastqc_v0.11.8.zip && \
    chmod +x /opt/FastQC/fastqc && \
    ln -s /opt/FastQC/fastqc /usr/local/bin/ && \
    rm /opt/fastqc_v0.11.8.zip

# STAR
RUN wget https://github.com/alexdobin/STAR/archive/2.7.3a.tar.gz && tar xvf 2.7.3a.tar.gz && \
    ln -s /opt/STAR-2.7.3a/bin/Linux_x86_64/STAR* /usr/local/bin/ && \
    rm /opt/2.7.3a.tar.gz

# RSeQC
RUN pip install numpy pysam && pip install RSeQC

# gtf2bed
RUN cd /usr/local/bin && \
    wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/gtfToGenePred && \
    wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/genePredToBed && \    
    chmod +x gtfToGenePred genePredToBed

# featureCount
RUN cd /opt && wget https://downloads.sourceforge.net/project/subread/subread-1.6.3/subread-1.6.3-Linux-x86_64.tar.gz && \
    tar xvf subread-1.6.3-Linux-x86_64.tar.gz && \
    ln -s /opt/subread-1.6.3-Linux-x86_64/bin/* /usr/local/bin/ && \
    rm /opt/subread-1.6.3-Linux-x86_64.tar.gz
