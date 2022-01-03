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
convert dissertation_montage-0.jpg -resize 1280 -quality 80 dissertation_montage-0.jpg
mv dissertation.pdf output/dissertation_thesis_template.pdf
mv dissertation_montage-0.jpg output/dissertation_thumbnail.jpg
