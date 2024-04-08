#!/bin/bash

infile="README.md"
outfile="linkedin.md"
tmpfile="tmpfile.md"

sed \
	-e '1,6d' \
	-e '/^#/d' \
	-e 's/\*\*//g' \
	-e '/^\t\+\* [0-9]/d' \
	-e 's/\[\(.\+\)\](.\+)/\1/g' \
	-e 's/\.\./\./g' \
	$infile > $tmpfile

#	-e 's/[0-9]\+ hours, //g' \
#	-e 's/International\..*/International./g' \
#	-e 's/Ocean\..*/Ocean./g' \
#	-e '/Participated.*/d' \

sed -e ':a; $!{N;ba}; s/\n\n/\n/g' \
	-i $tmpfile

head -n -4 $tmpfile > $outfile
#cat $tmpfile > $outfile

rm $tmpfile

cat $outfile
cat "$outfile" | xclip -selection clipboard

bytes=`du -b $outfile | awk '{print $1}'`
if [[ $bytes -gt 2600 ]] ; then
	echo "$bytes (max: 2600) fail.";
	exit 1;
else
	echo "$bytes ok (max:2600).";
	exit 0;
fi;
