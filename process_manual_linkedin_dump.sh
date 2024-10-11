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
| grep -v '        Iran' \
| grep -v '        Intermezzo' \
| grep -v 'Vida de frango' \
| grep -v 'Other contributors' \
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
perl -0777 -pi -e 's/\n Experience\n/\nExperience\n/g' output.txt
perl -0777 -pi -e 's/ yr to / yr /g' output.txt
perl -0777 -pi -e 's/ \| · / · /g' output.txt
perl -0777 -pi -e 's/\nFlávio’s top skills.*?Experience//s' output.txt
perl -0777 -pi -e 's/    Developer\n/Developer\n/s' output.txt
perl -0777 -pi -e 's/        fde-capu.*?    Composer/\nComposer/s' output.txt
perl -0777 -pi -e 's/        Projeto Afrovale.*?    Technical/\nTechnical/s' output.txt
perl -0777 -pi -e 's/        Omnion - MKT.*?    Publishing/\nPublishing/s' output.txt
perl -0777 -pi -e 's/        \.: Thelma.*?    https/        https/s' output.txt
perl -0777 -pi -e 's/        Thelma Chan - Dois.*?Sound/\nSound/s' output.txt
perl -0777 -pi -e 's/\n\n        - /\n        - /g' output.txt
perl -0777 -pi -e 's/        Insustent.*?Technical/\nTechnical/s' output.txt
perl -0777 -pi -e 's/    Music/\nMusic/g' output.txt
perl -0777 -pi -e 's/    Studio/\nStudio/g' output.txt
perl -0777 -pi -e 's/        Art tec.*?Art Im/        Art Im/s' output.txt
perl -0777 -pi -e 's/\n    System Anal/\n\nSystem Anal/g' output.txt
perl -0777 -pi -e 's/\n        - (web|seller|Original|Audio)/; $1/g' output.txt
perl -0777 -pi -e 's/pianos- system.*/pianos;/g' output.txt
perl -0777 -pi -e 's/        - (system|Digital|Music)/        $1/g' output.txt
perl -0777 -pi -e 's/;- Digi.*//g' output.txt
perl -0777 -pi -e 's/;;/;/g' output.txt
perl -0777 -pi -e 's/⭐/⭐ IMDB/g' output.txt
perl -0777 -pi -e 's/    Sales/\nSales/s' output.txt

perl -0777 -pi -e "s/        Submarino.*?produtora:/
  my \$o = $& =~ s\/\s*\n\s*\/; \/rg;
  \$o
/es" output.txt

perl -0777 -pi -e 's/        - brands\.\n//g' output.txt
perl -0777 -pi -e 's/        Gluck Pianos\n//g' output.txt
perl -0777 -pi -e 's/        Assistance//g' output.txt
perl -0777 -pi -e 's/        Irmãos.*?música\n//g' output.txt
perl -0777 -pi -e 's/        Thelma Chan\n\s+Palminha.*?\)\n//g' output.txt
perl -0777 -pi -e 's/\n in choosing.*?\n/\n/g' output.txt
perl -0777 -pi -e 's/    Audio Eng/\nAudio Eng/g' output.txt
perl -0777 -pi -e 's/    Internship/\nInternship/g' output.txt
perl -0777 -pi -e 's/    Guest/\nGuest/g' output.txt
perl -0777 -pi -e 's/        Music tra.*; technology.\n//g' output.txt
perl -0777 -pi -e 's/MUBI\n\s+In/MUBI | In/g' output.txt
perl -0777 -pi -e 's/        Álamo.*?\)\n//g' output.txt
perl -0777 -pi -e 's/    (Web D|Catalog)/\n$1/g' output.txt
perl -0777 -pi -e 's/Do not l.*?\n/\n/g' output.txt
perl -0777 -pi -e 's/\n\s+BitBet home page\n//g' output.txt
perl -0777 -pi -e 's/        Bachelor.*2007\n//g' output.txt
perl -0777 -pi -e 's/J Cage -/Monograph: J Cage -/g' output.txt
perl -0777 -pi -e 's/        4º.*?Pascoal\n//gs' output.txt
perl -0777 -pi -e 's/\nUSP/\n    USP/g' output.txt
perl -0777 -pi -e 's/\s{8}Fernando.*?\n//g' output.txt
perl -0777 -pi -e 's/Festival\n\s{8}SESC/Festival SESC/g' output.txt
perl -0777 -pi -e 's/RS\. Com.*/RS./g' output.txt
perl -0777 -pi -e 's/ {8}(Edino|Ronaldo).*\n\s{8}Fest.*\n//g' output.txt
perl -0777 -pi -e 's/2015\n {8}Dur/2015. Dur/g' output.txt
perl -0777 -pi -e 's/ {8}Certific....Music.*?\.\n//gs' output.txt
perl -0777 -pi -e 's/Projects\n\n    /Projects\n    /g' output.txt

