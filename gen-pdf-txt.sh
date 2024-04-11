#!/bin/bash
# Depends on: pandoc texlive-latex-base texlive-latex-recommended

infile="README.md"
pdffile="Flávio Carrara - CV.pdf"
txtfile="Flávio Carrara - CV.txt"
linkedin_edit_page="https://www.linkedin.com/in/flaviocarrara/edit/forms/summary/new/?profileFormEntryPoint=PROFILE_SECTION"
linkedinfile="linkedin.md"
tmpfile="tmpfile.md"

function _ask() {
	echo -n "$1 [y/N] ";
	read answer;
	return $([ "$answer" != "${answer#[Yy]}" ]);
}

echo "---
header-includes:
 - \usepackage{lmodern}
 - \newcommand{\changefont}{\fontsize{9.0}{15.12}\selectfont}
 - \usepackage[a4paper, top=1.68cm, bottom=1cm, left=1cm, right=2.52cm]{geometry}
 - \pagestyle{empty}
 - \usepackage{setspace}
 - \setstretch{0.9}
 - \usepackage{parskip}
 - \hypersetup{
    pdftitle={Flávio Carrara De Capua},
    pdfsubject={Curriculum Vitae},
    pdfauthor={fde-capu},
    pdfkeywords={Computer, Software, Development, Composition, Music, Services}
  }
---
\changefont
" > "$tmpfile"

#####

cat "$infile" > "$txtfile";
echo "$txtfile generated."

cat "$infile" >> "$tmpfile";
pandoc "$tmpfile" -o "$pdffile"
echo "$pdffile generated."

rm "$tmpfile"

# Generate Linkedin with character count limitation:

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

head -n -4 $tmpfile > $linkedinfile

rm $tmpfile

bytes=`du -b $linkedinfile | awk '{print $1}'`
if [[ $bytes -gt 2600 ]] ; then
	echo "$linkedinfile: $bytes (max: 2600) fail.";
else
	echo "$linkedinfile: $bytes ok (max:2600).";
fi;

###

_ask "Open LinkedIn update page?" && openli="true"
_ask "Commit changes to GitHub?" && gitcom="true"

if [[ "$openli" ]]; then
	xclip -selection clipboard < "$linkedinfile"; \
	echo "LinkedIn content copied to clipboard."; \
	google-chrome "$linkedin_edit_page" &
fi

if [[ "$gitcom" ]]; then
	git commit -a && git push
fi

xdg-open .
xdg-open "$pdffile"
