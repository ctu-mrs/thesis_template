#!/bin/bash

set -e

MY_PATH=$( pwd )

replace_links_with_files() {

  LOCATION=$( cd "$1" && pwd)

  for f in $(find $LOCATION -maxdepth 1 -type l); do
    cp -r --remove-destination $(readlink -e $f) $f
  done
}

sudo apt -y update

# general stuff for latex
sudo apt-get -y install texlive texlive-latex-extra texlive-lang-czechslovak texlive-science texlive-pstricks latexmk texmaker texlive-font-utils texlive-fonts-extra texlive-bibtex-extra biber okular pdf-presenter-console dvipng sketch

# needed for the CI
sudo apt -y install poppler-utils imagemagick

PHD_DIR=`cd phd_thesis && pwd`
BACHELOR_DIR=`cd bachelor_thesis && pwd`
MASTER_DIR=`cd master_thesis && pwd`

mkdir -p output
mkdir -p master_output

OUTPUT_DIR=`cd output && pwd`
MASTER_OUTPUT_DIR=`cd master_output && pwd`

cd $PHD_DIR
make && make bib && make && make
pdftoppm -jpeg main.pdf phd_thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x1 phd_montage.jpg
convert phd_montage-0.jpg -resize 1280 -quality 80 phd_montage-0.jpg
mv main.pdf $OUTPUT_DIR/phd_thesis_template.pdf
mv phd_montage-0.jpg $OUTPUT_DIR/phd_thesis_thumbnail.jpg

cd $BACHELOR_DIR
make && make bib && make && make
pdftoppm -jpeg main.pdf bachelor_thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x1 bachelor_montage.jpg
convert bachelor_montage-0.jpg -resize 1280 -quality 80 bachelor_montage-0.jpg
mv main.pdf $OUTPUT_DIR/bachelor_thesis_template.pdf
mv bachelor_montage-0.jpg $OUTPUT_DIR/bachelor_thesis_thumbnail.jpg

cd $MASTER_DIR
make && make bib && make && make
pdftoppm -jpeg main.pdf master_thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x1 master_montage.jpg
convert master_montage-0.jpg -resize 1280 -quality 80 master_montage-0.jpg
mv main.pdf $OUTPUT_DIR/master_thesis_template.pdf
mv master_montage-0.jpg $OUTPUT_DIR/master_thesis_thumbnail.jpg

## --------------------------------------------------------------
## |           copy stuff to the master output folder           |
## --------------------------------------------------------------

cp $MY_PATH

cp README.md $MASTER_OUTPUT_DIR/
cp -r bachelor_thesis $MASTER_OUTPUT_DIR/
cp -r master_thesis $MASTER_OUTPUT_DIR/
cp -r phd_thesis $MASTER_OUTPUT_DIR/

replace_links_with_files $MASTER_OUTPUT_DIR/bachelor_thesis
replace_links_with_files $MASTER_OUTPUT_DIR/master_thesis
replace_links_with_files $MASTER_OUTPUT_DIR/phd_thesis
