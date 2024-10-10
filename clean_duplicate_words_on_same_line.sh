#!/bin/bash

cat "$1" | sed -e 's/\([a-z]\|)\|\.\|;\)\([A-Z]\|[0-9]\)/\1 \2/g' \
| sed -e 's/cpflinstituto/cpfl/g' \
| sed -e 's/shipup/ship up/g' \
| sed -e 's/aledson/al edson/g' \
| sed -e 's/NHAEDSON/NHA EDSON/g' \
| sed -e 's/groovesfunk/grooves funk/g' \
| sed -e 's/tionschol/tion schol/g' \
| sed -e 's/EInter/E Inter/g' \
| sed -e 's/BUSTVA/BUSTV A/g' \
| sed -e 's/3Web/3 Web/g' \
| sed -e 's/capufde/capu fde/g' \
| sed -e 's/tracermini/tracer mini/g' \
| sed -e 's/³S/³ S/g' \
| sed -e 's/pageBit/page Bit/g' \
| sed -e 's/)Á/) Á/g' \
| sed -e 's/MUBIFish/MUBI Fish/g' \
| sed -e 's/up Sight/upSight/g' \
| sed -e 's/Bit Bet/BitBet/g' \
| sed -e 's/GITA/Git A'/g \
| sed -e 's/\([0-9]\{4\}\)\([A-Z]\)/\1 \2/g' \
| sed -e 's/20062001/2006 2001/g' \
| sed -e 's/++C++/++ C++/g' \
| sed -e 's/HTMLHTML/HTML/g' \
| sed -e 's/CADCAD/CAD/g' \
| sed -e 's/E+1/E +1/g' \
| sed -e 's/Course Page on //g' \
| sed -e 's/Course page on //g' \
| grep -v 'logo$' \
| grep -v 'Show all' \
| grep -v 'Show credential' \
| grep -v 'Certificate$' \
| grep -v 'Part ' \
| grep -v '(Portuguese)' \
| grep -v 'endorse' \
| grep -v '(back)' \
| grep -v 'Wikipedia' \
| grep -v 'Udemy Profile' \
| grep -v 'ences (Free' \
| grep -v 'educational experien' \
| grep -v 'ences across' \
| grep -v 'Google Drive' \
> tmp

awk '{
  lead_space = $0;
  sub(/[^\t ]+.*$/, "", lead_space);
	delete seen
	line = ""
	for (i=1; i<=NF; i++) {
		pass = ("About" == $i || $i == "undertake" || $i == "Xavier" || $i == "many" || $i == "Peer" ) ? 1 : pass
		pass = ($i == "skills" || $i == "Skills:" || $i == "fde-capu") ? 0 : pass
		nobr = ($i == "USP") ? 1 : nobr
		nobr = ($i == "Skills:" || $i == "Artes") ? 0 : nobr
		if ($i == "·" || pass || !seen[$i]++) {
			line = line sprintf("%s%s", $i, (i<NF ? FS : ""))
		}
	}
	printf "%s%s", (nobr ? "" : lead_space) line, nobr ? "" : "\n"
}' tmp \
| sed -e 's/[0-9]\+ mos to.*//g' \
| sed -e 's/ more\.$//g' \
| sed -e 's/\.-/.\n            -/g' \
| sed -e 's/7\. 5/7.5/g' \
| sed -e 's/1\. 1/1.1/g' \
| sed -e 's/,P/, P/g' \
| sed -e 's/Git Hub/GitHub/g' \
| sed -e 's/ - $//g' \
| sed -e '/^$/N;/^\n$/D' \
| sed -e 's/ Credential ID .*//' \
| sed -e 's/ Issued / /g' \
| sed -e 's/About About/About/g' \
| sed -e 's/\( ·\)\{2,\}//g' \
| sed -e 's/management\. Created.*/management./g' \
| sed -e 's/protection\. For many.*/protection./g' \
| sed -e 's/community\. Continuous.*/community./g' \
| sed -e 's/Artes\. Selected.*/Artes./g' \
| sed -e 's/Kelvin Zero.*/Kelvin/g' \
| sed -e 's/young people\.$/young people.\n/g' \
> output.txt

perl -0777 -pi -e 's/\n\s*(Samsung|Pierian|Udemy)/- $1/g' output.txt
perl -0777 -pi -e 's/\n\n(\s+)Skills/\n$1Skills/g' output.txt
perl -0777 -pi -e 's/\n\n(Prompt|SQL|Virtual|Deep|SPTW|Python)/\n    $1/g' output.txt
perl -0777 -pi -e 's/\n\n(.{,60})\n\n(.{,60})/\n\n$1\n$2/g' output.txt
perl -0777 -pi -e 's/\n\s{7,}Skills/\n      Skills/g' output.txt
perl -0777 -pi -e 's/\n\s{7,}(Python)/\n    $1/g' output.txt
perl -0777 -pi -e 's/\t\s//g' output.txt
perl -0777 -pi -e 's/ {6,12}/        /g' output.txt
perl -0777 -pi -e 's/ \n/\n/g' output.txt
perl -0777 -pi -e 's/Present.*\n/Present\n/g' output.txt
perl -0777 -pi -e 's/Art\n\n/Art\n/g' output.txt
perl -0777 -pi -e 's/ ·\n/\n/g' output.txt
perl -0777 -pi -e 's/\n\n(UX.*Ocean)\nProjects/i\n    $1\n\nProjects/g' output.txt
perl -0777 -pi -e 's/\n    \d+ experiences.*compan(ies|y)\n/\n/g' output.txt

file="F.txt"

match_a="Skills\n    Artes\n"
match_b="Languages"
to_replace="C"
replacement="D"
export match_a match_b to_replace replacement

#perl -0777 -pi -e "s/(?<=$match_a).*?(?=$match_b)/\$& =~ s/$to_replace/$replacement/g;" output.txt
perl -0777 -pi -e '
s/Skills\n    Artes.*Languages/eval { $& =~ s\/x\/X\/gr }/e
' output.txt
