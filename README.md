# Bachelor / Master / Ph.D. Thesis template [![Build Status](https://github.com/ctu-mrs/thesis_template/workflows/CI/badge.svg)](https://github.com/ctu-mrs/thesis_template/actions)

## Click the thumbnail to download the pdf

### Bachelor

[![This should be a thumbnail](https://github.com/ctu-mrs/thesis_template/raw/gh-pages/bachelor_thesis_thumbnail.jpg)](https://github.com/ctu-mrs/thesis_template/raw/gh-pages/bachelor_thesis_template.pdf)

### Master

[![This should be a thumbnail](https://github.com/ctu-mrs/thesis_template/raw/gh-pages/master_thesis_thumbnail.jpg)](https://github.com/ctu-mrs/thesis_template/raw/gh-pages/master_thesis_template.pdf)

### Dissertation

[![This should be a thumbnail](https://github.com/ctu-mrs/thesis_template/raw/gh-pages/phd_thesis_thumbnail.jpg)](https://github.com/ctu-mrs/thesis_template/raw/gh-pages/phd_thesis_template.pdf)

## Build using supplied Makefile

Build the pdf by running
```bash
make
```
in the thesis's folder.
The output will appear in the `build` subfolder.

## Switching between print and screen versions

The template supports outputting of two different files.

The **print** format has assymetric margins to compensate for the spine of the thesis.
Moreover, the **print** version adds white pages whenever neccessary (new chapters and standalone pages, e.g., copyright notice).

The **screen** version has symmetric margins and no filler white pages.

The print version is enabled by uncommenting the first line in the `main.tex` document:
```latex
\newcommand*{\printversion}{}%
```
