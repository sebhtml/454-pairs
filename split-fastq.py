#!/usr/bin/python
#encoding: utf-8
# Author: Sébastien Boisvert
# see the README for the output

import sys

fastqFile=sys.argv[1]

singleOut=fastqFile+".Single.fastq"
singleEndFile=open(singleOut,"w")
reverseOut=fastqFile+".Reverse.fastq"
reverseFile=open(reverseOut,"w")
forwardOut=fastqFile+".Forward.fastq"
forwardFile=open(forwardOut,"w")
devNull=open("/dev/null","w")

destination=devNull

lineNumber=0

singleReads=0
reverseReads=0
forwardReads=0
garbageReads=0

print "input= "+fastqFile

for line in open(fastqFile):
	if lineNumber==0:
		tokens=line.split(".")
		operationCode=tokens[1].strip()
		if operationCode=='f':
			destination=forwardFile
			forwardReads+=1
		elif operationCode=='r':
			destination=reverseFile
			reverseReads+=1
		elif operationCode=='fn':
			destination=singleEndFile
			singleReads+=1
		else:
			destination=devNull
			garbageReads+=1
	destination.write(line)
	lineNumber+=1
	lineNumber=lineNumber%4

forwardFile.close()
reverseFile.close()
singleEndFile.close()

total=singleReads+reverseReads+forwardReads+garbageReads
print ""
print "paired sequences:"
print " reverse reads: "+str(reverseReads)+" ("+str(reverseReads*100/total)+"%)"
print "  see "+reverseOut
print " forward reads: "+str(forwardReads)+" ("+str(forwardReads*100/total)+"%)"
print "  see "+forwardOut
print ""
print "single reads: "+str(singleReads)+" ("+str(singleReads*100/total)+"%)"
print "  see "+singleOut
print "rubbish reads: "+str(garbageReads)+" ("+str(garbageReads*100/total)+"%)"
print "  see /dev/null"

