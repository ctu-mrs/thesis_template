#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
REPO_ROOT=`dirname "$0"`
REPO_ROOT=`( cd "$REPO_ROOT/.." && pwd )`

sudo apt -y update
sudo apt-get -y install texlive texlive-latex-extra texlive-lang-czechslovak texlive-science texlive-pstricks latexmk texmaker texlive-font-utils texlive-fonts-extra texlive-bibtex-extra biber okular pdf-presenter-console dvipng sketch
sudo apt -y install poppler-utils imagemagick

BACHELOR_DIR=$REPO_ROOT/bachelor_thesis
MASTER_DIR=$REPO_ROOT/master_thesis
PHD_DIR=$REPO_ROOT/phd_thesis

[ -e $REPO_ROOT/output ] && rm -rf $REPO_ROOT/output
[ -e $REPO_ROOT/master_output ] && rm -rf $REPO_ROOT/master_output

mkdir -p $REPO_ROOT/output
mkdir -p $REPO_ROOT/master_output

OUTPUT_DIR=$REPO_ROOT/output
MASTER_OUTPUT_DIR=$REPO_ROOT/master_output

cd $BACHELOR_DIR
rm -rf build
make
cd build
pdftoppm -jpeg main.pdf bachelor_thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x1 bachelor_montage.jpg
convert bachelor_montage-0.jpg -resize 1280 -quality 80 bachelor_montage-0.jpg
mv main.pdf $OUTPUT_DIR/bachelor_thesis_template.pdf
mv bachelor_montage-0.jpg $OUTPUT_DIR/bachelor_thesis_thumbnail.jpg
cd $BACHELOR_DIR
rm -rf build

cd $MASTER_DIR
rm -rf build
make
cd build
pdftoppm -jpeg main.pdf master_thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x1 master_montage.jpg
convert master_montage-0.jpg -resize 1280 -quality 80 master_montage-0.jpg
mv main.pdf $OUTPUT_DIR/master_thesis_template.pdf
mv master_montage-0.jpg $OUTPUT_DIR/master_thesis_thumbnail.jpg
cd $MASTER_DIR
rm -rf build

cd $PHD_DIR
rm -rf build
make
cd build
pdftoppm -jpeg main.pdf phd_thumbnail.jpg
montage *.jpg -mode Concatenate -tile 3x1 phd_montage.jpg
convert phd_montage-0.jpg -resize 1280 -quality 80 phd_montage-0.jpg
mv main.pdf $OUTPUT_DIR/phd_thesis_template.pdf
mv phd_montage-0.jpg $OUTPUT_DIR/phd_thesis_thumbnail.jpg
cd $PHD_DIR
rm -rf build

## --------------------------------------------------------------
## |           copy stuff to the master output folder           |
## --------------------------------------------------------------

cd $REPO_ROOT

rsync -vRP --copy-links README.md $MASTER_OUTPUT_DIR/
rsync -vRP --copy-links -r bachelor_thesis $MASTER_OUTPUT_DIR/
rsync -vRP --copy-links -r master_thesis $MASTER_OUTPUT_DIR/
rsync -vRP --copy-links -r phd_thesis $MASTER_OUTPUT_DIR/
