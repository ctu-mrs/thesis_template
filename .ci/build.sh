#!/bin/bash

set -e

sudo apt -y update

# general stuff for latex
sudo apt-get -y install texlive texlive-latex-extra texlive-lang-czechslovak texlive-science texlive-pstricks latexmk texmaker texlive-font-utils texlive-fonts-extra texlive-bibtex-extra biber okular pdf-presenter-console dvipng sketch

# needed for the CI
sudo apt -y install poppler-utils imagemagick

PHD_DIR=`cd phd_thesis && pwd`
BACHELOR_DIR=`cd bachelor_thesis && pwd`
MASTER_DIR=`cd master_thesis && pwd`

mkdir -p output
OUTPUT_DIR=`cd output && pwd`

cd $PHD_DIR
make && make bib && make && make
pdftoppm -jpeg main.pdf phd_thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x1 phd_montage.jpg
convert phd_montage-0.jpg -resize 1280 -quality 80 phd_montage-0.jpg
mv phd.pdf $OUTPUT_DIR/phd_thesis_template.pdf
mv phd_montage-0.jpg $OUTPUT_DIR/phd_thumbnail.jpg
