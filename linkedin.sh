#!/bin/bash

infile="README.md"
outfile="linkedin.md"
tmpfile="tmpfile.md"

sed \
	-e '1,6d' \
	-e '/^#/d' \
	-e 's/\*\*//g' \
	-e '/^\t\+\* [0-9]/d' \
	-e 's/ \[.\+\](.\+)//g' \
	$infile > $tmpfile

sed -e ':a; $!{N;ba}; s/\n\n/\n/g' \
	-i $tmpfile

head -n -8 $tmpfile > $outfile

rm $tmpfile

echo -e "\n* Art & Generative Algorithms; Deep Learning; Music." >> $outfile

bytes=`du -b $outfile | awk '{print $1}'`
if [[ $bytes -gt 2600 ]] ; then
	echo "$bytes (max: 2600) fail.";
	exit 1;
else
	echo "$bytes ok.";
	exit 0;
fi;
