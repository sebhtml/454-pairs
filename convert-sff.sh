#!/bin/bash
# Copyright 2011 Sébastien Boisvert
# Minor updates by Jan van Haarst
# Activate debugging from here
#set -o xtrace
#set -o verbose
# Safeguards
#set -o nounset
#set -o errexit

# Grab the filename from the commandline
sffFile=$1
if [ -z "$sffFile" ]
then
  echo "No sff file entered."
	exit
fi
# Output file name
output=$sffFile.OUT
# Grab script path (from http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-in )
SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do 
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Where all the scripts are
root454=${DIR}/

# This file contains linker information
# Linkers are from 
# sourceforge.net/apps/mediawiki/wgs-assembler/index.php?title=SffToCA#Linker_Sequences
linkers=$root454"454-linkers.fasta"

# The script to extract sequence and quality form sff files is from
# http://bioinf.comav.upv.es/_downloads/sff_extract_0_2_13
sff_extract=$root454"sff_extract_0_2_13"

# Add ssaha2 to the PATH
# ssaha2 is from the Sanger Institute
# export PATH=$root454"ssaha2_v2.5.4_x86_64:"$PATH
# Check whether ssaha2 can be found (the 
SSAHA=`which ssaha2`
if [ -z "$SSAHA" ]
then
	echo "No SSAHA2 found."
	exit
fi

# Show some debug information.
echo "sffFile= $sffFile"


# Call sff_extract
# Used options: 
# -c use clipping values
# -u output in upper case
# -Q output in fastq
# -l provide linker list
# -o output prefix
# For explanation of options, see http://bioinf.comav.upv.es/sff_extract/usage.html

$sff_extract -c -u -Q -l $linkers -o $output "$sffFile"

# Now split the extracted reads in forward, reverse and singletons
$root454"split-fastq.py" "$output.fastq"
