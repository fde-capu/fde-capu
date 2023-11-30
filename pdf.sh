#!/bin/bash
# Depends on: pandoc texlive-latex-base texlive-latex-recommended

infile="README.md"
tmpfile="tmpfile.md"
outfile="Flávio Carrara - CV.pdf"

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


cat "$infile" >> "$tmpfile";

pandoc "$tmpfile" -o "$outfile"
xdg-open "$outfile";
