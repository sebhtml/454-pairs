#!/bin/bash
# Author: Sébastien Boisvert
#$ -N __JOB__
#$ -pe mpi 1
#$ -q research
#$ -cwd

module load python/2.6.5

/u/sboisvert/git-clones/454-pairs/convert-sff.sh \