perl -0777 -pi -e "s/\nSkills\n.*?Scoring\n/
  my \$o = $& =~ s\/\s*\n\s*\/; \/rg;
  \$o =~ s\/^.*?Skills \/\/;
  my @l = split('; ', \$o);
  foreach my \$e (@l) {
    \$uniq{\$e} = 1;
  }
  \$o = join ' | ', sort { lc(\$a) cmp lc(\$b) } keys %uniq;
  \$o =~ s\/ 42.*?lo \/\/;
  \$o =~ s\/ \(Self.*?\)\/\/;
  \$o =~ s\/ \(Free.*?\)\/\/;
  \$o =~ s\/ Cataloger.*?Comp\/ Comp\/;
  \$o =~ s\/ Android:.*?on \/ Android \/;
  \$o =~s\/ Deep Learning Intro.*? \|\/\/;
  \$o =~s\/ Faculd.*? \|\/\/;
  \$o =~s\/ Intro.*? \|\/\/g;
  \$o =~s\/ Prompt Engineering Lab \|\/\/g;
  \$o =~s\/ Python 3.*? \|\/\/g;
  \$o =~s\/ - Complete \|\/ |\/g;
  \$o =~s\/ at .*? \|\/ |\/g;
  \$o =~s\/ SFX.*? \|\/\/g;
  \$o =~s\/ Artes \|\/\/g;
  \$o =~s\/ Android St.*? \|\/\/g;
  \$o =~s\/ Skills.*? \|\/\/g;
  \$o =~s\/ SPTW.*? \|\/\/g;
  \$o =~s\/ in Bix.*? \|\/ |\/g;
  \$o =~s\/ Visual B.*? \|\/\/g;
  \$o =~s\/ Zero Kelvin\/\n\/g;
  \$o =~s\/\|\|\/|\/g;
  \$o =~s\/\|\/·\/g;
  \"\nSkills:\" . \$o
/es" output.txt

perl -0777 -pi -e 's/ · Skills//g' output.txt
perl -0777 -pi -e 's/\n\s+Native/: Native/g' output.txt

perl -0777 -pi -e 's/r\n#/r\n\n#/g' output.txt
perl -0777 -pi -e 's/\n\n\*/\n*/g' output.txt

perl -0777 -pi -e "s/\nAbout\n.*?\nDeveloper/
  my \$o = $& =~ s\/\n+\/\n\/rg;
  \$o =~ s\/\nDev\/\n\nDev\/;
  \$o
/es" output.txt

perl -0777 -pi -e "s/\nDeveloper\n.*?\nComposer/
  my \$o = $& =~ s\/\n+\/\n\/rg;
  \$o =~ s\/\nComp\/\n\nComp\/;
  \$o
/es" output.txt

perl -0777 -pi -e 's/ <--is.*//g' output.txt
perl -0777 -pi -e 's/\nCataloguing/Cataloguing/g' output.txt
perl -0777 -pi -e 's/\n\n\s{8}Created/\n        Created/g' output.txt
perl -0777 -pi -e 's/Paulo Selected.*?Sound/Paulo\n    Sound/g' output.txt
perl -0777 -pi -e 's/ - Selected/\n        Selected/g' output.txt
perl -0777 -pi -e 's/3Skil.*//g' output.txt
perl -0777 -pi -e 's/ {8}Complete/    Complete/g' output.txt
perl -0777 -pi -e 's/ {8}Data Science/    Data Science/g' output.txt
perl -0777 -pi -e 's/Company-/Company -/g' output.txt

perl -0777 -pi -e 's/png\n\n/png\n        ...\n\n/g' output.txt

cp output.txt FlavioCarraraDeCapua_CV.txt
rm tmp
rm output.txt
