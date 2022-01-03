#!/bin/bash

set -e

sudo apt -y update
sudo apt-get -y install texlive texlive-latex-extra texlive-lang-czechslovak texlive-science texlive-pstricks latexmk texmaker texlive-font-utils texlive-fonts-extra texlive-bibtex-extra biber okular pdf-presenter-console dvipng sketch

pdflatex -interaction=nonstopmode main.tex
pdftoppm -jpeg main.pdf thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x2 montage.jpg
convert montage.jpg -resize 1280 -quality 80 montage.jpg
mkdir -p output
mv main.pdf output/thesis_template.pdf
mv montage.jpg output/thumbnail.jpg
