#!/bin/bash
# Sébastien Boisvert

# where all these things are
root454=/oicr/data/archive/projects/FlightlessBirdSequencing/analysis/454-convertor/


# contains linkers
# linkers are from 
# sourceforge.net/apps/mediawiki/wgs-assembler/index.php?title=SffToCA#Linker_Sequences
linkers=$root454/454-linkers.fasta

# the script is from 
# http://bioshare.bioinformatics.ucdavis.edu/Data/hcbxz0i7kg/Parrot/sff_extract_0_2_8.py
sff_extract=$root454/sff_extract_0_2_8.py

# add ssaha2 in the path
# ssaha2 is from the Sanger Institute
export PATH=$root454/ssaha2_v2.5.4_x86_64:$PATH

sffFile=$1

output=$sffFile.OUT

# call sff_extract
# options: 
# -c use clipping values
# -u output in upper case
# -Q output in fastq
# -l provide linker list
# -o output prefix

$sff_extract -c -u -Q -l $linkers -o $output $sffFile

