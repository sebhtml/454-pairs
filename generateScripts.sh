# generate qsub scripts.

for i in $(find . |grep "\.sff"$)
do 
	fileName=$(basename $i)
	qsub=$fileName-qsub.sh
	cp qsub-template-sff_extract.sh $qsub
	expression="s/__JOB__/$(basename $i)/g"
	sed -i $expression $qsub
	echo $i >> $qsub
done


