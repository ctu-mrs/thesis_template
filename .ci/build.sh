#!/bin/bash

set -e

sudo apt -y update

# general stuff for latex
sudo apt-get -y install texlive texlive-latex-extra texlive-lang-czechslovak texlive-science texlive-pstricks latexmk texmaker texlive-font-utils texlive-fonts-extra texlive-bibtex-extra biber okular pdf-presenter-console dvipng sketch

# needed for the CI
sudo apt -y install poppler-utils imagemagick

mkdir -p output

pdflatex -interaction=nonstopmode dissertation.tex
pdftoppm -jpeg dissertation.pdf dissertation_thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x1 dissertation_montage.jpg
convert montage.jpg -resize 1280 -quality 80 dissertation_montage-0.jpg
mv main.pdf output/dissertation_thesis_template.pdf
mv montage.jpg output/dissertation_thumbnail.jpg

# pdflatex -interaction=nonstopmode bachelor.tex
# pdftoppm -jpeg bachelor.pdf bachelor_thumbnail.jpg
# montage *.jpg -mode Concatenate -tile 3x1 bachelor_montage.jpg
# convert montage.jpg -resize 1280 -quality 80 bachelor_montage-0.jpg
# mv main.pdf output/bachelor_thesis_template.pdf
# mv montage.jpg output/bachelor_thumbnail.jpg

# pdflatex -interaction=nonstopmode master.tex
# pdftoppm -jpeg master.pdf master_thumbnail.jpg
# montage *.jpg -mode Concatenate -tile 3x1 master_montage.jpg
# convert montage.jpg -resize 1280 -quality 80 master_montage-0.jpg
# mv main.pdf output/master_thesis_template.pdf
# mv montage.jpg output/master_thumbnail.jpg
